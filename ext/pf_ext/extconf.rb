# -*- ruby -*-
#encoding: utf-8

require 'mkmf'

abort "Requires a system with pf" unless have_header( 'pfvar.h' )
abort "Missing sys/ioctl.h" unless have_header( 'sys/ioctl.h' )

create_makefile( 'pf_ext' )

