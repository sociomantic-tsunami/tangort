/**
 * D header file for POSIX.
 *
 * Copyright: Public Domain
 * License:   Public Domain
 * Authors:   Christian Schneider
 * Standards: The Open Group Base Specifications Issue 6, IEEE Std 1003.1, 2004 Edition
 * Source:    Copied/edited from tango.stdc.posix.pwd
 */
module core.sys.posix.grp;

import core.sys.posix.config;
public import core.sys.posix.sys.types; // for gid_t, uid_t

extern (C):

struct group
{
    char*   gr_name;
    char*   gr_passwd;
    gid_t   gr_gid;
    char**  gr_mem;
}
group* getgrnam(in char*);
group* getgrgid(gid_t);

int getgrnam_r(in char*, group*, char*, size_t, group**);
int getgrgid_r(gid_t, group*, char*, size_t, group**);
void    endgrent();
group* getgrent();
void    setgrent();
