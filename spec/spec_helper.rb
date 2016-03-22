# -*- ruby -*-
#encoding: utf-8

require 'simplecov' if ENV['COVERAGE']
require 'pathname'

require 'rspec'
require 'loggability/spechelpers'
require 'pf'

module PF::SpecHelpers

	DATA_DIR = Pathname( __FILE__ ).dirname + 'data'


	### Get an instance double that can stand in for the File opened to /dev/pf
	def fixtured_pseudodevice
		return instance_double( File, "PF pseudo-device" )
	end


	### Get fixtured PF ioctl output for the specified +request+, optionally qualified
	### by a particular +type+.
	def fixture( request, type=:default )
		name, _ = PF.normalize_ioctl( request )
		dir = DATA_DIR + name.to_s
		file = dir + "#{type}.dat"

		return file.read( encoding: 'binary' )
	end

end # module PF::SpecHelpers



# Configure RSpec
RSpec.configure do |config|
	config.run_all_when_everything_filtered = true
	config.filter_run :focus
	config.order = 'random'
	config.mock_with( :rspec ) do |mock|
		mock.syntax = :expect
	end

	config.include( Loggability::SpecHelpers )
	config.include( PF::SpecHelpers )
end


