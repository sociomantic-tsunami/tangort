/**
 * D header file for POSIX.
 *
 * Copyright: Public Domain
 * License:   Public Domain
 * Authors:   Sean Kelly
 * Standards: The Open Group Base Specifications Issue 6, IEEE Std 1003.1, 2004 Edition
 */
module core.sys.posix.sys.socket;

import core.sys.posix.config;
public import core.sys.posix.sys.types; // for ssize_t, size_t
public import core.sys.posix.sys.uio;   // for iovec

extern (C):

alias uint   socklen_t;
alias ushort sa_family_t;

struct sockaddr
{
    sa_family_t sa_family;
    byte[14]    sa_data;
}

private enum : size_t
{
    _SS_SIZE    = 128,
    _SS_PADSIZE = _SS_SIZE - (c_ulong.sizeof * 2)
}

struct sockaddr_storage
{
    sa_family_t ss_family;
    c_ulong     __ss_align;
    byte[_SS_PADSIZE] __ss_padding;
}

struct msghdr
{
    void*     msg_name;
    socklen_t msg_namelen;
    iovec*    msg_iov;
    size_t    msg_iovlen;
    void*     msg_control;
    size_t    msg_controllen;
    int       msg_flags;
}

struct cmsghdr
{
    size_t cmsg_len;
    int    cmsg_level;
    int    cmsg_type;
    static if( false /* (!is( __STRICT_ANSI__ ) && __GNUC__ >= 2) || __STDC_VERSION__ >= 199901L */ )
    {
        ubyte[1] __cmsg_data;
    }
}

static if( false /* (!is( __STRICT_ANSI__ ) && __GNUC__ >= 2) || __STDC_VERSION__ >= 199901L */ )
{
    extern (D) ubyte[1] CMSG_DATA( cmsghdr* cmsg ) { return cmsg.__cmsg_data; }
}
else
{
    extern (D) ubyte*   CMSG_DATA( cmsghdr* cmsg ) { return cast(ubyte*)( cmsg + 1 ); }
}

private cmsghdr* __cmsg_nxthdr(msghdr*, cmsghdr*);
alias            __cmsg_nxthdr CMSG_NXTHDR;

extern (D) size_t CMSG_FIRSTHDR( msghdr* mhdr )
{
    return ( mhdr.msg_controllen >= cmsghdr.sizeof
                         ? cast(size_t) mhdr.msg_control
                         : cast(size_t) 0 );
}

struct linger
{
    int l_onoff;
    int l_linger;
}

int     accept(int, sockaddr*, socklen_t*);
int     bind(int, in sockaddr*, socklen_t);
int     connect(int, in sockaddr*, socklen_t);
int     getpeername(int, sockaddr*, socklen_t*);
int     getsockname(int, sockaddr*, socklen_t*);
int     getsockopt(int, int, int, void*, socklen_t*);
int     listen(int, int);
ssize_t recv(int, void*, size_t, int);
ssize_t recvfrom(int, void*, size_t, int, sockaddr*, socklen_t*);
ssize_t recvmsg(int, msghdr*, int);
ssize_t send(int, in void*, size_t, int);
ssize_t sendmsg(int, in msghdr*, int);
ssize_t sendto(int, in void*, size_t, int, in sockaddr*, socklen_t);
int     setsockopt(int, int, int, in void*, socklen_t);
int     shutdown(int, int);
int     socket(int, int, int);
int     sockatmark(int);
int     socketpair(int, int, int,ref int[2]);

// consts

import core.sys.posix.fcntl: F_GETFL, F_SETFL,O_NONBLOCK;

enum
{
    SO_DEBUG = 1 , /* turn on debugging info recording */
    SO_BROADCAST = 6 , /* permit sending of broadcast msgs */
    SO_REUSEADDR = 2 , /* allow local address reuse */
    SO_LINGER = 13 , /* linger on close if data present */
    SO_DONTLINGER = ~(13),
    SO_OOBINLINE = 10 , /* leave received OOB data in line */
    SO_ACCEPTCONN = 30, /* socket has had listen() */
    SO_KEEPALIVE = 9 , /* keep connections alive */
    SO_DONTROUTE = 5 , /* just use interface addresses */
    SO_TYPE = 3 , /* get socket type */
    /*
     * Additional options, not kept in so_options.
     */
    SO_SNDBUF = 7, /* send buffer size */
    SO_RCVBUF = 8, /* receive buffer size */
    SO_ERROR = 4 , /* get error status and clear */
}
enum
{
    SOL_SOCKET = 1,
}
enum {
    SOCK_STREAM = 1 , /++ sequential, reliable +/
        SOCK_DGRAM = 2 , /++ connectionless unreliable, max length +/
        SOCK_SEQPACKET = 5, /++ sequential, reliable, max length +/
        SOCK_RAW = 3 , /++ raw protocol +/
        SOCK_RDM = 4 , /++ reliable messages +/
        SOCK_PACKET = 10, /++ linux specific packets at dev level +/
}
enum
{
    AF_UNSPEC = 0 ,
    AF_UNIX = 1 ,
    AF_INET = 2 ,
    AF_INET6 = 10 ,
}
enum : uint
{
    SCM_RIGHTS = 0x01
}
enum
{
    SOMAXCONN       = 128,
}
enum : uint
{
    MSG_CTRUNC      = 0x08,
    MSG_DONTROUTE   = 0x04,
    MSG_EOR         = 0x80,
    MSG_OOB         = 0x01,
    MSG_PEEK        = 0x02,
    MSG_TRUNC       = 0x20,
    MSG_WAITALL     = 0x100
}
/* The following constants should be used for the second parameter of
   `shutdown'.  */
enum
{
    SHUT_RD = 0, /* No more receptions.  */
    SHUT_WR, /* No more transmissions.  */
    SHUT_RDWR /* No more receptions or transmissions.  */
}


