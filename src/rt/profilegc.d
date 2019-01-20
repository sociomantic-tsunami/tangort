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
import rt.util.hashtab;

struct Entry { size_t count, size; }

char[] buffer;
HashTab!(char[], Entry) newCounts;
char[] logfilename = "profilegc.log";

/****
 * Set file name for output.
 * A file name of "" means write results to stdout.
 * Params:
 *      name = file name
 */

extern (C) void profilegc_setlogfilename(char[] name)
{
    logfilename = name ~ "\0";
}

public void accumulate(char[] file, uint line, char[] funcname, char[] type,
    size_t sz)
{
    if (sz == 0)
        return;

    char[3 * line.sizeof + 1] buf;
    auto buflen = snprintf(buf.ptr, buf.length, "%u".ptr, line);

    auto ln = type.length + 1 + funcname.length + 1 + file.length + 1 + buflen;
    if (ln > buffer.length)
    {
        // Enlarge buffer[] so it is big enough
        assert(buffer.length > 0 || buffer.ptr is null);
        auto p = cast(char*)realloc(buffer.ptr, ln + 1);
        if (!p)
            onOutOfMemoryError();
        buffer = p[0 .. ln + 1];
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
    buffer[ln] = 0;

    if (auto pcount = buffer[0 .. ln] in newCounts)
    { // existing entry
        pcount.count++;
        pcount.size += sz;
    }
    else
    {
        auto key = (cast(char*) malloc(char.sizeof * ln))[0 .. ln];
        key[] = buffer[0..ln];
        newCounts[key] = Entry(1, sz); // new entry
    }
}

// Write report to stderr
static ~this()
{
    static struct Result
    {
        char[] name;
        Entry entry;

        // qsort() comparator to sort by count field
        extern (C) static int qsort_cmp(void *r1, void *r2)
        {
            auto result1 = cast(Result*)r1;
            auto result2 = cast(Result*)r2;

            ptrdiff_t cmp = result2.entry.size - result1.entry.size;
            if (cmp) return cmp < 0 ? -1 : 1;
            cmp = result2.entry.count - result1.entry.count;
            if (cmp) return cmp < 0 ? -1 : 1;

            if (result2.name == result1.name)
                return 0;
            // ascending order for names reads better
            return result2.name > result1.name ? -1 : 1;
        }
    }

    size_t size = newCounts.length;
    Result[] counts = (cast(Result*) malloc(size * Result.sizeof))[0 .. size];
    scope(exit)
        free(counts.ptr);

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
        FILE* fp = logfilename.length == 0 ? stdout : fopen(logfilename.ptr, "w".ptr);
        if (fp)
        {
            fprintf(fp, "bytes allocated, allocations, type, function, file:line\n".ptr);
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
            fprintf(stderr, "cannot write profilegc log file '%.*s'".ptr, logfilename.length, logfilename.ptr);
    }
}
