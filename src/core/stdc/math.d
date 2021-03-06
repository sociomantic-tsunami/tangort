/**
 * D header file for C99.
 *
 * Copyright: Public Domain
 * License:   Public Domain
 * Authors:   Sean Kelly, Walter Bright
 * Standards: ISO/IEC 9899:1999 (E)
 */
module core.stdc.math;

import core.stdc.config;

extern (C):

alias float  float_t;
alias double double_t;

const double HUGE_VAL      = double.infinity;
const double HUGE_VALF     = float.infinity;
const double HUGE_VALL     = real.infinity;

const float INFINITY       = float.infinity;
const float NAN            = float.nan;

const int FP_ILOGB0        = int.min;
const int FP_ILOGBNAN      = int.min;

const int MATH_ERRNO       = 1;
const int MATH_ERREXCEPT   = 2;
const int math_errhandling = MATH_ERRNO | MATH_ERREXCEPT;

enum
{
    FP_NAN,
    FP_INFINITE,
    FP_ZERO,
    FP_SUBNORMAL,
    FP_NORMAL,
}

enum
{
    FP_FAST_FMA  = 0,
    FP_FAST_FMAF = 0,
    FP_FAST_FMAL = 0,
}

int __fpclassifyf(float x);
int __fpclassify(double x);
int __fpclassifyl(real x);

int __finitef(float x);
int __finite(double x);
int __finitel(real x);

int __isinff(float x);
int __isinf(double x);
int __isinfl(real x);

int __isnanf(float x);
int __isnan(double x);
int __isnanl(real x);

int __signbitf(float x);
int __signbit(double x);
int __signbitl(real x);

extern (D)
{
    //int fpclassify(real-floating x);
    int fpclassify(float x)     { return __fpclassifyf(x); }
    int fpclassify(double x)    { return __fpclassify(x);  }
    int fpclassify(real x)
    {
        return (real.sizeof == double.sizeof)
            ? __fpclassify(x)
            : __fpclassifyl(x);
    }

    //int isfinite(real-floating x);
    int isfinite(float x)       { return __finitef(x); }
    int isfinite(double x)      { return __finite(x);  }
    int isfinite(real x)
    {
        return (real.sizeof == double.sizeof)
            ? __finite(x)
            : __finitel(x);
    }

    //int isinf(real-floating x);
    int isinf(float x)          { return __isinff(x);  }
    int isinf(double x)         { return __isinf(x);   }
    int isinf(real x)
    {
        return (real.sizeof == double.sizeof)
            ? __isinf(x)
            : __isinfl(x);
    }

    //int isnan(real-floating x);
    int isnan(float x)          { return __isnanf(x);  }
    int isnan(double x)         { return __isnan(x);   }
    int isnan(real x)
    {
        return (real.sizeof == double.sizeof)
            ? __isnan(x)
            : __isnanl(x);
    }

    //int isnormal(real-floating x);
    int isnormal(float x)       { return fpclassify(x) == FP_NORMAL; }
    int isnormal(double x)      { return fpclassify(x) == FP_NORMAL; }
    int isnormal(real x)        { return fpclassify(x) == FP_NORMAL; }

    //int signbit(real-floating x);
    int signbit(float x)     { return __signbitf(x); }
    int signbit(double x)    { return __signbit(x);  }
    int signbit(real x)
    {
        return (real.sizeof == double.sizeof)
            ? __signbit(x)
            : __signbitl(x);
    }
}

extern (D)
{
    //int isgreater(real-floating x, real-floating y);
    int isgreater(float x, float y)        { return !(isnan(x) || isnan(y)) && x > y; }
    int isgreater(double x, double y)      { return !(isnan(x) || isnan(y)) && x > y; }
    int isgreater(real x, real y)          { return !(isnan(x) || isnan(y)) && x > y; }

    //int isgreaterequal(real-floating x, real-floating y);
    int isgreaterequal(float x, float y)   { return !(isnan(x) || isnan(y)) && x >= y; }
    int isgreaterequal(double x, double y) { return !(isnan(x) || isnan(y)) && x >= y; }
    int isgreaterequal(real x, real y)     { return !(isnan(x) || isnan(y)) && x >= y; }

    //int isless(real-floating x, real-floating y);
    int isless(float x, float y)           { return !(isnan(x) || isnan(y)) && x < y; }
    int isless(double x, double y)         { return !(isnan(x) || isnan(y)) && x <  y; }
    int isless(real x, real y)             { return !(isnan(x) || isnan(y)) && x <  y; }

    //int islessequal(real-floating x, real-floating y);
    int islessequal(float x, float y)      { return !(isnan(x) || isnan(y)) && x <= y; }
    int islessequal(double x, double y)    { return !(isnan(x) || isnan(y)) && x <= y; }
    int islessequal(real x, real y)        { return !(isnan(x) || isnan(y)) && x <= y; }

    //int islessgreater(real-floating x, real-floating y);
    int islessgreater(float x, float y)    { return !(isnan(x) || isnan(y)) || x != y; }
    int islessgreater(double x, double y)  { return !(isnan(x) || isnan(y)) || x != y; }
    int islessgreater(real x, real y)      { return !(isnan(x) || isnan(y)) || x != y; }

    //int isunordered(real-floating x, real-floating y);
    int isunordered(float x, float y)      { return isnan(x) && isnan(y); }
    int isunordered(double x, double y)    { return isnan(x) && isnan(y); }
    int isunordered(real x, real y)        { return isnan(x) && isnan(y); }
}

