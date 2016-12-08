/**
 * D header file for GNU/Linux.
 *
 * Copyright: Copyright Robert Klotzner 2012.
 * License:   $(LINK2 http://www.boost.org/LICENSE_1_0.txt, Boost License 1.0)
 * Authors:   Robert Klotzner
 */
module core.sys.linux.sys.xattr;

import core.sys.posix.sys.types;

version (linux):
extern (C):

enum {
    XATTR_CREATE = 1, /* set value, fail if attr already exists.  */
    XATTR_REPLACE = 2 /* set value, fail if attr does not exist.  */
}

const XATTR_OS2_PREFIX = "os2.";
const XATTR_OS2_PREFIX_LEN = XATTR_OS2_PREFIX.length;
const XATTR_SECURITY_PREFIX = "security.";
const XATTR_SECURITY_PREFIX_LEN = XATTR_SECURITY_PREFIX.length;
const XATTR_SYSTEM_PREFIX = "system.";
const XATTR_SYSTEM_PREFIX_LEN = XATTR_SYSTEM_PREFIX.length;
const XATTR_TRUSTED_PREFIX = "trusted.";
const XATTR_TRUSTED_PREFIX_LEN = XATTR_TRUSTED_PREFIX.length;
const XATTR_USER_PREFIX = "user.";
const XATTR_USER_PREFIX_LEN = XATTR_USER_PREFIX.length;

/* Security namespace */
const XATTR_SELINUX_SUFFIX = "selinux.";
const XATTR_NAME_SELINUX = XATTR_SECURITY_PREFIX ~ XATTR_SELINUX_SUFFIX;

const XATTR_SMACK_SUFFIX = "SMACK64";
const XATTR_SMACK_IPIN = "SMACK64IPIN";
const XATTR_SMACK_IPOUT = "SMACK64IPOUT";
const XATTR_SMACK_EXEC = "SMACK64EXEC";
const XATTR_SMACK_TRANSMUTE = "SMACK64TRANSMUTE";
const XATTR_SMACK_MMAP = "SMACK64MMAP";

const XATTR_NAME_SMACK = XATTR_SECURITY_PREFIX ~ XATTR_SMACK_SUFFIX;
const XATTR_NAME_SMACKIPIN = XATTR_SECURITY_PREFIX ~ XATTR_SMACK_IPIN;
const XATTR_NAME_SMACKIPOUT = XATTR_SECURITY_PREFIX ~ XATTR_SMACK_IPOUT;
const XATTR_NAME_SMACKEXEC = XATTR_SECURITY_PREFIX ~ XATTR_SMACK_EXEC;
const XATTR_NAME_SMACKTRANSMUTE = XATTR_SECURITY_PREFIX ~ XATTR_SMACK_TRANSMUTE;
const XATTR_NAME_SMACKMMAP = XATTR_SECURITY_PREFIX ~ XATTR_SMACK_MMAP;

const XATTR_CAPS_SUFFIX = "capability";
const XATTR_NAME_CAPS = XATTR_SECURITY_PREFIX ~ XATTR_CAPS_SUFFIX;


int setxattr(in char* path, in char* name, in void* value, size_t size, int flags);

int lsetxattr(in char* path, in char* name, in void* value, size_t size, int flags);
int fsetxattr(int fd, in char* name, in void* value, size_t size, int flags);
ssize_t getxattr(in char* path, in char* name, void* value, size_t size);
ssize_t lgetxattr(in char* path, in char* name, void* value, size_t size);
ssize_t fgetxattr(int fd, in char* name, void* value, size_t size);
ssize_t listxattr(in char* path, char* list, size_t size);
ssize_t llistxattr(in char* path, char* list, size_t size);
ssize_t flistxattr (int __fd, char *list, size_t size);
int removexattr (in char *path, in char *name);
int lremovexattr (in char *path, in char *name);
int fremovexattr (int fd, in char *name);

