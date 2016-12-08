/**
 * D header file for GNU/Linux
 *
 * Authors: Martin Nowak
 */
module core.sys.linux.config;

version (linux):

public import core.sys.posix.config;

// man 7 feature_test_macros
// http://www.gnu.org/software/libc/manual/html_node/Feature-Test-Macros.html
const _GNU_SOURCE = true;
// deduced <features.h>
// http://sourceware.org/git/?p=glibc.git;a=blob;f=include/features.h
const _BSD_SOURCE = true;
const _SVID_SOURCE = true;
const _ATFILE_SOURCE = true;

const __USE_MISC = _BSD_SOURCE || _SVID_SOURCE;
const __USE_BSD = _BSD_SOURCE;
const __USE_SVID = _SVID_SOURCE;
const __USE_ATFILE = _ATFILE_SOURCE;
const __USE_GNU = _GNU_SOURCE;

// Available in bionic from API 21
version(CRuntime_Bionic) const __WORDSIZE = 32;
