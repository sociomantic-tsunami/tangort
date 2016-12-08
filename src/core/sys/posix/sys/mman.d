/**
 * D header file for POSIX.
 *
 * Copyright: Public Domain
 * License:   Public Domain
 * Authors:   Sean Kelly
 * Standards: The Open Group Base Specifications Issue 6, IEEE Std 1003.1, 2004 Edition
 */
module core.sys.posix.sys.mman;

import core.sys.posix.config;
public import core.stdc.stddef;          // for size_t
public import core.sys.posix.sys.types; // for off_t, mode_t

extern (C):

const POSIX_MADV_NORMAL     = 0;
const POSIX_MADV_RANDOM     = 1;
const POSIX_MADV_SEQUENTIAL = 2;
const POSIX_MADV_WILLNEED   = 3;
const POSIX_MADV_DONTNEED   = 4;

const PROT_NONE     = 0x0;
const PROT_READ     = 0x1;
const PROT_WRITE    = 0x2;
const PROT_EXEC     = 0x4;

//void* mmap(void*, size_t, int, int, int, off_t);
int   munmap(void*, size_t);

static if( __USE_LARGEFILE64 )
{
    void* mmap64(void*, size_t, int, int, int, off_t);
    alias mmap64 mmap;
}
else
{
    void* mmap(void*, size_t, int, int, int, off_t);
}

const MAP_SHARED    = 0x01;
const MAP_PRIVATE   = 0x02;
const MAP_FIXED     = 0x10;
const MAP_ANON      = 0x20; // non-standard

const MAP_FAILED    = cast(void*) -1;

enum
{
    MS_ASYNC        = 1,
    MS_SYNC         = 4,
    MS_INVALIDATE   = 2
}

int msync(void*, size_t, int);

const MCL_CURRENT   = 1;
const MCL_FUTURE    = 2;

int mlockall(int);
int munlockall();

int mlock(in void*, size_t);
int munlock(in void*, size_t);
int mprotect(void*, size_t, int);
int shm_open(in char*, int, mode_t);
int shm_unlink(in char*);
