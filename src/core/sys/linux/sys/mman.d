/**
 * D header file for GNU/Linux
 *
 * Authors: Martin Nowak
 */
module core.sys.linux.sys.mman;

version (linux):
extern (C):

public import core.sys.posix.sys.mman;
import core.sys.linux.config;

version (X86_64)
{
    static if (__USE_MISC) enum { MAP_32BIT = 0x40 };

    static if (__USE_MISC) enum
    {
        MAP_GROWSDOWN = 0x00100,
        MAP_DENYWRITE = 0x00800,
        MAP_EXECUTABLE = 0x01000,
        MAP_LOCKED = 0x02000,
        MAP_NORESERVE = 0x04000,
        MAP_POPULATE = 0x08000,
        MAP_NONBLOCK = 0x10000,
        MAP_STACK = 0x20000,
        MAP_HUGETLB = 0x40000,
    }
}
else
{
    static assert(0, "unimplemented");
}


// in core.sys.posix.sys.mman
// enum PROT_READ = 0x1;
// enum PROT_WRITE = 0x2;
// enum PROT_EXEC = 0x4;
// enum PROT_NONE = 0x0;

enum { PROT_GROWSDOWN = 0x01000000 };
enum { PROT_GROWSUP = 0x02000000 };

enum { MAP_SHARED = 0x01 };
enum { MAP_PRIVATE = 0x02 };
static if (__USE_MISC)
    enum { MAP_TYPE = 0x0f };

enum { MAP_FIXED = 0x10 };
static if (__USE_MISC) enum
{
    MAP_FILE = 0,
    MAP_ANONYMOUS = MAP_ANON,
    // in core.sys.posix.sys.mman
    // MAP_ANON = 0xXX,
    MAP_HUGE_SHIFT = 26,
    MAP_HUGE_MASK = 0x3f,
}

// in core.sys.posix.sys.mman
// enum
// {
//     MS_ASYNC = 1,
//     MS_SYNC = 4,
//     MS_INVALIDATE = 2,
// }

static if (__USE_GNU) enum
{
    MREMAP_MAYMOVE = 1,
    MREMAP_FIXED = 2,
}

static if (__USE_BSD) enum
{
    MADV_NORMAL = 0,
    MADV_RANDOM = 1,
    MADV_SEQUENTIAL = 2,
    MADV_WILLNEED = 3,
    MADV_DONTNEED = 4,
    MADV_REMOVE = 9,
    MADV_DONTFORK = 10,
    MADV_DOFORK = 11,
    MADV_MERGEABLE = 12,
    MADV_UNMERGEABLE = 13,
    MADV_HWPOISON = 100,
}

// in core.sys.posix.sys.mman
// static if (__USE_XOPEN2K) enum
// {
//     POSIX_MADV_NORMAL = 0,
//     POSIX_MADV_RANDOM = 1,
//     POSIX_MADV_SEQUENTIAL = 2,
//     POSIX_MADV_WILLNEED = 3,
//     POSIX_MADV_DONTNEED = 4,
// }

// in core.sys.posix.sys.mman
// enum
// {
//
//     MCL_CURRENT = 1,
//     MCL_FUTURE = 2,
// }

// http://sourceware.org/git/?p=glibc.git;a=blob;f=misc/sys/mman.h
// in core.sys.posix.sys.mman
// static if (__USE_LARGEFILE64) void* mmap64(void*, size_t, int, int, int, off_t);
// static if (__USE_FILE_OFFSET64)
//     alias mmap64 mmap;
// else
//     void* mmap(void*, size_t, int, int, int, off_t);
// int munmap(void*, size_t);
// int mprotect(void *__addr, size_t __len, int __prot);
// int msync(void *__addr, size_t __len, int __flags);
static if (__USE_BSD) int madvise(void *__addr, size_t __len, int __advice);
// static if (__USE_XOPEN2K) int posix_madvise(void *__addr, size_t __len, int __advice);
// int mlock(const(void) *__addr, size_t __len);
// int munlock(const(void) *__addr, size_t __len);
// int mlockall(int __flags);
// int munlockall();
static if (__USE_MISC) int mincore(void *__start, size_t __len, ubyte *__vec);
static if (__USE_GNU) void *mremap(void *__addr, size_t __old_len, size_t __new_len, int __flags, ...);
static if (__USE_GNU) int remap_file_pages(void *__start, size_t __size, int __prot, size_t __pgoff, int __flags);
// int shm_open(in char *__name, int __oflag, mode_t __mode);
// int shm_unlink(in char *__name);
