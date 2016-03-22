# -*- ruby -*-
#encoding: utf-8

require 'bindata'

require 'pf' unless defined?( PF )


# A PF ioctl Rule structure. This corresponds to the +pfioc_rule+ struct.
class PF::IocRule < BinData::Record


	#
	# BinData declarations
	#
	endian :little

	# struct pfioc_rule {
	#     u_int32_t       action;
	#     u_int32_t       ticket;
	#     u_int32_t       pool_ticket;
	#     u_int32_t       nr;
	#     char            anchor[MAXPATHLEN];
	#     char            anchor_call[MAXPATHLEN];
	#     struct pf_rule  rule;
	# };

	uint32 :action
	uint32 :ticket
	uint32 :pool_ticket
	uint32 :nr

	stringz :anchor, length: PF::MAXPATHLEN
	stringz :anchor_call, length: PF::MAXPATHLEN

	pf_rule :rule

	rest :remainder

	BinData::RegisteredClasses.register( 'pfioc_rule', self )


end # class PF::PfiocRule

