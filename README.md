# ruby-pf

home
: http://deveiate.org/projects/ruby-pf

code
: http://bitbucket.org/ged/ruby-pf

github
: https://github.com/ged/ruby-pf

docs
: http://deveiate.org/code/ruby-pf


## Description

This is a Ruby interface to `pf`, the OpenBSD Packet Filter.

It uses the `ioctl(2)` interface to the `/dev/pf` pseudo-device, and can be used to:

- start and stop the packet filter
- manipulate rules
- manipulate ALTQ disciplines and queues
- gather statistics


## Prerequisites

* Ruby
* A host that supports PF


## Installation

    $ gem install ruby-pf



### Building on MacOS X

MacOS X versions 10.7 and later include PF, but do not include the necessary headers to compile this extension, even with developer tools installed.

Fortunately Apple releases the sources for a large part of the OS on opensource.apple.com, and the necessary header is in the `xnu` source under `bsd/net`. For example, my current machine's `uname -v` is: 

    Darwin Kernel Version 15.3.0: Thu Dec 10 18:40:58 PST 2015; root:xnu-3248.30.4~1/RELEASE_X86_64

So I got my header from:

    http://www.opensource.apple.com/source/xnu/xnu-3248.20.55/bsd/net/

This (obviously) isn't really a safe way to do things, and it may screw up your firewall, segfault, or do other bad things if you mismatch versions (or maybe even if you don't). _Caveat emptor_.


## Contributing

You can check out the current development source with Mercurial via its
[project page](http://bitbucket.org/ged/ruby-pf). Or if you prefer Git, via 
[its Github mirror](https://github.com/ged/ruby-pf).

After checking out the source, run:

    $ rake newb

This task will install any missing dependencies, run the tests/specs,
and generate the API documentation.


## License

Copyright (c) 2016, Michael Granger
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice,
  this list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright notice,
  this list of conditions and the following disclaimer in the documentation
  and/or other materials provided with the distribution.

* Neither the name of the author/s, nor the names of the project's
  contributors may be used to endorse or promote products derived from this
  software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


