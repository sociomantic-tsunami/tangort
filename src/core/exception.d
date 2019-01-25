/**
 * The exception module defines all system-level exceptions and provides a
 * mechanism to alter system-level error handling.
 *
 * Copyright: Copyright (C) 2005-2006 Sean Kelly, Kris Bell.  All rights reserved.
 * License:   BSD style: $(LICENSE)
 * Authors:   Sean Kelly, Kris Bell
 */
module core.exception;

version = SocketSpecifics;              // TODO: remove this before v1.0

private
{
    alias Exception Error;

    alias void  function( char[] file, size_t line, char[] msg = null ) assertHandlerType;

    version(D_Version2)
    {
        mixin("__gshared assertHandlerType assertHandler   = null;");
    }
    else
    {
        assertHandlerType assertHandler   = null;
    }
}



/**
 * Thrown on an out of memory error.
 */
class OutOfMemoryError : Error
{
    this( char[] file, long line )
    {
        super( "Memory allocation failed", file, line );
    }

    override char[] toString()
    {
        return msg ? super.toString() : "Memory allocation failed";
    }
}

/**
 * Thrown on an assert error.
 */
class AssertError : Error
{
    this( char[] file, long line )
    {
        super( "Assertion failure", file, line );
    }

    this( char[] msg, char[] file, long line )
    {
        super( msg, file, line );
    }
}


/**
 * Thrown on an array bounds error.
 */
class RangeError : Error
{
    this( char[] file, long line )
    {
        super( "Array index out of bounds", file, line );
    }
}


/**
 * Thrown on finalize error.
 */
class FinalizeError : Error
{
    import core.stdc.stdio;

    ClassInfo   info;

    this( ClassInfo c, Exception e )
    {
        super( "Finalization error", e );
        info = c;
    }

    override char[] toString()
    {
        char[] chained_exception;

        if (super.next)
        {
            char[16] line_buf;
            cast(void)snprintf(line_buf.ptr, line_buf.length,
                    "%ld".ptr, super.next.line);

            chained_exception =
                super.next.toString ~ "@" ~ super.next.file ~ ":" ~ line_buf;
        }
        else
        {
            chained_exception = "unknown";
        }

        return "An exception was thrown while finalizing an instance of class " ~
            info.name ~ " :: " ~ chained_exception;
    }
}


/**
 * Thrown on a switch error.
 */
class SwitchError : Error
{
    this( char[] file, long line )
    {
        super( "No appropriate switch clause found", file, line );
    }
}


/**
 * Thrown on a unicode conversion error.
 */
class UnicodeException : Exception
{
    size_t idx;

    this( char[] msg, size_t idx )
    {
        super( msg );
        this.idx = idx;
    }
}

////////////////////////////////////////////////////////////////////////////////
// Overrides
////////////////////////////////////////////////////////////////////////////////


/**
 * Overrides the default assert hander with a user-supplied version.
 *
 * Params:
 *  h = The new assert handler.  Set to null to use the default handler.
 */
void setAssertHandler( assertHandlerType h )
{
    assertHandler = h;
}


////////////////////////////////////////////////////////////////////////////////
// Overridable Callbacks
////////////////////////////////////////////////////////////////////////////////


/**
 * A callback for assert errors in D.  The user-supplied assert handler will
 * be called if one has been supplied, otherwise an AssertionError will be
 * thrown.
 *
 * Params:
 *  file = The name of the file that signaled this error.
 *  line = The line number on which this error occurred.
 */
extern (C) void onAssertError( char[] file, size_t line )
{
    if( assertHandler is null )
        throw new AssertError( file, cast(long)line );
    assertHandler( file, line );
}


/**
 * A callback for assert errors in D.  The user-supplied assert handler will
 * be called if one has been supplied, otherwise an AssertionError will be
 * thrown.
 *
 * Params:
 *  file = The name of the file that signaled this error.
 *  line = The line number on which this error occurred.
 *  msg  = An error message supplied by the user.
 */
extern (C) void onAssertErrorMsg( char[] file, size_t line, char[] msg )
{
    if( assertHandler is null )
        throw new AssertError( msg, file, cast(long)line );
    assertHandler( file, line, msg );
}


////////////////////////////////////////////////////////////////////////////////
// Internal Error Callbacks
////////////////////////////////////////////////////////////////////////////////


/**
 * A callback for array bounds errors in D.  An RangeError will be
 * thrown.
 *
 * Params:
 *  file = The name of the file that signaled this error.
 *  line = The line number on which this error occurred.
 *
 * Throws:
 *  RangeError.
 */
extern (C) void onArrayBoundsError( char[] file, size_t line )
{
    throw new RangeError( file, cast(long)line );
}

/**
 * Compatibility with D2 runtime
 */
extern (C) void onRangeError( char[] file, size_t line )
{
    onArrayBoundsError(file, line);
}

/**
 * A callback for finalize errors in D.  A FinalizeError will be thrown.
 *
 * Params:
 *  e = The exception thrown during finalization.
 *
 * Throws:
 *  FinalizeError.
 */
extern (C) void onFinalizeError( ClassInfo info, Exception ex )
{
    throw new FinalizeError( info, ex );
}


/**
 * A callback for out of memory errors in D.  An OutOfMemoryError will be
 * thrown.
 *
 * Throws:
 *  OutOfMemoryError.
 */
extern (C) void onOutOfMemoryError()
{
    // NOTE: Since an out of memory condition exists, no allocation must occur
    //       while generating this object.
    throw cast(OutOfMemoryError) cast(void*) OutOfMemoryError.classinfo.init;
}


/**
 * A callback for switch errors in D.  A SwitchError will be thrown.
 *
 * Params:
 *  file = The name of the file that signaled this error.
 *  line = The line number on which this error occurred.
 *
 * Throws:
 *  SwitchError.
 */
extern (C) void onSwitchError( char[] file, size_t line )
{
    throw new SwitchError( file, cast(long)line );
}


/**
 * A callback for unicode errors in D.  A UnicodeException will be thrown.
 *
 * Params:
 *  msg = Information about the error.
 *  idx = String index where this error was detected.
 *
 * Throws:
 *  UnicodeException.
 */
extern (C) void onUnicodeError( char[] msg, size_t idx )
{
    throw new UnicodeException( msg, idx );
}
