/**
 * Array container for internal usage.
 *
 * Copyright: Copyright Martin Nowak 2013.
 * License:   $(HTTP www.boost.org/LICENSE_1_0.txt, Boost License 1.0).
 * Authors:   Martin Nowak
 */
module rt.util.array;

static import common = rt.util.common;
import core.exception;

struct Array(T)
{
    void reset()
    {
        length = 0;
    }

    size_t length()
    {
        return _length;
    }

    void length(size_t nlength)
    {
        size_t reqsize = T.sizeof * nlength;
        if (nlength < _length)
            foreach (ref val; _ptr[nlength .. _length]) common.destroy(val);
        _ptr = cast(T*)common.xrealloc(_ptr, reqsize);
        if (nlength > _length)
            foreach (ref val; _ptr[_length .. nlength]) common.initialize(val);
        _length = nlength;
    }

    bool empty()
    {
        return !length;
    }

    T* front()
    in { assert(!empty); }
    body
    {
        return &_ptr[0];
    }

    T* back()
    in { assert(!empty); }
    body
    {
        return &_ptr[_length - 1];
    }

    T opIndex(size_t idx)
    in { assert(idx < length); }
    body
    {
        return _ptr[idx];
    }

    void opIndexAssign(T value, size_t idx)
    in { assert(idx < length); }
    body
    {
        _ptr[idx] = value;
    }

    T[] opSlice()
    {
        return _ptr[0 .. _length];
    }

    T[] opSlice(size_t a, size_t b)
    in { assert(a < b && b <= length); }
    body
    {
        return _ptr[a .. b];
    }

    void insertBack()(T val)
    {
        length = length + 1;
        *back() = val;
    }

    void popBack()
    {
        length = length - 1;
    }

    void remove(size_t idx)
    in { assert(idx < length); }
    body
    {
        for (auto i = idx; i < length - 1; ++i)
            _ptr[i] = _ptr[i+1];
        popBack();
    }

    void swap(ref Array other)
    {
        auto ptr = _ptr;
        _ptr = other._ptr;
        other._ptr = ptr;
        auto len = _length;
        _length = other._length;
        other._length = len;
    }

    invariant
    {
        assert(!_ptr == !_length);
    }

private:
    T* _ptr;
    size_t _length;
}

unittest
{
    Array!(int) ary;

    assert(ary[] == null);
    ary.insertBack(5);
    assert(ary[] == [5]);
    ary.popBack();
    assert(ary[] == null);
    ary.insertBack(0);
    ary.insertBack(1);
    assert(ary[] == [0, 1]);
    assert(ary[0 .. 1] == [0]);
    assert(ary[1 .. 2] == [1]);
    assert(ary[ary.length - 2 .. ary.length] == [0, 1]);
    size_t idx;
    foreach (val; ary[]) assert(idx++ == val);
    foreach (i, val; ary[]) assert(i == val);

    ary.insertBack(2);
    ary.remove(1);
    assert(ary[] == [0, 2]);

    assert(!ary.empty);
    ary.reset();
    assert(ary.empty);
    ary.insertBack(0);
    assert(!ary.empty);
    common.destroy(ary);
    assert(ary.empty);

    Array!(int) ary2;

    ary2.insertBack(0);
    assert(ary.empty);
    assert(ary2[] == [0]);
    ary.swap(ary2);
    assert(ary[] == [0]);
    assert(ary2.empty);
}