double  acos(double x);
float   acosf(float x);
real    acosl(real x);

double  asin(double x);
float   asinf(float x);
real    asinl(real x);

double  atan(double x);
float   atanf(float x);
real    atanl(real x);

double  atan2(double y, double x);
float   atan2f(float y, float x);
real    atan2l(real y, real x);

double  cos(double x);
float   cosf(float x);
real    cosl(real x);

double  sin(double x);
float   sinf(float x);
real    sinl(real x);

double  tan(double x);
float   tanf(float x);
real    tanl(real x);

double  acosh(double x);
float   acoshf(float x);
real    acoshl(real x);

double  asinh(double x);
float   asinhf(float x);
real    asinhl(real x);

double  atanh(double x);
float   atanhf(float x);
real    atanhl(real x);

double  cosh(double x);
float   coshf(float x);
real    coshl(real x);

double  sinh(double x);
float   sinhf(float x);
real    sinhl(real x);

double  tanh(double x);
float   tanhf(float x);
real    tanhl(real x);

double  exp(double x);
float   expf(float x);
real    expl(real x);

double  exp2(double x);
float   exp2f(float x);
real    exp2l(real x);

double  expm1(double x);
float   expm1f(float x);
real    expm1l(real x);

double  frexp(double value, int* exp);
float   frexpf(float value, int* exp);
real    frexpl(real value, int* exp);

int     ilogb(double x);
int     ilogbf(float x);
int     ilogbl(real x);

double  ldexp(double x, int exp);
float   ldexpf(float x, int exp);
real    ldexpl(real x, int exp);

double  log(double x);
float   logf(float x);
real    logl(real x);

double  log10(double x);
float   log10f(float x);
real    log10l(real x);

double  log1p(double x);
float   log1pf(float x);
real    log1pl(real x);

double  log2(double x);
float   log2f(float x);
real    log2l(real x);

double  logb(double x);
float   logbf(float x);
real    logbl(real x);

double  modf(double value, double* iptr);
float   modff(float value, float* iptr);
real    modfl(real value, real *iptr);

double  scalbn(double x, int n);
float   scalbnf(float x, int n);
real    scalbnl(real x, int n);

double  scalbln(double x, c_long n);
float   scalblnf(float x, c_long n);
real    scalblnl(real x, c_long n);

double  cbrt(double x);
float   cbrtf(float x);
real    cbrtl(real x);

double  fabs(double x);
float   fabsf(float x);
real    fabsl(real x);

double  hypot(double x, double y);
float   hypotf(float x, float y);
real    hypotl(real x, real y);

double  pow(double x, double y);
float   powf(float x, float y);
real    powl(real x, real y);

double  sqrt(double x);
float   sqrtf(float x);
real    sqrtl(real x);

double  erf(double x);
float   erff(float x);
real    erfl(real x);

double  erfc(double x);
float   erfcf(float x);
real    erfcl(real x);

double  lgamma(double x);
float   lgammaf(float x);
real    lgammal(real x);

double  tgamma(double x);
float   tgammaf(float x);
real    tgammal(real x);

double  ceil(double x);
float   ceilf(float x);
real    ceill(real x);

double  floor(double x);
float   floorf(float x);
real    floorl(real x);

double  nearbyint(double x);
float   nearbyintf(float x);
real    nearbyintl(real x);

double  rint(double x);
float   rintf(float x);
real    rintl(real x);

c_long  lrint(double x);
c_long  lrintf(float x);
c_long  lrintl(real x);

long    llrint(double x);
long    llrintf(float x);
long    llrintl(real x);

double  round(double x);
float   roundf(float x);
real    roundl(real x);

c_long  lround(double x);
c_long  lroundf(float x);
c_long  lroundl(real x);

long    llround(double x);
long    llroundf(float x);
long    llroundl(real x);

double  trunc(double x);
float   truncf(float x);
real    truncl(real x);

double  fmod(double x, double y);
float   fmodf(float x, float y);
real    fmodl(real x, real y);

double  remainder(double x, double y);
float   remainderf(float x, float y);
real    remainderl(real x, real y);

double  remquo(double x, double y, int* quo);
float   remquof(float x, float y, int* quo);
real    remquol(real x, real y, int* quo);

double  copysign(double x, double y);
float   copysignf(float x, float y);
real    copysignl(real x, real y);

double  nan(char* tagp);
float   nanf(char* tagp);
real    nanl(char* tagp);

double  nextafter(double x, double y);
float   nextafterf(float x, float y);
real    nextafterl(real x, real y);

double  nexttoward(double x, real y);
float   nexttowardf(float x, real y);
real    nexttowardl(real x, real y);

double  fdim(double x, double y);
float   fdimf(float x, float y);
real    fdiml(real x, real y);

double  fmax(double x, double y);
float   fmaxf(float x, float y);
real    fmaxl(real x, real y);

double  fmin(double x, double y);
float   fminf(float x, float y);
real    fminl(real x, real y);

double  fma(double x, double y, double z);
float   fmaf(float x, float y, float z);
real    fmal(real x, real y, real z);
