/**
 * Contains implementations of functions called when the
 *   -profile=gc
 * switch is thrown.
 *
 * Copyright: Copyright Digital Mars 2015 - 2015.
 * License: Distributed under the
 *      $(LINK2 http://www.boost.org/LICENSE_1_0.txt, Boost Software License 1.0).
 *    (See accompanying file LICENSE)
 * Authors:   Walter Bright
 * Source: $(DRUNTIMESRC src/rt/_tracegc.d)
 */

module rt.tracegc;

import rt.profilegc;
import core.memory;

extern(C) void gc_resetLastAllocation();
extern(C) void gc_usage(size_t*,size_t*, size_t*);

extern (C) Object _d_newclass(in ClassInfo ci);
extern (C) void[] _d_newarrayT(in TypeInfo ti, size_t length);
extern (C) void[] _d_newarrayiT(in TypeInfo ti, size_t length);
extern (C) void[] _d_newarraymTX(in TypeInfo ti, size_t[] dims);
extern (C) void[] _d_newarraymiTX(in TypeInfo ti, size_t[] dims);
extern (C) void _d_callfinalizer(void* p);
extern (C) void _d_callinterfacefinalizer(void *p);
extern (C) void _d_delclass(Object* p);
extern (C) void _d_delinterface(void** p);
extern (C) void _d_delmemory(void* *p);
extern (C) void* _d_arrayliteralTX(in TypeInfo ti, size_t length);
extern (C) void* _d_assocarrayliteralTX(in TypeInfo_AssociativeArray ti,
    void[] keys, void[] vals);
extern (C) byte[] _d_arraycatT(in TypeInfo ti, byte[] x, byte[] y);
extern (C) void[] _d_arraycatnTX(in TypeInfo ti, byte[][] arrs);
extern (C) void[] _d_arrayappendT(in TypeInfo ti, ref byte[] x, byte[] y);
extern (C) byte[] _d_arrayappendcTX(in TypeInfo ti, ref byte[] px, size_t n);
extern (C) void[] _d_arrayappendcd(ref byte[] x, dchar c);
extern (C) void[] _d_arrayappendwd(ref byte[] x, dchar c);
extern (C) void[] _d_arraysetlengthT(in TypeInfo ti, size_t newlength, void[]* p);
extern (C) void[] _d_arraysetlengthiT(in TypeInfo ti, size_t newlength, void[]* p);

T count (T) (lazy T wrapped, char[] file, int line, char[] funcname, char[] name)
{
    gc_resetLastAllocation();
    T result = wrapped;
    size_t used, free, last;
    gc_usage(&used, &free, &last);
    if (last > 0)
        accumulate(file, line, funcname, name, last);
    return result;
}

extern (C) Object _d_newclassTrace(char[] file, int line, char[] funcname, in ClassInfo ci)
{
    return count(_d_newclass(ci), file, line, funcname, ci.name);
}

extern (C) void[] _d_newarrayTTrace(char[] file, int line, char[] funcname, in TypeInfo ti, size_t length)
{
    return count(_d_newarrayT(ti, length), file, line, funcname, ti.toString());
}

extern (C) void[] _d_newarrayiTTrace(char[] file, int line, char[] funcname, in TypeInfo ti, size_t length)
{
    return count(_d_newarrayiT(ti, length), file, line, funcname, ti.toString());
}

extern (C) void[] _d_newarraymTXTrace(char[] file, int line, char[] funcname, in TypeInfo ti, size_t[] dims)
{
    return count(_d_newarraymTX(ti, dims), file, line, funcname, ti.toString());
}

extern (C) void[] _d_newarraymiTXTrace(char[] file, int line, char[] funcname,
    in TypeInfo ti, size_t[] dims)
{
    return count(_d_newarraymiTX(ti, dims), file, line, funcname, ti.toString());
}

extern (C) void _d_callfinalizerTrace(char[] file, int line, char[] funcname, void* p)
{
    _d_callfinalizer(p);
}

extern (C) void _d_callinterfacefinalizerTrace(char[] file, int line, char[] funcname, void *p)
{
    _d_callinterfacefinalizer(p);
}

extern (C) void _d_delclassTrace(char[] file, int line, char[] funcname, Object* p)
{
    _d_delclass(p);
}

extern (C) void _d_delinterfaceTrace(char[] file, int line, char[] funcname, void** p)
{
    _d_delinterface(p);
}

extern (C) void _d_delmemoryTrace(char[] file, int line, char[] funcname, void* *p)
{
    _d_delmemory(p);
}

extern (C) void* _d_arrayliteralTXTrace(char[] file, int line, char[] funcname,
    in TypeInfo ti, size_t length)
{
    return count(_d_arrayliteralTX(ti, length), file, line, funcname, ti.toString());
}

extern (C) void* _d_assocarrayliteralTXTrace(char[] file, int line, char[] funcname,
        in TypeInfo_AssociativeArray ti, void[] keys, void[] vals)
{
    return count(_d_assocarrayliteralTX(ti, keys, vals), file, line, funcname, ti.toString());
}

extern (C) byte[] _d_arraycatTTrace(char[] file, int line, char[] funcname,
    in TypeInfo ti, byte[] x, byte[] y)
{
    return count(_d_arraycatT(ti, x, y), file, line, funcname, ti.toString());
}

extern (C) void[] _d_arraycatnTXTrace(char[] file, int line, char[] funcname,
    in TypeInfo ti, byte[][] arrs)
{
    return count(_d_arraycatnTX(ti, arrs), file, line, funcname, ti.toString());
}

extern (C) void[] _d_arrayappendTTrace(char[] file, int line, char[] funcname,
    in TypeInfo ti, ref byte[] x, byte[] y)
{
    return count(_d_arrayappendT(ti, x, y), file, line, funcname, ti.toString());
}

extern (C) byte[] _d_arrayappendcTXTrace(char[] file, int line, char[] funcname,
    in TypeInfo ti, ref byte[] px, size_t n)
{
    return count(_d_arrayappendcTX(ti, px, n), file, line, funcname, ti.toString());
}

extern (C) void[] _d_arrayappendcdTrace(char[] file, int line, char[] funcname, ref byte[] x, dchar c)
{
    return count(_d_arrayappendcd(x, c), file, line, funcname, "char[]");
}

extern (C) void[] _d_arrayappendwdTrace(char[] file, int line, char[] funcname, ref byte[] x, dchar c)
{
    return count(_d_arrayappendwd(x, c), file, line, funcname, "wchar[]");
}

extern (C) void[] _d_arraysetlengthTTrace(char[] file, int line,
    char[] funcname, in TypeInfo ti, size_t newlength, void[]* p)
{
    return count(_d_arraysetlengthT(ti, newlength, p), file, line, funcname, ti.toString());
}

extern (C) void[] _d_arraysetlengthiTTrace(char[] file, int line,
    char[] funcname, in TypeInfo ti, size_t newlength, void[]* p)
{
    return count(_d_arraysetlengthiT(ti, newlength, p), file, line, funcname, ti.toString());
}
