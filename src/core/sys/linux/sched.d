/*******************************************************************************

    D binding for Linux specific scheduler control methods.

    Defines functions sched_setaffinity and sched_getaffinity  and the data
    types they operate on.

    Copyright:  Copyright (c) 2016 dunnhumby Germany GmbH. All rights reserved.
    License:    $(WEB www.boost.org/LICENSE_1_0.txt, Boost License 1.0).
    Authors:    Nemanja Boric

*******************************************************************************/


module core.sys.linux.sched;

import core.sys.posix.sched;
import core.sys.posix.config;
import core.sys.posix.sys.types;

extern (C):
version (linux):

private // helpers
{

    /* Size definition for CPU sets.  */
    enum
    {
        __CPU_SETSIZE = 1024,
        __NCPUBITS  = 8 * cpu_mask.sizeof,
    }

    /* Macros */

    /* Basic access functions.  */
    size_t __CPUELT(size_t cpu)
    {
        return cpu / __NCPUBITS;
    }
    cpu_mask __CPUMASK(size_t cpu)
    {
        return 1UL << (cpu % __NCPUBITS);
    }

    cpu_mask __CPU_SET_S(size_t cpu, size_t setsize, cpu_set_t* cpusetp)
    {
        if (cpu < 8 * setsize)
        {
            cpusetp.__bits[__CPUELT(cpu)] |= __CPUMASK(cpu);
            return __CPUMASK(cpu);
        }

        return 0;
    }
}

/* Type for array elements in 'cpu_set_t'.  */
alias c_ulong cpu_mask;

/* Data structure to describe CPU mask.  */
struct cpu_set_t
{
    cpu_mask[__CPU_SETSIZE / __NCPUBITS] __bits;
}

/* Access macros for `cpu_set' (missing a lot of them) */

cpu_mask CPU_SET(size_t cpu, cpu_set_t* cpusetp)
{
     return __CPU_SET_S(cpu, cpu_set_t.sizeof, cpusetp);
}

/* Functions */
int sched_setaffinity(pid_t pid, size_t cpusetsize, cpu_set_t *mask);
int sched_getaffinity(pid_t pid, size_t cpusetsize, cpu_set_t *mask);

