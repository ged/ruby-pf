# -*- ruby -*-
#encoding: utf-8

require 'bindata'

require 'pf' unless defined?( PF )


# A PF status snapshot. This corresponds to the +pf_status+ struct.
class PF::Status < BinData::Record

	# These don't exist in pfvar.h, but I'm extrapolating them so the higher-level
	# code can all follow the same convention.

	# Names for fcounters
	FCNT_NAMES = %w[ state_search state_insert state_removals ]

	# Names for scounters
	SCNT_NAMES = %w[src_node_search src_node_insert src_node_removals]


	#
	# BinData declarations
	#
	endian :little

	array :counters, type: :uint64, initial_length: PF::PFRES_MAX
	array :lcounters, type: :uint64, initial_length: PF::LCNT_MAX
	array :fcounters, type: :uint64, initial_length: PF::FCNT_MAX
	array :scounters, type: :uint64, initial_length: PF::SCNT_MAX
	array :pcounters, initial_length: 2 do
		array initial_length: 2 do
			array initial_length: 3 do
				uint64
			end
		end
	end
	array :bcounters, initial_length: 2 do
		array initial_length: 2 do
			uint64
		end
	end
	uint64 :stateid
	uint32 :running
	uint32 :states
	uint32 :src_nodes
	uint64 :since, byte_align: 8
	uint32 :debug
	uint32 :hostid
	stringz :ifname, length: PF::IFNAMSIZ
	array :pf_chksum, type: :uint8, initial_length: PF::PF_MD5_DIGEST_LENGTH

	rest :remainder


	#
	# Higher-level API
	#

	### Return the +counters+ as a Hash keyed by the name of the counter.
	def counters_hash
		return symbolize( PF::PFRES_NAMES ).zip( self.counters ).to_h
	end


	### Return the +lcounters+ as a Hash keyed by the name of the counter.
	def lcounters_hash
		return symbolize( PF::LCNT_NAMES ).zip( self.lcounters ).to_h
	end


	### Return the +fcounters+ as a Hash keyed by the name of the counter.
	def fcounters_hash
		return symbolize( PF::Status::FCNT_NAMES ).zip( self.fcounters ).to_h
	end


	### Return the +scounters+ as a Hash keyed by the name of the counter.
	def scounters_hash
		return symbolize( PF::Status::SCNT_NAMES ).zip( self.scounters ).to_h
	end


	### Return the Status as a human-readable string suitable for debugging.
	def inspect
		return "#<%p:%#016x %p>" % [
			self.class,
			self.object_id * 2,
			self.snapshot
		]
	end


	#######
	private
	#######

	### Turn the Strings in the specified +array+ into Symbols, substituting underscore characters
	### for non-word characters.
	def symbolize( array )
		return array.map {|str| str.gsub(/\W+/, '_').to_sym }
	end

end # class PF::Status

