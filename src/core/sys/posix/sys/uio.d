/**
 * D header file for POSIX.
 *
 * Copyright: Public Domain
 * License:   Public Domain
 * Authors:   Sean Kelly
 * Standards: The Open Group Base Specifications Issue 6, IEEE Std 1003.1, 2004 Edition
 */
module core.sys.posix.sys.uio;

import core.sys.posix.config;
public import core.sys.posix.sys.types; // for ssize_t, size_t

extern (C):

//
// Required
//
/*
struct iovec
{
    void*  iov_base;
    size_t iov_len;
}

ssize_t // from tango.stdc.posix.sys.types
size_t  // from tango.stdc.posix.sys.types

ssize_t readv(int, in iovec*, int);
ssize_t writev(int, in iovec*, int);
*/

struct iovec
{
    void* iov_base;
    size_t iov_len;
}

version (D_Version2)
    struct iovec_const
    {
        mixin("const(void)* iov_base;");
        size_t iov_len;
    }
else
    alias iovec iovec_const;

version( linux )
{
    ssize_t readv(int, in iovec*, int);
    ssize_t writev(int, in iovec_const*, int);
}
else version( darwin )
{
    ssize_t readv(int, in iovec*, int);
    ssize_t writev(int, in iovec_const*, int);
}
else version( freebsd )
{
    ssize_t readv(int, in iovec*, int);
    ssize_t writev(int, in iovec_const*, int);
}
else version( solaris )
{
    ssize_t readv(int, in iovec*, int);
    ssize_t writev(int, in iovec_const*, int);
}
