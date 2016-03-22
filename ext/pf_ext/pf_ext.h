/*
 * Ruby-PF
 * $Id$
 */

#ifndef RUBY_PF_H_9B2639AF
#define RUBY_PF_H_9B2639AF

#ifdef HAVE_SYS_IOCTL_H
#include <sys/ioctl.h>
#endif

#define PRIVATE 1
#include "pfvar.h"

#include "ruby.h"

static VALUE rbpf_mPF;


#endif /* end RUBY_PF_H_9B2639AF */

