/**
 * D header file for C99.
 *
 * Copyright: Public Domain
 * License:   Public Domain
 * Authors:   Sean Kelly
 * Standards: ISO/IEC 9899:1999 (E)
 */
module core.stdc.errno;

private
{
    extern (C) int getErrno();
    extern (C) int setErrno(int);
}

int errno()          { return getErrno();      }
int errno( int val ) { return setErrno( val ); }

version(X86) {
    version=X86_CPU;
} else version(X86_64) {
    version=X86_CPU;
} else version ( PPC64 )
{
    version=PPC_CPU;
} else version ( PPC ) {
    version=PPC_CPU;
} else version(ARM){
} else version(SPARC){
} else {
    static assert(0,"unknown cpu family");
}

enum {
    E2BIG = 7, // Argument list too long
    EACCES = 13, // Permission denied
    EADDRINUSE = 98, // Address already in use
    EADDRNOTAVAIL = 99, // Can't assign requested address
    EADV = 68, // Advertise error
    EAFNOSUPPORT = 97, // Address family not supported by protocol family
    EAGAIN = 11, // Resource temporarily unavailable
    EALREADY = 114, // Operation already in progress
    EBADE = 52, // Invalid exchange
    EBADF = 9, // Bad file descriptor
    EBADFD = 77, // File descriptor in bad state
    EBADMSG = 74, // Bad message
    EBADR = 53, // Invalid request descriptor
    EBADRQC = 56, // Invalid request code
    EBADSLT = 57, // Invalid slot
    EBFONT = 59, // Bad font file format
    EBUSY = 16, // Device busy
    ECANCELED = 125, // Operation canceled
    ECHILD = 10, // No child processes
    ECHRNG = 44, // Channel number out of range
    ECOMM = 70, // Communication error on send
    ECONNABORTED = 103, // Software caused connection abort
    ECONNREFUSED = 111, // Connection refused
    ECONNRESET = 104, // Connection reset by peer
    EDEADLK = 35, // Resource deadlock avoided
    EDESTADDRREQ = 89, // Destination address required
    EDOM = 33, // Numerical argument out of domain
    EDOTDOT = 73, // RFS specific error
    EDQUOT = 122, // Disc quota exceeded
    EEXIST = 17, // File exists
    EFAULT = 14, // Bad address
    EFBIG = 27, // File too large
    EHOSTDOWN = 112, // Host is down
    EHOSTUNREACH = 113, // No route to host
    EIDRM = 43, // Itendifier removed
    EILSEQ = 84, // Illegal byte sequence
    EINPROGRESS = 115, // Operation now in progress
    EINTR = 4, // Interrupted system call
    EINVAL = 22, // Invalid argument
    EIO = 5, // Input/output error
    EISCONN = 106, // Socket is already connected
    EISDIR = 21, // Is a directory
    EISNAM = 120, // Is a named type file
    EKEYEXPIRED = 127, // Key has expired
    EKEYREJECTED = 129, // Key was rejected by service
    EKEYREVOKED = 128, // Key has been revoked
    EL2HLT = 51, // Level 2 halted
    EL2NSYNC = 45, // Level 2 not synchronized
    EL3HLT = 46, // Level 3 halted
    EL3RST = 47, // Level 3 reset
    ELIBACC = 79, // Can not access a needed shared library
    ELIBBAD = 80, // Accessing a corrupted shared library
    ELIBEXEC = 83, // Cannot exec a shared library directly
    ELIBMAX = 82, // Attempting to link in too many shared libraries
    ELIBSCN = 81, // .lib section in a.out corrupted
    ELNRNG = 48, // Link number out of range
    ELOOP = 40, // Too many levels of symbolic links
    EMEDIUMTYPE = 124, // Wrong medium type
    EMFILE = 24, // Too many open files
    EMLINK = 31, // Too many links
    EMSGSIZE = 90, // Message too long
    EMULTIHOP = 72, // Multihop attempted
    ENAMETOOLONG = 36, // File name too long
    ENAVAIL = 119, // No XENIX semaphores available
    ENETDOWN = 100, // Network is down
    ENETRESET = 102, // Network dropped connection on reset
    ENETUNREACH = 101, // Network is unreachable
    ENFILE = 23, // Too many open files in system
    ENOANO = 55, // No anode
    ENOBUFS = 105, // No buffer space available
    ENOCSI = 50, // No CSI structure available
    ENODATA = 61, // No message available on STREAM
    ENODEV = 19, // Operation not supported by device
    ENOENT = 2, // No such file or directory
    ENOEXEC = 8, // Exec format error
    ENOKEY = 126, // Required key not available
    ENOLCK = 37, // No locks available
    ENOLINK = 67, // Link has been severed
    ENOMEDIUM = 123, // No medium found
    ENOMEM = 12, // Cannot allocate memory
    ENOMSG = 42, // No message of desired type
    ENONET = 64, // Machine is not on the network
    ENOPKG = 65, // Package not installed
    ENOPROTOOPT = 92, // Protocol not available
    ENOSPC = 28, // No space left on device
    ENOSR = 63, // No STREAM resources
    ENOSTR = 60, // Not a STREAM
    ENOSYS = 38, // Function not implemented
    ENOTBLK = 15, // Block device required
    ENOTCONN = 107, // Socket is not connected
    ENOTDIR = 20, // Not a directory
    ENOTEMPTY = 39, // Directory not empty
    ENOTNAM = 118, // Not a XENIX named type file
    ENOTRECOVERABLE = 131, // State not recoverable
    ENOTSOCK = 88, // Socket operation on non-socket
    ENOTSUP = 95, // Operation not supported
    ENOTTY = 25, // Inappropriate ioctl for device
    ENOTUNIQ = 76, // Name not unique on network
    ENXIO = 6, // Device not configured
    EOPNOTSUPP = 95, // Operation not supported on socket
    EOVERFLOW = 75, // Value too large to be stored in data type
    EOWNERDEAD = 130, // Owner died
    EPERM = 1, // Operation not permitted
    EPFNOSUPPORT = 96, // Protocol family not supported
    EPIPE = 32, // Broken pipe
    EPROTO = 71, // Protocol error
    EPROTONOSUPPORT = 93, // Protocol not supported
    EPROTOTYPE = 91, // Protocol wrong type for socket
    ERANGE = 34, // Result too large
    EREMCHG = 78, // Remote address changed
    EREMOTE = 66, // Too many levels of remote in path
    EREMOTEIO = 121, // Remote I/O error
    ERESTART = 85, // Interrupted system call should be restarted
    EROFS = 30, // Read-only file system
    ESHUTDOWN = 108, // Can't send after socket shutdown
    ESOCKTNOSUPPORT = 94, // Socket type not supported
    ESPIPE = 29, // Illegal seek
    ESRCH = 3, // No such process
    ESRMNT = 69, // Srmount error
    ESTALE = 116, // Stale NFS file handle
    ESTRPIPE = 86, // Streams pipe error
    ETIME = 62, // STREAM ioctl timeout
    ETIMEDOUT = 110, // Operation timed out
    ETOOMANYREFS = 109, // Too many refrences, can't splice
    ETXTBSY = 26, // Text file busy
    EUCLEAN = 117, // Structure needs cleaning
    EUNATCH = 49, // Protocol driver not attached
    EUSERS = 87, // Too many users
    EWOULDBLOCK = 11, // Operation would block
    EXDEV = 18, // Cross-device link
    EXFULL = 54, // Exchange full
}
version(X86_CPU)
    enum { EDEADLOCK = 35, }
else version(PPC_CPU)
    enum { EDEADLOCK = 58, }
else static assert(0);
