/**
 * D header file for POSIX.
 *
 * Copyright: Public Domain
 * License:   Public Domain
 * Authors:   Sean Kelly
 * Standards: The Open Group Base Specifications Issue 6, IEEE Std 1003.1, 2004 Edition
 */
module core.sys.posix.stdlib;

import core.sys.posix.config;
public import core.stdc.stdlib;
public import core.sys.posix.sys.wait;

extern (C):

int posix_memalign(void**, size_t, size_t);

int setenv(in char*, in char*, int);
int unsetenv(in char*);

void* valloc(size_t); // LEGACY non-standard

int rand_r(uint*);

//WNOHANG     (defined in core.sys.posix.sys.wait)
//WUNTRACED   (defined in core.sys.posix.sys.wait)
//WEXITSTATUS (defined in core.sys.posix.sys.wait)
//WIFEXITED   (defined in core.sys.posix.sys.wait)
//WIFSIGNALED (defined in core.sys.posix.sys.wait)
//WIFSTOPPED  (defined in core.sys.posix.sys.wait)
//WSTOPSIG    (defined in core.sys.posix.sys.wait)
//WTERMSIG    (defined in core.sys.posix.sys.wait)

c_long a64l(in char*);
double drand48();
char*  ecvt(double, int, int *, int *); // LEGACY
double erand48(ref ushort[3]);
char*  fcvt(double, int, int *, int *); // LEGACY
char*  gcvt(double, int, char*); // LEGACY
int    getsubopt(char**, in char**, char**);
int    grantpt(int);
char*  initstate(uint, char*, size_t);
c_long jrand48(ref ushort[3]);
char*  l64a(c_long);
void   lcong48(ref ushort[7]);
c_long lrand48();
char*  mktemp(char*); // LEGACY
char*  mkdtemp(char*);

//int    mkstemp(char*);
c_long mrand48();
c_long nrand48(ref ushort[3]);
int    posix_openpt(int);
char*  ptsname(int);
int    putenv(char*);
c_long random();
char*  realpath(in char*, char*);
ushort seed48(ref ushort[3]);
void   setkey(in char*);
char*  setstate(in char*);
void   srand48(c_long);
void   srandom(uint);
int    unlockpt(int);

static if( __USE_LARGEFILE64 )
{
    int    mkstemp64(char*);
    alias  mkstemp64 mkstemp;
}
else
{
    int    mkstemp(char*);
}
