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

extern (C) Object _d_newclassTrace(char[] file, int line, char[] funcname, in ClassInfo ci)
{
    accumulate(file, line, funcname, ci.name, ci.init.length);
    return _d_newclass(ci);
}

extern (C) void[] _d_newarrayTTrace(char[] file, int line, char[] funcname, in TypeInfo ti, size_t length)
{
    accumulate(file, line, funcname, ti.toString(), ti.tsize * length);
    return _d_newarrayT(ti, length);
}

extern (C) void[] _d_newarrayiTTrace(char[] file, int line, char[] funcname, in TypeInfo ti, size_t length)
{
    accumulate(file, line, funcname, ti.toString(), ti.tsize * length);
    return _d_newarrayiT(ti, length);
}

extern (C) void[] _d_newarraymTXTrace(char[] file, int line, char[] funcname, in TypeInfo ti, size_t[] dims)
{
    size_t n = 1;
    foreach (dim; dims)
        n *= dim;
    accumulate(file, line, funcname, ti.toString(), ti.tsize * n);
    return _d_newarraymTX(ti, dims);
}

extern (C) void[] _d_newarraymiTXTrace(char[] file, int line, char[] funcname,
    in TypeInfo ti, size_t[] dims)
{
    size_t n = 1;
    foreach (dim; dims)
        n *= dim;
    accumulate(file, line, funcname, ti.toString(), ti.tsize * n);
    return _d_newarraymiTX(ti, dims);
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
    accumulate(file, line, funcname, ti.toString(), ti.next.tsize * length);
    return _d_arrayliteralTX(ti, length);
}

extern (C) void* _d_assocarrayliteralTXTrace(char[] file, int line, char[] funcname,
        in TypeInfo_AssociativeArray ti, void[] keys, void[] vals)
{
    accumulate(file, line, funcname, ti.toString(), (ti.key.tsize + ti.value.tsize) * keys.length);
    return _d_assocarrayliteralTX(ti, keys, vals);
}

extern (C) byte[] _d_arraycatTTrace(char[] file, int line, char[] funcname,
    in TypeInfo ti, byte[] x, byte[] y)
{
    accumulate(file, line, funcname, ti.toString(), (x.length + y.length) * ti.next.tsize);
    return _d_arraycatT(ti, x, y);
}

extern (C) void[] _d_arraycatnTXTrace(char[] file, int line, char[] funcname,
    in TypeInfo ti, byte[][] arrs)
{
    size_t length;
    foreach (b; arrs)
        length += b.length;
    accumulate(file, line, funcname, ti.toString(), length * ti.next.tsize);
    return _d_arraycatnTX(ti, arrs);
}

extern (C) void[] _d_arrayappendTTrace(char[] file, int line, char[] funcname,
    in TypeInfo ti, ref byte[] x, byte[] y)
{
    accumulate(file, line, funcname, ti.toString(), ti.next.tsize * y.length);
    return _d_arrayappendT(ti, x, y);
}

extern (C) byte[] _d_arrayappendcTXTrace(char[] file, int line, char[] funcname,
    in TypeInfo ti, ref byte[] px, size_t n)
{
    accumulate(file, line, funcname, ti.toString(), ti.next.tsize * n);
    return _d_arrayappendcTX(ti, px, n);
}

extern (C) void[] _d_arrayappendcdTrace(char[] file, int line, char[] funcname, ref byte[] x, dchar c)
{
    size_t n;
    if (c <= 0x7F)
        n = 1;
    else if (c <= 0x7FF)
        n = 2;
    else if (c <= 0xFFFF)
        n = 3;
    else if (c <= 0x10FFFF)
        n = 4;
    else
        assert(0);
    accumulate(file, line, funcname, "char[]", n * char.sizeof);
    return _d_arrayappendcd(x, c);
}

extern (C) void[] _d_arrayappendwdTrace(char[] file, int line, char[] funcname, ref byte[] x, dchar c)
{
    size_t n = 1 + (c > 0xFFFF);
    accumulate(file, line, funcname, "wchar[]", n * wchar.sizeof);
    return _d_arrayappendwd(x, c);
}

extern (C) void[] _d_arraysetlengthTTrace(char[] file, int line,
    char[] funcname, in TypeInfo ti, size_t newlength, void[]* p)
{
    accumulate(file, line, funcname, ti.toString(), ti.next.tsize * newlength);
    return _d_arraysetlengthT(ti, newlength, p);
}

extern (C) void[] _d_arraysetlengthiTTrace(char[] file, int line,
    char[] funcname, in TypeInfo ti, size_t newlength, void[]* p)
{
    accumulate(file, line, funcname, ti.toString(), ti.next.tsize * newlength);
    return _d_arraysetlengthiT(ti, newlength, p);
}
