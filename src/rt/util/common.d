/**
 * Common code for writing containers.
 *
 * Copyright: Copyright Martin Nowak 2013.
 * License:   $(HTTP www.boost.org/LICENSE_1_0.txt, Boost License 1.0).
 * Authors:   Martin Nowak
 */
module rt.util.common;

import core.exception;
import core.stdc.string;
import core.stdc.stdlib : malloc, realloc;
public import core.stdc.stdlib : free;

void* xrealloc(void* ptr, size_t sz)
{
    if (!sz) { .free(ptr); return null; }
    if (auto nptr = .realloc(ptr, sz)) return nptr;
    .free(ptr); onOutOfMemoryError();
    assert(0);
}

void* xmalloc(size_t sz)
{
    if (auto nptr = .malloc(sz))
        return nptr;
    onOutOfMemoryError();
    assert(0);
}

void destroy(T)(ref T t)
{
    static if (is(T == struct))
    {
        t.reset();
    }

    t = T.init;
}

void initialize(T)(ref T t)
{
    static if (is(T == struct))
    {
        if (auto p = typeid(T).initializer().ptr)
            memcpy(&t, p, T.sizeof);
        else
            memset(&t, 0, T.sizeof);
    }
    else
    {
        t = T.init;
    }
}
