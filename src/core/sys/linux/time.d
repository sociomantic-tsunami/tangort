//Written in the D programming language

/++
    D header file for Linux extensions to POSIX's time.h.

    Copyright: Copyright 2014
    License:   $(WEB www.boost.org/LICENSE_1_0.txt, Boost License 1.0).
    Authors:   Jonathan M Davis
 +/
module core.sys.linux.time;

public import core.sys.posix.time;

version(linux):

const CLOCK_MONOTONIC_RAW      = 4;
const CLOCK_REALTIME_COARSE    = 5;
const CLOCK_MONOTONIC_COARSE   = 6;
const CLOCK_BOOTTIME           = 7;
const CLOCK_REALTIME_ALARM     = 8;
const CLOCK_BOOTTIME_ALARM     = 9;
const CLOCK_SGI_CYCLE          = 10;
const CLOCK_TAI                = 11;
