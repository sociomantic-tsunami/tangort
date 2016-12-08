/**
 * D header file for GNU/Linux.
 *
 * License:   $(LINK2 http://www.boost.org/LICENSE_1_0.txt, Boost License 1.0)
 * Authors:   Kai Nacke
 */
module core.sys.linux.sys.auxv;

import core.stdc.config;

version (linux):
extern (C):

c_ulong getauxval(c_ulong type);

