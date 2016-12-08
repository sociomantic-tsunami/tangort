/**
 * D header file for POSIX.
 *
 * Copyright: Public Domain
 * License:   Public Domain
 * Authors:   Sean Kelly
 * Standards: The Open Group Base Specifications Issue 6, IEEE Std 1003.1, 2004 Edition
 */
module core.sys.posix.fcntl;

import core.sys.posix.config;
import core.stdc.stdint;
public import core.stdc.stddef;          // for size_t
public import core.sys.posix.sys.types; // for off_t, mode_t
public import core.sys.posix.sys.stat;  // for S_IFMT, etc.
extern (C):

//
// Required
//

struct flock
{
    short   l_type;
    short   l_whence;
    off_t   l_start;
    off_t   l_len;
    pid_t   l_pid;
}

static if( __USE_LARGEFILE64 )
{
    int   creat64(in char*, mode_t);
    alias creat64 creat;

    int   open64(in char*, int, ...);
    alias open64 open;
}
else
{
    int   creat(in char*, mode_t);
    int   open(in char*, int, ...);
}

int fcntl(int, int, ...);

//
// Advisory Information (ADV)
//
int posix_fadvise(int, off_t, off_t, int);
int posix_fallocate(int, off_t, off_t);

enum { F_DUPFD = 0 }
enum { F_GETFD = 1 }
enum { F_SETFD = 2 }
enum { F_GETFL = 3 }
enum { F_SETFL = 4 }

version(X86_64)
{
    static assert(off_t.sizeof == 8);
    enum { F_GETLK  = 5 }
    enum { F_SETLK  = 6 }
    enum { F_SETLKW = 7 }
}
else
{
    static assert(false, "Only X86_64 architecture is supported.");
}

enum { F_GETOWN = 9 }
enum { F_SETOWN = 8 }
enum { FD_CLOEXEC = 1 }
enum { F_RDLCK = 0 }
enum { F_UNLCK = 2 }
enum { F_WRLCK = 1 }
enum { O_CREAT    = 0x40 } // 0100
enum { O_EXCL     = 0x80 } // 0200
enum { O_NOCTTY   = 0x100 } // 0400
enum { O_TRUNC    = 0x200 } // 01000
enum { O_APPEND   = 0x400 } // 02000
enum { O_NONBLOCK = 0x800 } // 04000
enum { O_SYNC     = 0x1000 } // 010000
enum { O_DSYNC = O_SYNC }  // optional synchronized io
enum { O_RSYNC = O_SYNC } // optional synchronized io
enum { O_ACCMODE = 3 }
enum { O_RDONLY  = 0 }
enum { O_WRONLY  = 1 }
enum { O_RDWR    = 2 }
