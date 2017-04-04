/*******************************************************************************

    eventfd bindings

    Copyright:
        Copyright (c) 2009-2017 Sociomantic Labs GmbH.
        All rights reserved.

    License:
        Boost Software License Version 1.0. See LICENSE_BOOST.txt for details.
        Alternatively, this file may be distributed under the terms of the Tango
        3-Clause BSD License (see LICENSE_BSD.txt for details).

*******************************************************************************/

module core.sys.linux.sys.eventfd;

version (linux):
extern (C):

import core.stdc.stdint: uint64_t;

/* Return file descriptor for generic event channel.  Set initial
   value to count.  */
int eventfd (uint count, int flags);

/* Read event counter and possibly wait for events.  */
int eventfd_read (int fd, uint64_t* value);

/* Increment event counter.  */
int eventfd_write (int fd, uint64_t value);

enum { EFD_SEMAPHORE = 1 }
enum { EFD_CLOEXEC = 0x80000 } // octal!2000000
enum { EFD_NONBLOCK = 0x800 } // octal!4000
