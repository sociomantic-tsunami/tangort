/*
 * Data collection and report generation for
 *   -profile=gc
 * switch
 *
 * Copyright: Copyright Digital Mars 2015 - 2015.
 * License: Distributed under the
 *      $(LINK2 http://www.boost.org/LICENSE_1_0.txt, Boost Software License 1.0).
 *    (See accompanying file LICENSE)
 * Authors:   Andrei Alexandrescu and Walter Bright
 * Source: $(DRUNTIMESRC src/rt/_profilegc.d)
 */

module rt.profilegc;

private:

import core.stdc.stdio;
import core.stdc.stdlib;
import core.stdc.string;

import core.exception : onOutOfMemoryError;

struct Entry { size_t count, size; }

char[] buffer;
Entry[char[]] newCounts;


public void accumulate(char[] file, uint line, char[] funcname, char[] type, size_t sz)
{
    char[3 * line.sizeof + 1] buf;
    auto buflen = snprintf(buf.ptr, buf.length, "%u".ptr, line);

    auto lngth = type.length + 1 + funcname.length + 1 + file.length + 1 + buflen;
    if (lngth > buffer.length)
    {
        // Enlarge buffer[] so it is big enough
        auto p = cast(char*)realloc(buffer.ptr, lngth);
        if (!p)
            onOutOfMemoryError();
        buffer = p[0 .. lngth];
    }

    // "type funcname file:line"
    buffer[0 .. type.length] = type[];
    buffer[type.length] = ' ';
    buffer[type.length + 1 ..
           type.length + 1 + funcname.length] = funcname[];
    buffer[type.length + 1 + funcname.length] = ' ';
    buffer[type.length + 1 + funcname.length + 1 ..
           type.length + 1 + funcname.length + 1 + file.length] = file[];
    buffer[type.length + 1 + funcname.length + 1 + file.length] = ':';
    buffer[type.length + 1 + funcname.length + 1 + file.length + 1 ..
           type.length + 1 + funcname.length + 1 + file.length + 1 + buflen] = buf[0 .. buflen];

    if (auto pcount = cast(char[])buffer[0 .. lngth] in newCounts)
    { // existing entry
        pcount.count++;
        pcount.size += sz;
    }
    else
        newCounts[buffer[0..lngth].dup] = Entry(1, sz); // new entry
}

// Write report to stderr
extern(C) void write_profilegc_report ( char[] logfilename )
{
    static struct Result
    {
        char[] name;
        Entry entry;

        // qsort() comparator to sort by count field
        extern (C) static int qsort_cmp(in void *r1, in void *r2)
        {
            auto result1 = cast(Result*)r1;
            auto result2 = cast(Result*)r2;
            ptrdiff_t cmp = result2.entry.size - result1.entry.size;
            if (cmp) return cmp < 0 ? -1 : 1;
            cmp = result2.entry.count - result1.entry.count;
            return cmp < 0 ? -1 : (cmp > 0 ? 1 : 0);
        }
    }

    Result[] counts = new Result[newCounts.length];

    size_t i;
    foreach (name, entry; newCounts)
    {
        counts[i].name = name;
        counts[i].entry = entry;
        ++i;
    }

    if (counts.length)
    {
        qsort(counts.ptr, counts.length, Result.sizeof, &Result.qsort_cmp);

        FILE* fp = logfilename.length == 0 ? stdout : fopen((logfilename ~
            '\0').ptr, "w".ptr);
        if (fp)
        {
            fprintf(fp,
                "bytes allocated, allocations, type, function, file:line\n".ptr);
            foreach (ref c; counts)
            {
                fprintf(fp, "%15llu\t%15llu\t%8.*s\n".ptr,
                    cast(ulong)c.entry.size, cast(ulong)c.entry.count,
                    c.name.length, c.name.ptr);
            }
            if (logfilename.length)
                fclose(fp);
        }
        else
            fprintf(stderr, "cannot write profilegc log file '%.*s'".ptr,
                logfilename.length, logfilename.ptr);
    }
}
