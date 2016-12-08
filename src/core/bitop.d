module core.bitop;

public import std.intrinsic;

/**
 *  Calculates the number of set bits in a 32-bit integer.
 */
int popcnt( uint x )
{
    // Avoid branches, and the potential for cache misses which
    // could be incurred with a table lookup.

    // We need to mask alternate bits to prevent the
    // sum from overflowing.
    // add neighbouring bits. Each bit is 0 or 1.
    x = x - ((x>>1) & 0x5555_5555);
    // now each two bits of x is a number 00,01 or 10.
    // now add neighbouring pairs
    x = ((x&0xCCCC_CCCC)>>2) + (x&0x3333_3333);
    // now each nibble holds 0000-0100. Adding them won't
    // overflow any more, so we don't need to mask any more

    // Now add the nibbles, then the bytes, then the words
    // We still need to mask to prevent double-counting.
    // Note that if we used a rotate instead of a shift, we
    // wouldn't need the masks, and could just divide the sum
    // by 8 to account for the double-counting.
    // On some CPUs, it may be faster to perform a multiply.

    x += (x>>4);
    x &= 0x0F0F_0F0F;
    x += (x>>8);
    x &= 0x00FF_00FF;
    x += (x>>16);
    x &= 0xFFFF;
    return x;
}

unittest
{
    assert( popcnt( 0 ) == 0 );
    assert( popcnt( 7 ) == 3 );
    assert( popcnt( 0xAA )== 4 );
    assert( popcnt( 0x8421_1248 ) == 8 );
    assert( popcnt( 0xFFFF_FFFF ) == 32 );
    assert( popcnt( 0xCCCC_CCCC ) == 16 );
    assert( popcnt( 0x7777_7777 ) == 24 );
}

/**
 * Reverses the order of bits in a 32-bit integer.
 */
uint bitswap( uint x )
{
    version( D_InlineAsm_X86 )
    {
        asm
        {
            // Author: Tiago Gasiba.
            mov EDX, EAX;
            shr EAX, 1;
            and EDX, 0x5555_5555;
            and EAX, 0x5555_5555;
            shl EDX, 1;
            or  EAX, EDX;
            mov EDX, EAX;
            shr EAX, 2;
            and EDX, 0x3333_3333;
            and EAX, 0x3333_3333;
            shl EDX, 2;
            or  EAX, EDX;
            mov EDX, EAX;
            shr EAX, 4;
            and EDX, 0x0f0f_0f0f;
            and EAX, 0x0f0f_0f0f;
            shl EDX, 4;
            or  EAX, EDX;
            bswap EAX;
        }
    }
    else
    {
        // swap odd and even bits
        x = ((x >> 1) & 0x5555_5555) | ((x & 0x5555_5555) << 1);
        // swap consecutive pairs
        x = ((x >> 2) & 0x3333_3333) | ((x & 0x3333_3333) << 2);
        // swap nibbles
        x = ((x >> 4) & 0x0F0F_0F0F) | ((x & 0x0F0F_0F0F) << 4);
        // swap bytes
        x = ((x >> 8) & 0x00FF_00FF) | ((x & 0x00FF_00FF) << 8);
        // swap 2-byte long pairs
        x = ( x >> 16              ) | ( x               << 16);
        return x;

    }
}

unittest
{
    assert( bitswap( 0x8000_0100 ) == 0x0080_0001 );
}
