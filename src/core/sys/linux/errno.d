/**
 * D header file for GNU/Linux
 *
 * $(LINK2 http://sourceware.org/git/?p=glibc.git;a=blob;f=stdlib/errno.h, glibc stdlib/errno.h)
 */
module core.sys.linux.errno;

version (linux):
extern (C):

public import core.stdc.errno;
import core.sys.linux.config;

static if (__USE_GNU)
{
    extern char* program_invocation_name, program_invocation_short_name;
    alias int error_t;
}
