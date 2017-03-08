/**
 * D header file for POSIX.
 *
 * Copyright: Public Domain
 * License:   Public Domain
 * Authors:   Sean Kelly
 * Standards: The Open Group Base Specifications Issue 6, IEEE Std 1003.1, 2004 Edition
 */
module core.sys.posix.time;

import core.sys.posix.config;
public import core.stdc.time;
public import core.sys.posix.sys.types;
public import core.sys.posix.signal; // for sigevent

extern (C):

time_t timegm(tm*); // non-standard

const CLOCK_PROCESS_CPUTIME_ID  = 2; // (TMR|CPT)
const CLOCK_THREAD_CPUTIME_ID   = 3; // (TMR|TCT)

struct itimerspec
{
    timespec it_interval;
    timespec it_value;
}

const CLOCK_REALTIME    = 0;
const CLOCK_MONOTONIC   = 1;

const TIMER_ABSTIME     = 0x01;

alias int clockid_t;
alias int timer_t;

int clock_getres(clockid_t, timespec*);
int clock_gettime(clockid_t, timespec*);
int clock_settime(clockid_t, in timespec*);
int nanosleep(in timespec*, timespec*);
int timer_create(clockid_t, sigevent*, timer_t*);
int timer_delete(timer_t);
int timer_gettime(timer_t, itimerspec*);
int timer_getoverrun(timer_t);
int timer_settime(timer_t, int, in itimerspec*, itimerspec*);

char* asctime_r(in tm*, char*);
char* ctime_r(in time_t*, char*);
tm*   gmtime_r(in time_t*, tm*);
tm*   localtime_r(in time_t*, tm*);

extern int      daylight;
extern c_long   timezone;

tm*   getdate(in char*);
char* strptime(in char*, in char*, tm*);
