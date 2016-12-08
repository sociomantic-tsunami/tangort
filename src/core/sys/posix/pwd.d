/**
 * D header file for POSIX.
 *
 * Copyright: Public Domain
 * License:   Public Domain
 * Authors:   Sean Kelly
 * Standards: The Open Group Base Specifications Issue 6, IEEE Std 1003.1, 2004 Edition
 */
module core.sys.posix.pwd;

import core.sys.posix.config;
public import core.sys.posix.sys.types; // for gid_t, uid_t

extern (C):

struct passwd
{
    char*   pw_name;
    char*   pw_passwd;
    uid_t   pw_uid;
    gid_t   pw_gid;
    char*   pw_gecos;
    char*   pw_dir;
    char*   pw_shell;
}

passwd* getpwnam(in char*);
passwd* getpwuid(uid_t);

int getpwnam_r(in char*, passwd*, char*, size_t, passwd**);
int getpwuid_r(uid_t, passwd*, char*, size_t, passwd**);
void    endpwent();
passwd* getpwent();
void    setpwent();
