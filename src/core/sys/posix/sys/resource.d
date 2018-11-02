/**
 * D header file for POSIX.
 *
 * Copyright: Copyright (c) 2013 Lars Tandle Kyllingstad, Copyright (c) 2016 dunnhumby Germany GmbH
 * License:   <a href="http://www.boost.org/LICENSE_1_0.txt">Boost License 1.0</a>.
 * Authors:   Lars Tandle Kyllingstad, Hatem Oraby
 * Standards: The Open Group Base Specifications Issue 7, IEEE Std 1003.1-2008
 *
 * Based on: https://github.com/D-Programming-Language/druntime/blob/0c300e61e4f9ae41b8eea16483cef76ae09b538c/src/core/sys/posix/sys/resource.d
 */

module core.sys.posix.sys.resource;

public import core.sys.posix.sys.time;
public import core.sys.posix.sys.types: id_t;
import core.sys.posix.config;

extern(C):

const PRIO_PROCESS = 0;
const PRIO_PGRP    = 1;
const PRIO_USER    = 2;

alias ulong rlim_t;

const RLIM_INFINITY = 0xffffffffffffffffUL;

const RLIM_SAVED_MAX = RLIM_INFINITY;
const RLIM_SAVED_CUR = RLIM_INFINITY;

const RUSAGE_SELF     =  0;
const RUSAGE_CHILDREN = -1;

struct rusage
{
    timeval ru_utime;
    timeval ru_stime;
    c_long ru_maxrss;
    c_long ru_ixrss;
    c_long ru_idrss;
    c_long ru_isrss;
    c_long ru_minflt;
    c_long ru_majflt;
    c_long ru_nswap;
    c_long ru_inblock;
    c_long ru_oublock;
    c_long ru_msgsnd;
    c_long ru_msgrcv;
    c_long ru_nsignals;
    c_long ru_nvcsw;
    c_long ru_nivcsw;
}


const RLIMIT_CORE   = 4;
const RLIMIT_CPU    = 0;
const RLIMIT_DATA   = 2;
const RLIMIT_FSIZE  = 1;
const RLIMIT_NOFILE = 7;
const RLIMIT_STACK  = 3;
const RLIMIT_AS     = 9;


struct rlimit
{
    rlim_t rlim_cur;
    rlim_t rlim_max;
}

int getrlimit(int, rlimit*);
int getrusage(int, rusage*);
int setrlimit(int, in rlimit*);
