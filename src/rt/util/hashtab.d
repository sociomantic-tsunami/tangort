/**
 * HashTab container for internal usage.
 *
 * Copyright: Copyright Martin Nowak 2013.
 * License:   $(HTTP www.boost.org/LICENSE_1_0.txt, Boost License 1.0).
 * Authors:   Martin Nowak
 */
module rt.util.hashtab;

import rt.util.array;
static import common = rt.util.common;

struct HashTab(Key, Value)
{
    static struct Node
    {
        Key _key;
        Value _value;
        Node* _next;

        void reset () {}
    }

    void reset()
    {
        foreach (p; _buckets[])
        {
            while (p !is null)
            {
                auto pn = p._next;
                common.destroy(*p);
                common.free(p);
                p = pn;
            }
        }
        _buckets.reset();
        _length = 0;
    }

    size_t length()
    {
        return _length;
    }

    bool empty()
    {
        return !_length;
    }

    void remove(in Key key)
    in { assert(key in *this); }
    body
    {
        ensureNotInOpApply();

        auto hash = hashOf(key) & mask;
        auto head = _buckets[hash];
        auto pp = &head;
        while (*pp)
        {
            auto p = *pp;
            if (p._key == key)
            {
                *pp = p._next;
                common.destroy(*p);
                common.free(p);
                if (--_length < _buckets.length && _length >= 4)
                    shrink();
                return;
            }
            else
            {
                pp = &p._next;
            }
        }
        assert(0);
    }

    Value opIndex(Key key)
    {
        return *opIn_r(key);
    }

    void opIndexAssign(Value value, Key key)
    {
        *get(key) = value;
    }

    Value* opIn_r(Key key)
    {
        if (_buckets.length)
        {
            auto hash = hashOf(key) & mask;
            for (auto p = _buckets[hash]; p !is null; p = p._next)
            {
                if (p._key == key)
                    return &p._value;
            }
        }
        return null;
    }

    int opApply(int delegate(ref Key, ref Value) dg)
    {
        auto save = _inOpApply;
        _inOpApply = true;
        scope (exit) _inOpApply = save;
        foreach (p; _buckets[])
        {
            while (p !is null)
            {
                if (auto res = dg(p._key, p._value))
                    return res;
                p = p._next;
            }
        }
        return 0;
    }

private:

    Value* get(Key key)
    {
        if (auto p = opIn_r(key))
            return p;

        ensureNotInOpApply();

        if (!_buckets.length)
            _buckets.length = 4;

        auto hash = hashOf(key) & mask;
        auto p = cast(Node*)common.xmalloc(Node.sizeof);
        common.initialize(*p);
        p._key = key;
        p._next = _buckets[hash];
        _buckets[hash] = p;
        if (++_length >= 2 * _buckets.length)
            grow();
        return &p._value;
    }

    static hash_t hashOf(ref Key key)
    {
        return typeid(Key).getHash(&key);
    }

    hash_t mask()
    {
        return _buckets.length - 1;
    }

    void grow()
    in
    {
        assert(_buckets.length);
    }
    body
    {
        auto ocnt = _buckets.length;
        auto nmask = 2 * ocnt - 1;
        _buckets.length = 2 * ocnt;
        for (size_t i = 0; i < ocnt; ++i)
        {
            auto head = _buckets[i];
            auto pp = &head;
            while (*pp)
            {
                auto p = *pp;

                auto nidx = hashOf(p._key) & nmask;
                if (nidx != i)
                {
                    *pp = p._next;
                    p._next = _buckets[nidx];
                    _buckets[nidx] = p;
                }
                else
                {
                    pp = &p._next;
                }
            }
        }
    }

    void shrink()
    in
    {
        assert(_buckets.length >= 2);
    }
    body
    {
        auto ocnt = _buckets.length;
        auto ncnt = ocnt >> 1;
        auto nmask = ncnt - 1;

        for (size_t i = ncnt; i < ocnt; ++i)
        {
            if (auto tail = _buckets[i])
            {
                auto nidx = i & nmask;
                auto head = _buckets[nidx];
                auto pp = &head;
                while (*pp)
                    pp = &(*pp)._next;
                *pp = tail;
                _buckets[i] = null;
            }
        }
        _buckets.length = ncnt;
    }

    void ensureNotInOpApply()
    {
        if (_inOpApply)
            assert(0, "Invalid HashTab manipulation during opApply iteration.");
    }

    Array!(Node*) _buckets;
    size_t _length;
    bool _inOpApply;
}

unittest
{
    HashTab!(char[], size_t) tab;

    tab["foo"] = 0;
    assert(tab["foo"] == 0);
    tab["foo"] = tab["foo"] + 1;
    assert(tab["foo"] == 1);

    char[] s = "fo";
    s ~= "o";
    assert(tab[s] == 1);
    assert(tab.length == 1);
    auto x = tab[s];
    tab[s] = x - 1;
    assert(tab[s] == 0);
    tab["foo"] = 12;
    assert(tab[s] == 12);

    tab.remove("foo");
    assert(tab.empty);
}
