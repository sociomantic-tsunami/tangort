/**
 * D header file for POSIX.
 *
 * Copyright: Public Domain
 * License:   Public Domain
 * Authors:   Sean Kelly
 * Standards: The Open Group Base Specifications Issue 6, IEEE Std 1003.1, 2004 Edition
 */
module core.sys.posix.dirent;

import core.sys.posix.config;
public import core.sys.posix.sys.types; // for ino_t

extern (C):

// NOTE: The following constants are non-standard Linux definitions
//       for dirent.d_type.
enum
{
    DT_UNKNOWN  = 0,
    DT_FIFO     = 1,
    DT_CHR      = 2,
    DT_DIR      = 4,
    DT_BLK      = 6,
    DT_REG      = 8,
    DT_LNK      = 10,
    DT_SOCK     = 12,
    DT_WHT      = 14
}

struct dirent
{
    inol_t       d_ino;
    off_t       d_off;
    ushort      d_reclen;
    ubyte       d_type;
    char[256]   d_name;
}

struct DIR
{
    // Managed by OS
}

static if( __USE_LARGEFILE64 )
{
    dirent* readdir64(DIR*);
    alias   readdir64 readdir;
}
else
{
    dirent* readdir(DIR*);
}

int     closedir(DIR*);
DIR*    opendir(in char*);
void    rewinddir(DIR*);

static if( __USE_LARGEFILE64 )
{
    int   readdir64_r(DIR*, dirent*, dirent**);
    alias readdir64_r readdir_r;
}
else
{
    int readdir_r(DIR*, dirent*, dirent**);
}

void   seekdir(DIR*, c_long);
c_long telldir(DIR*);
