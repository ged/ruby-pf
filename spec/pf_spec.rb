#!/usr/bin/env rspec -cfd
#encoding: utf-8

require_relative 'spec_helper'

require 'rspec'
require 'pf'

# This test suite uses a bunch of fixtured data for unit tests to avoid the need
# to run as root and to avoid actually changing the firewall as the tests are
# running. See the `fixture` function in the spec_helper and the `make-fixture` command
# in the .pryrc for details.

describe PF do

	# ioctl(2) return codes
	SUCCESS = 0
	FAILURE = -1

	before( :each ) do
		PF.device = nil
	end


	it "opens the PF pseudo-device if it hasn't already" do
		fileobj = instance_double( File, "PF pseudo-device" )
		expect( File ).to receive( :open ).with( PF::PSEUDODEVICE_PATH, 'w', encoding: 'binary' ).
			and_return( fileobj )

		expect( PF.device ).to be( fileobj )
	end


	it "memoizes the PF filehandle" do
		expect( File ).to receive( :open ).once.and_return( :the_file )

		3.times do
			PF.device
		end
	end


	describe "interacting with the PF pseudo-device" do

		before( :each ) do
			PF.device = fixtured_pseudodevice
		end


		it "can fetch the packet filter statistics" do
			expect( PF.device ).to receive( :ioctl ) do |request, buffer|
				expect( request ).to eq( PF::DIOCGETSTATUS )
				buffer.replace( fixture :getstatus )
				SUCCESS
			end

			results = PF.status

			expect( results ).to be_a( PF::Status )
		end

	end


end