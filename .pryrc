#!/usr/bin/ruby -*- ruby -*-

$LOAD_PATH.unshift( 'lib' )

require 'fileutils'
require 'pathname'

SPEC_DATA_DIR = Pathname( __FILE__ ).dirname + 'spec/data'
FIXTURE_OWNER = File.stat( __FILE__ ).uid
FIXTURE_GROUP = File.stat( __FILE__ ).gid

command_set = Pry::CommandSet.new do

	create_command "make-fixture" do |command, type=:default|
		description "Fetch the data for the specified COMMAND and TYPE and save it as a fixture"


		### Pry command API -- set up available options in +opt+.
		def options( opt )
			opt.on :f, :force, "Replace an existing fixture."
		end


		### Pry command API -- run the command.
		def process( request, type=:default )
			self.check_euid

			name, numeric_request = PF.normalize_ioctl( request )

			dir = SPEC_DATA_DIR + name.to_s.downcase
			file = dir + "#{type}.dat"
			FileUtils.mkdir_p( dir, verbose: true )
			FileUtils.chown_R( FIXTURE_OWNER, FIXTURE_GROUP, dir, verbose: true )

			if file.exist? && !opts.force?
				output.puts "%s already exists." % [ file ]
				output.puts "Run the command again with --force if you want to replace it."
			else
				buf = ''
				PF.device.ioctl( numeric_request, buf )

				output.print "Writing %d bytes to %s..." % [ buf.bytesize, file ]
				file.open( 'w', 0644, encoding: 'binary' ) do |fh|
					fh.write( buf )
				end
				output.puts " done."

				FileUtils.chown( FIXTURE_OWNER, FIXTURE_GROUP, file, verbose: true )
			end
		end


		### Check to be sure the process is running as root; warn if it is not, since the
		### open call will likely fail.
		def check_euid
			return if Process.euid.zero?
			output.puts "This will likely fail, as you're not running as root, but I'll try anyway."
		end

	end

end


begin
	require 'pf'
rescue Exception => e
	$stderr.puts "Ack! Libraries failed to load: #{e.message}\n\t" +
		e.backtrace.join( "\n\t" )
end


Pry::Commands.import( command_set )

