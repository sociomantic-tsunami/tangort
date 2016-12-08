/**
 * D header file for POSIX.
 *
 * Copyright: Public Domain
 * License:   Public Domain
 * Authors:   Sean Kelly
 * Standards: The Open Group Base Specifications Issue 6, IEEE Std 1003.1, 2004 Edition
 */
module core.sys.posix.sys.time;

import core.sys.posix.config;
public import core.sys.posix.sys.types;  // for time_t, suseconds_t
public import core.sys.posix.sys.select; // for fd_set, FD_CLR() FD_ISSET() FD_SET() FD_ZERO() FD_SETSIZE

extern (C):

struct timeval
{
    time_t      tv_sec;
    suseconds_t tv_usec;
}

struct itimerval
{
    timeval it_interval;
    timeval it_value;
}

const ITIMER_REAL       = 0;
const ITIMER_VIRTUAL    = 1;
const ITIMER_PROF       = 2;

int getitimer(int, itimerval*);
int gettimeofday(timeval*, void*);
int select(int, fd_set*, fd_set*, fd_set*, timeval*);
int setitimer(int, in itimerval*, itimerval*);
int utimes(in char*,/* in */ ref timeval[2]); // LEGACY

void timeradd(timeval* a, timeval* b, timeval* result)
{
    result.tv_sec = a.tv_sec + b.tv_sec;
    result.tv_usec = a.tv_usec + b.tv_usec;
    if (result.tv_usec >= 1000000)
    {
        ++result.tv_sec;
        result.tv_usec -= 1000000;
    }
}

void timersub(timeval* a, timeval* b, timeval *result)
{
    result.tv_sec = a.tv_sec - b.tv_sec;
    result.tv_usec = a.tv_usec - b.tv_usec;
    if (result.tv_usec < 0) {
        --result.tv_sec;
        result.tv_usec += 1000000;
    }
}

void timerclear(timeval* tvp)
{
    (tvp.tv_sec = tvp.tv_usec = 0);
}

int timerisset(timeval* tvp)
{
    return cast(int) (tvp.tv_sec || tvp.tv_usec);
}

int timercmp (char[] CMP) (timeval* a, timeval* b)
{
    return cast(int)
           mixin("((a.tv_sec == b.tv_sec) ?" ~
                 "(a.tv_usec" ~ CMP ~ "b.tv_usec) :" ~
                 "(a.tv_sec"  ~ CMP ~ "b.tv_sec))");
}
