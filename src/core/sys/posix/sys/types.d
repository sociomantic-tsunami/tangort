/**
 * D header file for POSIX.
 *
 * Copyright: Public Domain
 * License:   Public Domain
 * Authors:   Sean Kelly
 * Standards: The Open Group Base Specifications Issue 6, IEEE Std 1003.1, 2004 Edition
 */
module core.sys.posix.sys.types;

import core.sys.posix.config;
import core.stdc.stdint;
public import core.stdc.stddef; // for size_t
public import core.stdc.time;   // for clock_t, time_t

extern (C):

//
// Required
//

alias c_ulong   ino_t;
static if( __USE_LARGEFILE64 )
{
    alias long      off_t;      // actually C header's off64_t in this mode
    alias long      blkcnt_t;   // actually C header's blkcnt64_t in this mode
    alias ulong     ino64_t;
    alias ino64_t   inol_t;
}
else
{
    alias c_long    off_t;
    alias c_long    blkcnt_t;
    alias ino_t   inol_t;
}
alias ulong     dev_t;
alias uint      mode_t;
alias c_ulong   nlink_t;
alias uint      uid_t;
alias uint      gid_t;
alias c_long    blksize_t;
alias int       pid_t;
//size_t (defined in tango.stdc.stddef)
alias ptrdiff_t ssize_t;
//time_t (defined in tango.stdc.time)

//
// XOpen (XSI)
//
static if( __USE_LARGEFILE64 )
{
    alias ulong     fsblkcnt_t;
    alias ulong     fsfilcnt_t;
}
else
{
    alias c_ulong   fsblkcnt_t;
    alias c_ulong   fsfilcnt_t;
}
// clock_t (defined in tango.stdc.time)
alias uint      id_t;
alias int       key_t;
alias c_long    suseconds_t;
alias uint      useconds_t;
//
// Thread (THR)
//

private struct __sched_param
{
    int __sched_priority;
}

struct pthread_attr_t
{
    int             __detachstate;
    int             __schedpolicy;
    __sched_param   __schedparam;
    int             __inheritsched;
    int             __scope;
    size_t          __guardsize;
    int             __stackaddr_set;
    void*           __stackaddr;
    size_t          __stacksize;
}

private alias int __atomic_lock_t;

private struct _pthread_fastlock
{
    c_long          __status;
    __atomic_lock_t __spinlock;
}

private alias void* _pthread_descr;

private alias long __pthread_cond_align_t;

struct pthread_cond_t
{
    _pthread_fastlock       __c_lock;
    _pthread_descr          __c_waiting;
    char[48 -
        _pthread_fastlock.sizeof -
        _pthread_descr.sizeof -
        __pthread_cond_align_t.sizeof]
        __padding;
    __pthread_cond_align_t  __align;
}

struct pthread_condattr_t
{
    int __dummy;
}

alias uint pthread_key_t;

struct pthread_mutex_t
{
    int                 __m_reserved;
    int                 __m_count;
    _pthread_descr      __m_owner;
    int                 __m_kind;
    _pthread_fastlock   __m_lock;
}

struct pthread_mutexattr_t
{
    int __mutexkind;
}

alias int pthread_once_t;

struct pthread_rwlock_t
{
    _pthread_fastlock   __rw_lock;
    int                 __rw_readers;
    _pthread_descr      __rw_writer;
    _pthread_descr      __rw_read_waiting;
    _pthread_descr      __rw_write_waiting;
    int                 __rw_kind;
    int                 __rw_pshared;
}

struct pthread_rwlockattr_t
{
    int __lockkind;
    int __pshared;
}

alias c_ulong pthread_t;

//
// Barrier (BAR)
//
/*
   pthread_barrier_t
   pthread_barrierattr_t
 */

struct pthread_barrier_t
{
    _pthread_fastlock   __ba_lock;
    int                 __ba_required;
    int                 __ba_present;
    _pthread_descr      __ba_waiting;
}

struct pthread_barrierattr_t
{
    int __pshared;
}

//
// Spin (SPN)
//
/*
   pthread_spinlock_t
 */

alias int pthread_spinlock_t; // volatile
