/**
 * D header file for POSIX.
 *
 * Copyright: Public Domain
 * License:   Public Domain
 * Authors:   Sean Kelly
 * Standards: The Open Group Base Specifications Issue 6, IEEE Std 1003.1, 2004 Edition
 */
module core.sys.posix.sys.stat;

import core.sys.posix.config;
import core.stdc.stdint;
import core.sys.posix.time;     // for timespec
public import core.stdc.stddef;          // for size_t
public import core.sys.posix.sys.types; // for off_t, mode_t

extern (C):

static if( __USE_LARGEFILE64 )
{
    private alias uint _pad_t;
}
else
{
    private alias ushort _pad_t;
}

align (4) struct stat_t
{
    dev_t       st_dev;             /* Device.  */
    version (X86_64) {} else {
        _pad_t      __pad1;
    }
    static if( __USE_LARGEFILE64 )
    {
        ino_t      __st_ino;            /* 32bit file serial number.    */
    }
    else
    {
        ino_t       st_ino;             /* File serial number.  */
    }
    version (X86_64) {
        nlink_t     st_nlink;
        mode_t      st_mode;
    } else {
        mode_t      st_mode;            /* File mode.  */
        nlink_t     st_nlink;           /* Link count.  */
    }
    uid_t       st_uid;             /* User ID of the file's owner. */
    gid_t       st_gid;             /* Group ID of the file's group.*/
    version (X86_64) {
        int         pad0;
        dev_t       st_rdev;
    } else {
        dev_t       st_rdev;            /* Device number, if device.  */
        _pad_t      __pad2;
    }
    off_t       st_size;            /* Size of file, in bytes.  */
    blksize_t   st_blksize;         /* Optimal block size for I/O.  */
    blkcnt_t    st_blocks;          /* Number 512-byte blocks allocated. */
    static if( false /*__USE_MISC*/ ) // true if _BSD_SOURCE || _SVID_SOURCE
    {
        timespec    st_atim;
        timespec    st_mtim;
        timespec    st_ctim;
        alias st_atim.tv_sec st_atime;
        alias st_mtim.tv_sec st_mtime;
        alias st_ctim.tv_sec st_ctime;
    }
    else
    {
        time_t      st_atime;
        c_ulong     st_atimensec;
        time_t      st_mtime;
        c_ulong     st_mtimensec;
        time_t      st_ctime;
        c_ulong     st_ctimensec;
    }
    version (X86_64) {
        c_long[3]  __unused;
    }
    else static if( __USE_LARGEFILE64 )
    {
        ino64_t     st_ino;             /* File serial number.  */
    }
    else
    {
        c_ulong     __unused4;
        c_ulong     __unused5;
    }
}

const S_IRUSR   = 0x100; // 0400;
const S_IWUSR   = 0x080; // 0200;
const S_IXUSR   = 0x040; // 0100;
const S_IRWXU   = S_IRUSR | S_IWUSR | S_IXUSR;

const S_IRGRP   = S_IRUSR >> 3;
const S_IWGRP   = S_IWUSR >> 3;
const S_IXGRP   = S_IXUSR >> 3;
const S_IRWXG   = S_IRWXU >> 3;

const S_IROTH   = S_IRGRP >> 3;
const S_IWOTH   = S_IWGRP >> 3;
const S_IXOTH   = S_IXGRP >> 3;
const S_IRWXO   = S_IRWXG >> 3;

const S_ISUID   = 0x800; // 04000;
const S_ISGID   = 0x400; // 02000;
const S_ISVTX   = 0x200; // 01000;

private
{
    extern (D) bool S_ISTYPE( mode_t mode, uint mask )
    {
        return ( mode & S_IFMT ) == mask;
    }
}

extern (D) bool S_ISBLK( mode_t mode )  { return S_ISTYPE( mode, S_IFBLK );  }
extern (D) bool S_ISCHR( mode_t mode )  { return S_ISTYPE( mode, S_IFCHR );  }
extern (D) bool S_ISDIR( mode_t mode )  { return S_ISTYPE( mode, S_IFDIR );  }
extern (D) bool S_ISFIFO( mode_t mode ) { return S_ISTYPE( mode, S_IFIFO );  }
extern (D) bool S_ISREG( mode_t mode )  { return S_ISTYPE( mode, S_IFREG );  }
extern (D) bool S_ISLNK( mode_t mode )  { return S_ISTYPE( mode, S_IFLNK );  }
extern (D) bool S_ISSOCK( mode_t mode ) { return S_ISTYPE( mode, S_IFSOCK ); }

static if( true /*__USE_POSIX199309*/ )
{
    extern bool S_TYPEISMQ( stat_t* buf )  { return false; }
    extern bool S_TYPEISSEM( stat_t* buf ) { return false; }
    extern bool S_TYPEISSHM( stat_t* buf ) { return false; }
}

int    chmod(in char*, mode_t);
int    fchmod(int, mode_t);
int    mkdir(in char*, mode_t);
int    mkfifo(in char*, mode_t);
mode_t umask(mode_t);

static if (__USE_LARGEFILE64)
{
    int   fstat64(int, stat_t*);
    alias fstat64 fstat;

    int   lstat64(in char*, stat_t*);
    alias lstat64 lstat;

    int   stat64(in char*, stat_t*);
    alias stat64 stat;
}
else
{
    int   fstat(int, stat_t*);
    int   lstat(in char*, stat_t*);
    int   stat(in char*, stat_t*);
}

const S_IFMT     = 0xF000; // octal 0170000
const S_IFBLK    = 0x6000; // octal 0060000
const S_IFCHR    = 0x2000; // octal 0020000
const S_IFIFO    = 0x1000; // octal 0010000
const S_IFREG    = 0x8000; // octal 0100000
const S_IFDIR    = 0x4000; // octal 0040000
const S_IFLNK    = 0xA000; // octal 0120000
const S_IFSOCK   = 0xC000; // octal 0140000

int mknod(in char*, mode_t, dev_t);
