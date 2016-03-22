# -*- ruby -*-
#encoding: utf-8

require 'bindata'

require 'pf' unless defined?( PF )


# A PF Rule structure. This corresponds to the +pf_rule+ struct.
class PF::Rule < BinData::Record


	#
	# BinData declarations
	#
	endian :little


	# struct pf_rule {
	#     struct pf_rule_addr  src;
	#     struct pf_rule_addr  dst;
	# #define PF_SKIP_IFP     0
	# #define PF_SKIP_DIR     1
	# #define PF_SKIP_AF      2
	# #define PF_SKIP_PROTO       3
	# #define PF_SKIP_SRC_ADDR    4
	# #define PF_SKIP_SRC_PORT    5
	# #define PF_SKIP_DST_ADDR    6
	# #define PF_SKIP_DST_PORT    7
	# #define PF_SKIP_COUNT       8
	#     union pf_rule_ptr    skip[PF_SKIP_COUNT];
	# #define PF_RULE_LABEL_SIZE   64
	#     char             label[PF_RULE_LABEL_SIZE];
	# #define PF_QNAME_SIZE        64
	#     char             ifname[IFNAMSIZ];
	#     char             qname[PF_QNAME_SIZE];
	#     char             pqname[PF_QNAME_SIZE];
	# #define PF_TAG_NAME_SIZE     64
	#     char             tagname[PF_TAG_NAME_SIZE];
	#     char             match_tagname[PF_TAG_NAME_SIZE];
	#
	#     char             overload_tblname[PF_TABLE_NAME_SIZE];
	#
	#     TAILQ_ENTRY(pf_rule)     entries;
	# #if !defined(__LP64__)
	#     u_int32_t        _pad[2];
	# #endif /* !__LP64__ */
	#     struct pf_pool       rpool;
	#
	#     u_int64_t        evaluations;
	#     u_int64_t        packets[2];
	#     u_int64_t        bytes[2];
	#
	#     u_int64_t        ticket;
	# #define PF_OWNER_NAME_SIZE   64
	#     char             owner[PF_OWNER_NAME_SIZE];
	#     u_int32_t        priority;
	#
	# #ifdef KERNEL
	#     struct pfi_kif      *kif        __attribute__((aligned(8)));
	# #else /* !KERNEL */
	#     void            *kif        __attribute__((aligned(8)));
	# #endif /* !KERNEL */
	#     struct pf_anchor    *anchor     __attribute__((aligned(8)));
	# #ifdef KERNEL
	#     struct pfr_ktable   *overload_tbl   __attribute__((aligned(8)));
	# #else /* !KERNEL */
	#     void            *overload_tbl   __attribute__((aligned(8)));
	# #endif /* !KERNEL */
	#
	#     pf_osfp_t        os_fingerprint __attribute__((aligned(8)));
	#
	#     unsigned int         rtableid;
	#     u_int32_t        timeout[PFTM_MAX];
	#     u_int32_t        states;
	#     u_int32_t        max_states;
	#     u_int32_t        src_nodes;
	#     u_int32_t        max_src_nodes;
	#     u_int32_t        max_src_states;
	#     u_int32_t        max_src_conn;
	#     struct {
	#         u_int32_t       limit;
	#         u_int32_t       seconds;
	#     }            max_src_conn_rate;
	#     u_int32_t        qid;
	#     u_int32_t        pqid;
	#     u_int32_t        rt_listid;
	#     u_int32_t        nr;
	#     u_int32_t        prob;
	#     uid_t            cuid;
	#     pid_t            cpid;
	#
	#     u_int16_t        return_icmp;
	#     u_int16_t        return_icmp6;
	#     u_int16_t        max_mss;
	#     u_int16_t        tag;
	#     u_int16_t        match_tag;
	#
	#     struct pf_rule_uid   uid;
	#     struct pf_rule_gid   gid;
	#
	#     u_int32_t        rule_flag;
	#     u_int8_t         action;
	#     u_int8_t         direction;
	#     u_int8_t         log;
	#     u_int8_t         logif;
	#     u_int8_t         quick;
	#     u_int8_t         ifnot;
	#     u_int8_t         match_tag_not;
	#     u_int8_t         natpass;
	#
	# #define PF_STATE_NORMAL     0x1
	# #define PF_STATE_MODULATE   0x2
	# #define PF_STATE_SYNPROXY   0x3
	#     u_int8_t         keep_state;
	#     sa_family_t      af;
	#     u_int8_t         proto;
	#     u_int8_t         type;
	#     u_int8_t         code;
	#     u_int8_t         flags;
	#     u_int8_t         flagset;
	#     u_int8_t         min_ttl;
	#     u_int8_t         allow_opts;
	#     u_int8_t         rt;
	#     u_int8_t         return_ttl;
	#
	# /* service class categories */
	# #define SCIDX_MASK      0x0f
	# #define SC_BE           0x10
	# #define SC_BK_SYS       0x11
	# #define SC_BK           0x12
	# #define SC_RD           0x13
	# #define SC_OAM          0x14
	# #define SC_AV           0x15
	# #define SC_RV           0x16
	# #define SC_VI           0x17
	# #define SC_VO           0x18
	# #define SC_CTL          0x19
	#
	# /* diffserve code points */
	# #define DSCP_MASK       0xfc
	# #define DSCP_CUMASK     0x03
	# #define DSCP_EF         0xb8
	# #define DSCP_AF11       0x28
	# #define DSCP_AF12       0x30
	# #define DSCP_AF13       0x38
	# #define DSCP_AF21       0x48
	# #define DSCP_AF22       0x50
	# #define DSCP_AF23       0x58
	# #define DSCP_AF31       0x68
	# #define DSCP_AF32       0x70
	# #define DSCP_AF33       0x78
	# #define DSCP_AF41       0x88
	# #define DSCP_AF42       0x90
	# #define DSCP_AF43       0x98
	# #define AF_CLASSMASK        0xe0
	# #define AF_DROPPRECMASK     0x18
	#     u_int8_t         tos;
	#     u_int8_t         anchor_relative;
	#     u_int8_t         anchor_wildcard;
	#
	# #define PF_FLUSH        0x01
	# #define PF_FLUSH_GLOBAL     0x02
	#     u_int8_t         flush;
	#
	#     u_int8_t        proto_variant;
	#     u_int8_t        extfilter; /* Filter mode [PF_EXTFILTER_xxx] */
	#     u_int8_t        extmap;    /* Mapping mode [PF_EXTMAP_xxx] */
	#     u_int32_t               dnpipe;
	#     u_int32_t               dntype;
	# };


	BinData::RegisteredClasses.register( 'pf_rule', self )


end # class PF::PfiocRule

