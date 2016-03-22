# -*- ruby -*-
#encoding: utf-8

require 'loggability'

# Packet-filter functions for Ruby
module PF
	extend Loggability


	# Loggability API -- set up a logger for the library
	log_as :pf


	# Load the PF extension
	require 'pf_ext'


	# Package version
	VERSION = '0.0.1'

	# Version control revision
	REVISION = %q$Revision$

	# The path to the PF pseudo-device.
	PSEUDODEVICE_PATH = '/dev/pf'

	# The list of supported ioctl requests
	IOCTL_REQUEST_NAMES = PF.constants.grep( /^DIOC[A-Z]+/ )

	# A Hash of the raw request numbers of the supported ioctl requests and the
	# corresponding request name
	IOCTL_REQUEST_NUMBERS = IOCTL_REQUEST_NAMES.each_with_object({}) do |request, hash|
		num = PF.const_get( request )
		hash[ num ] = request
	end


	# Memoization variable for IO open to PSEUDODEVICE_PATH
	@pf_device = nil


	# Load everything else on demand
	autoload :Status, 'pf/status'


	### Get a File object open to the `/dev/pf` device. This usually requires that
	### the process be running as root.
	def self::device
		unless @pf_device
			@pf_device = File.open( PF::PSEUDODEVICE_PATH, 'w', encoding: 'binary' )
		end
		return @pf_device
	end


	### Set the File object used to manipulate PF to +new_device+. This is used mostly
	### in testing, but could also be used to set a File after dropping privileges.
	def self::device=( new_device )
		@pf_device = new_device
	end


	### Normalize the given +request+ to a name (as a Symbol) and a numeric ioctl request. Accepts
	### the name of the ioctl as either a String or a Symbol, with or without the 'DIOC' prefix, or
	### the numeric request.
	def self::normalize_ioctl( request )
		name = number = nil

		case request
		when Integer
			name = PF::IOCTL_REQUEST_NUMERS[ request ] or
				raise "%d is not a supported PF ioctl!" % [ request ]
		when String, Symbol
			request = "DIOC#{request}" unless request =~ /^DIOC/i
			name = request.upcase.to_sym
			raise "%s is not a supported PF ioctl!" unless
				PF::IOCTL_REQUEST_NAMES.include?( name )
			number = PF.const_get( name ) or abort "Couldn't fetch #{name}"
		else
			raise "%p is not a supported PF ioctl. See PF::IOCTL_REQUEST_NAMES for the list."
		end

		return name, number
	end


	### Get the internal packet filter statistics as a packed binary String.
	def self::raw_status
		buf = ''
		PF.device.ioctl( PF::DIOCGETSTATUS, buf )
		return buf
	end


	### Return the internal packet filter statistics as a PF::Status.
	def self::status
		return PF::Status.read( PF.raw_status )
	end


end # module PF

