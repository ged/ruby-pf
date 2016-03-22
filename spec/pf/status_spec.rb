#!/usr/bin/env rspec -cfd

require_relative '../spec_helper'

require 'pf/status'


describe PF::Status do

	# Ensure nothing actually ioctls /dev/pf
	before( :each ) do
		PF.device = fixtured_pseudodevice
	end


	it "can read the pf_status struct returned from DIOCGETSTATUS" do
		data = fixture :getstatus
		result = described_class.read( data )

		expect( result ).to be_a( described_class )
	end

	context "a parsed status" do

		let( :status ) { described_class.read(fixture :getstatus) }


		it "contains the reason counters" do
			expect( status.counters ).to be_an( BinData::Array ).and( all be_a(BinData::Uint64le) )
			expect( status.counters[0] ).to eq( 948772 )
		end


		it "contains the other counters" do
			expect( status.lcounters ).to be_an( BinData::Array ).and( all be_a(BinData::Uint64le) )
		end


		it "contains the state table counters" do
			expect( status.fcounters ).to be_an( BinData::Array ).and( all be_a(BinData::Uint64le) )
		end


		it "contains the source node state counters" do
			expect( status.scounters ).to be_an( BinData::Array ).and( all be_a(BinData::Uint64le) )
		end


		it "contains the source node state counters" do
			expect( status.scounters ).to be_an( BinData::Array ).and( all be_a(BinData::Uint64le) )
		end


		it "contains the passed packet counters" do
			expect( status.pcounters ).to be_an( BinData::Array ).and( have_attributes(length: 2) )
			expect( status.pcounters[0] ).to be_an( BinData::Array ).and( have_attributes(length: 2) )
			expect( status.pcounters[1] ).to be_an( BinData::Array ).and( have_attributes(length: 2) )
			expect( status.pcounters[0][0] ).to be_an( BinData::Array ).and( have_attributes(length: 3) )
			expect( status.pcounters[0][1] ).to be_an( BinData::Array ).and( have_attributes(length: 3) )
			expect( status.pcounters[1][0] ).to be_an( BinData::Array ).and( have_attributes(length: 3) )
			expect( status.pcounters[1][1] ).to be_an( BinData::Array ).and( have_attributes(length: 3) )
		end


		it "contains the blocked packet counters" do
			expect( status.bcounters ).to be_an( BinData::Array ).and( have_attributes(length: 2) )
			expect( status.bcounters[0] ).to be_an( BinData::Array ).and( have_attributes(length: 2) )
			expect( status.bcounters[1] ).to be_an( BinData::Array ).and( have_attributes(length: 2) )
		end


		it "contains the stateid" do
			expect( status.stateid ).to be_a( BinData::Uint64le )
		end


		it "contains the flag that indicates whether or not it's running" do
			expect( status.running ).to be_a( BinData::Uint32le )
		end


		it "contains the count of the number of states" do
			expect( status.states ).to be_a( BinData::Uint32le )
		end


		it "contains the count of number of source nodes" do
			expect( status.src_nodes ).to be_a( BinData::Uint32le )
		end


		it "contains the epoch time of the last time its counters were reset" do
			expect( status.since ).to be_a( BinData::Uint64le )
		end


		it "contains the debug level" do
			expect( status.debug ).to be_a( BinData::Uint32le )
		end


		it "contains the hostid" do
			expect( status.hostid ).to be_a( BinData::Uint32le )
		end


		it "contains the interface name" do
			expect( status.ifname ).to be_a( BinData::Stringz )
		end


		it "contains the checksum (?)" do
			expect( status.pf_chksum ).to be_an( BinData::Array )
		end

	end


end

