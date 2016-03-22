/*
 * Ruby-PF
 * $Id$
 */

#include "pf_ext.h"


/*
 * document-class: PF
 *
 */
void Init_pf_ext()
{
	VALUE constant_value;
	const char *pfres_names[ PFRES_MAX + 1 ]           = PFRES_NAMES;
	const char *lcnt_names[ LCNT_MAX + 1 ]             = LCNT_NAMES;
	const char *pfudps_names[ PFUDPS_NSTATES + 1 ]     = PFUDPS_NAMES;
	const char *pfgre1s_names[ PFGRE1S_NSTATES + 1 ]   = PFGRE1S_NAMES;
	const char *pfesps_names[ PFESPS_NSTATES + 1 ]     = PFESPS_NAMES;
	const char *pfothers_names[ PFOTHERS_NSTATES + 1 ] = PFOTHERS_NAMES;

	rbpf_mPF = rb_define_module( "PF" );

	rb_define_const( rbpf_mPF, "PFRES_MATCH",     LONG2FIX(0) );
	rb_define_const( rbpf_mPF, "PFRES_BADOFF",    LONG2FIX(1) );
	rb_define_const( rbpf_mPF, "PFRES_FRAG",      LONG2FIX(2) );
	rb_define_const( rbpf_mPF, "PFRES_SHORT",     LONG2FIX(3) );
	rb_define_const( rbpf_mPF, "PFRES_NORM",      LONG2FIX(4) );
	rb_define_const( rbpf_mPF, "PFRES_MEMORY",    LONG2FIX(5) );
	rb_define_const( rbpf_mPF, "PFRES_TS",        LONG2FIX(6) );
	rb_define_const( rbpf_mPF, "PFRES_CONGEST",   LONG2FIX(7) );
	rb_define_const( rbpf_mPF, "PFRES_IPOPTIONS", LONG2FIX(8) );
	rb_define_const( rbpf_mPF, "PFRES_PROTCKSUM", LONG2FIX(9) );
	rb_define_const( rbpf_mPF, "PFRES_BADSTATE",  LONG2FIX(10) );
	rb_define_const( rbpf_mPF, "PFRES_STATEINS",  LONG2FIX(11) );
	rb_define_const( rbpf_mPF, "PFRES_MAXSTATES", LONG2FIX(12) );
	rb_define_const( rbpf_mPF, "PFRES_SRCLIMIT",  LONG2FIX(13) );
	rb_define_const( rbpf_mPF, "PFRES_SYNPROXY",  LONG2FIX(14) );
	rb_define_const( rbpf_mPF, "PFRES_DUMMYNET",  LONG2FIX(15) );
	rb_define_const( rbpf_mPF, "PFRES_MAX",       LONG2FIX(16) );

	constant_value = rb_ary_new2( PFRES_MAX );
	rb_define_const( rbpf_mPF, "PFRES_NAMES", constant_value );
	for ( int i = 0; i < PFRES_MAX; i++ ) {
		rb_ary_store( constant_value, i, rb_obj_freeze(rb_str_new2(pfres_names[i])) );
	}

	rb_define_const( rbpf_mPF, "LCNT_STATES", LONG2FIX(LCNT_STATES) );	/* states */
	rb_define_const( rbpf_mPF, "LCNT_SRCSTATES", LONG2FIX(LCNT_SRCSTATES) );	/* max-src-states */
	rb_define_const( rbpf_mPF, "LCNT_SRCNODES", LONG2FIX(LCNT_SRCNODES) );	/* max-src-nodes */
	rb_define_const( rbpf_mPF, "LCNT_SRCCONN", LONG2FIX(LCNT_SRCCONN) );	/* max-src-conn */
	rb_define_const( rbpf_mPF, "LCNT_SRCCONNRATE", LONG2FIX(LCNT_SRCCONNRATE) );	/* max-src-conn-rate */
	rb_define_const( rbpf_mPF, "LCNT_OVERLOAD_TABLE", LONG2FIX(LCNT_OVERLOAD_TABLE) );	/* entry added to overload table */
	rb_define_const( rbpf_mPF, "LCNT_OVERLOAD_FLUSH", LONG2FIX(LCNT_OVERLOAD_FLUSH) );	/* state entries flushed */
	rb_define_const( rbpf_mPF, "LCNT_MAX", LONG2FIX(LCNT_MAX) );	/* total+1 */

	constant_value = rb_ary_new2( LCNT_MAX );
	rb_define_const( rbpf_mPF, "LCNT_NAMES", constant_value );
	for ( int i = 0; i < LCNT_MAX; i++ ) {
		rb_ary_store( constant_value, i, rb_obj_freeze(rb_str_new2(lcnt_names[i])) );
	}

	/* UDP state enumeration */
	rb_define_const( rbpf_mPF, "PFUDPS_NO_TRAFFIC", LONG2FIX(PFUDPS_NO_TRAFFIC) );
	rb_define_const( rbpf_mPF, "PFUDPS_SINGLE", LONG2FIX(PFUDPS_SINGLE) );
	rb_define_const( rbpf_mPF, "PFUDPS_MULTIPLE", LONG2FIX(PFUDPS_MULTIPLE) );
	rb_define_const( rbpf_mPF, "PFUDPS_NSTATES", LONG2FIX(PFUDPS_NSTATES) );	/* number of state levels */

	constant_value = rb_ary_new2( PFUDPS_NSTATES );
	rb_define_const( rbpf_mPF, "PFUDPS_NAMES", constant_value );
	for ( int i = 0; i < PFUDPS_NSTATES; i++ ) {
		rb_ary_store( constant_value, i, rb_obj_freeze(rb_str_new2(pfudps_names[i])) );
	}

	/* GREv1 protocol state enumeration */
	rb_define_const( rbpf_mPF, "PFGRE1S_NO_TRAFFIC", LONG2FIX(PFGRE1S_NO_TRAFFIC) );
	rb_define_const( rbpf_mPF, "PFGRE1S_INITIATING", LONG2FIX(PFGRE1S_INITIATING) );
	rb_define_const( rbpf_mPF, "PFGRE1S_ESTABLISHED", LONG2FIX(PFGRE1S_ESTABLISHED) );
	rb_define_const( rbpf_mPF, "PFGRE1S_NSTATES", LONG2FIX(PFGRE1S_NSTATES) );

	constant_value = rb_ary_new2( PFGRE1S_NSTATES );
	rb_define_const( rbpf_mPF, "PFGRE1S_NAMES", constant_value );
	for ( int i = 0; i < PFGRE1S_NSTATES; i++ ) {
		rb_ary_store( constant_value, i, rb_obj_freeze(rb_str_new2(pfgre1s_names[i])) );
	}

	rb_define_const( rbpf_mPF, "PFESPS_NO_TRAFFIC", LONG2FIX(PFESPS_NO_TRAFFIC) );
	rb_define_const( rbpf_mPF, "PFESPS_INITIATING", LONG2FIX(PFESPS_INITIATING) );
	rb_define_const( rbpf_mPF, "PFESPS_ESTABLISHED", LONG2FIX(PFESPS_ESTABLISHED) );

	rb_define_const( rbpf_mPF, "PFESPS_NSTATES", LONG2FIX(PFESPS_NSTATES) );	/* number of state levels */

	constant_value = rb_ary_new2( PFESPS_NSTATES );
	rb_define_const( rbpf_mPF, "PFESPS_NAMES", constant_value );
	for ( int i = 0; i < PFESPS_NSTATES; i++ ) {
		rb_ary_store( constant_value, i, rb_obj_freeze(rb_str_new2(pfesps_names[i])) );
	}

	/* Other protocol state enumeration */
	rb_define_const( rbpf_mPF, "PFOTHERS_NO_TRAFFIC", LONG2FIX(PFOTHERS_NO_TRAFFIC) );
	rb_define_const( rbpf_mPF, "PFOTHERS_SINGLE", LONG2FIX(PFOTHERS_SINGLE) );
	rb_define_const( rbpf_mPF, "PFOTHERS_MULTIPLE", LONG2FIX(PFOTHERS_MULTIPLE) );

	rb_define_const( rbpf_mPF, "PFOTHERS_NSTATES", LONG2FIX(PFOTHERS_NSTATES) );	/* number of state levels */

	constant_value = rb_ary_new2( PFOTHERS_NSTATES );
	rb_define_const( rbpf_mPF, "PFOTHERS_NAMES", constant_value );
	for ( int i = 0; i < PFOTHERS_NSTATES; i++ ) {
		rb_ary_store( constant_value, i, rb_obj_freeze(rb_str_new2(pfothers_names[i])) );
	}

	rb_define_const( rbpf_mPF, "FCNT_STATE_SEARCH", LONG2FIX(FCNT_STATE_SEARCH) );
	rb_define_const( rbpf_mPF, "FCNT_STATE_INSERT", LONG2FIX(FCNT_STATE_INSERT) );
	rb_define_const( rbpf_mPF, "FCNT_STATE_REMOVALS", LONG2FIX(FCNT_STATE_REMOVALS) );
	rb_define_const( rbpf_mPF, "FCNT_MAX", LONG2FIX(FCNT_MAX) );

	rb_define_const( rbpf_mPF, "SCNT_SRC_NODE_SEARCH", LONG2FIX(SCNT_SRC_NODE_SEARCH) );
	rb_define_const( rbpf_mPF, "SCNT_SRC_NODE_INSERT", LONG2FIX(SCNT_SRC_NODE_INSERT) );
	rb_define_const( rbpf_mPF, "SCNT_SRC_NODE_REMOVALS", LONG2FIX(SCNT_SRC_NODE_REMOVALS) );
	rb_define_const( rbpf_mPF, "SCNT_MAX", LONG2FIX(SCNT_MAX) );

	/* ioctl actions */
	rb_define_const( rbpf_mPF, "DIOCSTART", LONG2FIX(DIOCSTART) );
	rb_define_const( rbpf_mPF, "DIOCSTOP", LONG2FIX(DIOCSTOP) );
	rb_define_const( rbpf_mPF, "DIOCADDRULE", LONG2FIX(DIOCADDRULE) );
	rb_define_const( rbpf_mPF, "DIOCGETSTARTERS", LONG2FIX(DIOCGETSTARTERS) );
	rb_define_const( rbpf_mPF, "DIOCGETRULES", LONG2FIX(DIOCGETRULES) );
	rb_define_const( rbpf_mPF, "DIOCGETRULE", LONG2FIX(DIOCGETRULE) );
	rb_define_const( rbpf_mPF, "DIOCSTARTREF", LONG2FIX(DIOCSTARTREF) );
	rb_define_const( rbpf_mPF, "DIOCSTOPREF", LONG2FIX(DIOCSTOPREF) );
	rb_define_const( rbpf_mPF, "DIOCCLRSTATES", LONG2FIX(DIOCCLRSTATES) );
	rb_define_const( rbpf_mPF, "DIOCGETSTATE", LONG2FIX(DIOCGETSTATE) );
	rb_define_const( rbpf_mPF, "DIOCSETSTATUSIF", LONG2FIX(DIOCSETSTATUSIF) );
	rb_define_const( rbpf_mPF, "DIOCGETSTATUS", LONG2FIX(DIOCGETSTATUS) );
	rb_define_const( rbpf_mPF, "DIOCCLRSTATUS", LONG2FIX(DIOCCLRSTATUS) );
	rb_define_const( rbpf_mPF, "DIOCNATLOOK", LONG2FIX(DIOCNATLOOK) );
	rb_define_const( rbpf_mPF, "DIOCSETDEBUG", LONG2FIX(DIOCSETDEBUG) );
	rb_define_const( rbpf_mPF, "DIOCGETSTATES", LONG2FIX(DIOCGETSTATES) );
	rb_define_const( rbpf_mPF, "DIOCCHANGERULE", LONG2FIX(DIOCCHANGERULE) );
	rb_define_const( rbpf_mPF, "DIOCINSERTRULE", LONG2FIX(DIOCINSERTRULE) );
	rb_define_const( rbpf_mPF, "DIOCDELETERULE", LONG2FIX(DIOCDELETERULE) );
	rb_define_const( rbpf_mPF, "DIOCSETTIMEOUT", LONG2FIX(DIOCSETTIMEOUT) );
	rb_define_const( rbpf_mPF, "DIOCGETTIMEOUT", LONG2FIX(DIOCGETTIMEOUT) );
	rb_define_const( rbpf_mPF, "DIOCADDSTATE", LONG2FIX(DIOCADDSTATE) );
	rb_define_const( rbpf_mPF, "DIOCCLRRULECTRS", LONG2FIX(DIOCCLRRULECTRS) );
	rb_define_const( rbpf_mPF, "DIOCGETLIMIT", LONG2FIX(DIOCGETLIMIT) );
	rb_define_const( rbpf_mPF, "DIOCSETLIMIT", LONG2FIX(DIOCSETLIMIT) );
	rb_define_const( rbpf_mPF, "DIOCKILLSTATES", LONG2FIX(DIOCKILLSTATES) );
	rb_define_const( rbpf_mPF, "DIOCSTARTALTQ", LONG2FIX(DIOCSTARTALTQ) );
	rb_define_const( rbpf_mPF, "DIOCSTOPALTQ", LONG2FIX(DIOCSTOPALTQ) );
	rb_define_const( rbpf_mPF, "DIOCADDALTQ", LONG2FIX(DIOCADDALTQ) );
	rb_define_const( rbpf_mPF, "DIOCGETALTQS", LONG2FIX(DIOCGETALTQS) );
	rb_define_const( rbpf_mPF, "DIOCGETALTQ", LONG2FIX(DIOCGETALTQ) );
	rb_define_const( rbpf_mPF, "DIOCCHANGEALTQ", LONG2FIX(DIOCCHANGEALTQ) );
	rb_define_const( rbpf_mPF, "DIOCGETQSTATS", LONG2FIX(DIOCGETQSTATS) );
	rb_define_const( rbpf_mPF, "DIOCBEGINADDRS", LONG2FIX(DIOCBEGINADDRS) );
	rb_define_const( rbpf_mPF, "DIOCADDADDR", LONG2FIX(DIOCADDADDR) );
	rb_define_const( rbpf_mPF, "DIOCGETADDRS", LONG2FIX(DIOCGETADDRS) );
	rb_define_const( rbpf_mPF, "DIOCGETADDR", LONG2FIX(DIOCGETADDR) );
	rb_define_const( rbpf_mPF, "DIOCCHANGEADDR", LONG2FIX(DIOCCHANGEADDR) );
	rb_define_const( rbpf_mPF, "DIOCGETRULESETS", LONG2FIX(DIOCGETRULESETS) );
	rb_define_const( rbpf_mPF, "DIOCGETRULESET", LONG2FIX(DIOCGETRULESET) );
	rb_define_const( rbpf_mPF, "DIOCRCLRTABLES", LONG2FIX(DIOCRCLRTABLES) );
	rb_define_const( rbpf_mPF, "DIOCRADDTABLES", LONG2FIX(DIOCRADDTABLES) );
	rb_define_const( rbpf_mPF, "DIOCRDELTABLES", LONG2FIX(DIOCRDELTABLES) );
	rb_define_const( rbpf_mPF, "DIOCRGETTABLES", LONG2FIX(DIOCRGETTABLES) );
	rb_define_const( rbpf_mPF, "DIOCRGETTSTATS", LONG2FIX(DIOCRGETTSTATS) );
	rb_define_const( rbpf_mPF, "DIOCRCLRTSTATS", LONG2FIX(DIOCRCLRTSTATS) );
	rb_define_const( rbpf_mPF, "DIOCRCLRADDRS", LONG2FIX(DIOCRCLRADDRS) );
	rb_define_const( rbpf_mPF, "DIOCRADDADDRS", LONG2FIX(DIOCRADDADDRS) );
	rb_define_const( rbpf_mPF, "DIOCRDELADDRS", LONG2FIX(DIOCRDELADDRS) );
	rb_define_const( rbpf_mPF, "DIOCRSETADDRS", LONG2FIX(DIOCRSETADDRS) );
	rb_define_const( rbpf_mPF, "DIOCRGETADDRS", LONG2FIX(DIOCRGETADDRS) );
	rb_define_const( rbpf_mPF, "DIOCRGETASTATS", LONG2FIX(DIOCRGETASTATS) );
	rb_define_const( rbpf_mPF, "DIOCRCLRASTATS", LONG2FIX(DIOCRCLRASTATS) );
	rb_define_const( rbpf_mPF, "DIOCRTSTADDRS", LONG2FIX(DIOCRTSTADDRS) );
	rb_define_const( rbpf_mPF, "DIOCRSETTFLAGS", LONG2FIX(DIOCRSETTFLAGS) );
	rb_define_const( rbpf_mPF, "DIOCRINADEFINE", LONG2FIX(DIOCRINADEFINE) );
	rb_define_const( rbpf_mPF, "DIOCOSFPFLUSH", LONG2FIX(DIOCOSFPFLUSH) );
	rb_define_const( rbpf_mPF, "DIOCOSFPADD", LONG2FIX(DIOCOSFPADD) );
	rb_define_const( rbpf_mPF, "DIOCOSFPGET", LONG2FIX(DIOCOSFPGET) );
	rb_define_const( rbpf_mPF, "DIOCXBEGIN", LONG2FIX(DIOCXBEGIN) );
	rb_define_const( rbpf_mPF, "DIOCXCOMMIT", LONG2FIX(DIOCXCOMMIT) );
	rb_define_const( rbpf_mPF, "DIOCXROLLBACK", LONG2FIX(DIOCXROLLBACK) );
	rb_define_const( rbpf_mPF, "DIOCGETSRCNODES", LONG2FIX(DIOCGETSRCNODES) );
	rb_define_const( rbpf_mPF, "DIOCCLRSRCNODES", LONG2FIX(DIOCCLRSRCNODES) );
	rb_define_const( rbpf_mPF, "DIOCSETHOSTID", LONG2FIX(DIOCSETHOSTID) );
	rb_define_const( rbpf_mPF, "DIOCIGETIFACES", LONG2FIX(DIOCIGETIFACES) );
	rb_define_const( rbpf_mPF, "DIOCSETIFFLAG", LONG2FIX(DIOCSETIFFLAG) );
	rb_define_const( rbpf_mPF, "DIOCCLRIFFLAG", LONG2FIX(DIOCCLRIFFLAG) );
	rb_define_const( rbpf_mPF, "DIOCKILLSRCNODES", LONG2FIX(DIOCKILLSRCNODES) );
	rb_define_const( rbpf_mPF, "DIOCGIFSPEED", LONG2FIX(DIOCGIFSPEED) );


	rb_define_const( rbpf_mPF, "IFNAMSIZ", LONG2FIX(IFNAMSIZ) );
	rb_define_const( rbpf_mPF, "PF_MD5_DIGEST_LENGTH", LONG2FIX(PF_MD5_DIGEST_LENGTH) );

}

