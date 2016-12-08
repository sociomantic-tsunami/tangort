/**
 * This module exposes functionality for inspecting and manipulating memory.
 *
 * Copyright: Copyright (C) 2005-2006 Digital Mars, www.digitalmars.com.
 *            All rights reserved.
 * License:
 *  This software is provided 'as-is', without any express or implied
 *  warranty. In no event will the authors be held liable for any damages
 *  arising from the use of this software.
 *
 *  Permission is granted to anyone to use this software for any purpose,
 *  including commercial applications, and to alter it and redistribute it
 *  freely, in both source and binary form, subject to the following
 *  restrictions:
 *
 *  o  The origin of this software must not be misrepresented; you must not
 *     claim that you wrote the original software. If you use this software
 *     in a product, an acknowledgment in the product documentation would be
 *     appreciated but is not required.
 *  o  Altered source versions must be plainly marked as such, and must not
 *     be misrepresented as being the original software.
 *  o  This notice may not be removed or altered from any source
 *     distribution.
 * Authors:   Walter Bright, Sean Kelly
 */
module rt.memory;

version (linux) { }
else
{
    static assert (false, "Operating system not supported.");
}

alias void delegate( void*, void* ) scanFn;

extern (C):

extern void* __libc_stack_end;
extern void* rt_get_data_start();
extern void* rt_get_data_end();

void rt_scanStaticData( scanFn scan )
{
    scan( rt_get_data_start(), rt_get_data_end() );
}

void* rt_stackBottom()
{
    return __libc_stack_end;
}

void* rt_stackTop()
{
    version( D_InlineAsm_X86 )
    {
        asm
        {
            naked;
            mov EAX, ESP;
            ret;
        }
    }
    else version( D_InlineAsm_X86_64 )
    {
        asm
        {
            naked;
            mov RAX, RSP;
            ret;
        }
    }
    else
    {
            static assert( false, "Architecture not supported." );
    }
}

version (UnitTest)
{
    extern (C) static void gc_collect();
    static char[][] re = [ "Hello", "World", "Llama" ];
}

unittest
{
    for (size_t i; i < 3; ++i)
        re[i] = re[i] ~ "Foobar";
    gc_collect();
    assert (re[0] == "HelloFoobar");
    assert (re[1] == "WorldFoobar");
    assert (re[2] == "LlamaFoobar");
}
