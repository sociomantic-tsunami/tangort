/**
 * D header file for POSIX.
 *
 * Copyright: Copyright David Nadlinger 2011.
 * License:   <a href="http://www.boost.org/LICENSE_1_0.txt">Boost License 1.0</a>.
 * Authors:   David Nadlinger, Sean Kelly, Alex Rønne Petersen
 * Standards: The Open Group Base Specifications Issue 6, IEEE Std 1003.1, 2004 Edition
 */

/*          Copyright David Nadlinger 2011.
 * Distributed under the Boost Software License, Version 1.0.
 *    (See accompanying file LICENSE or copy at
 *          http://www.boost.org/LICENSE_1_0.txt)
 */

module core.sys.posix.netdb;

import core.sys.posix.config;
public import core.stdc.inttypes;         // for uint32_t
public import core.sys.posix.netinet.in_; // for in_port_t, in_addr_t
public import core.sys.posix.sys.types;   // for ino_t
public import core.sys.posix.sys.socket;  // for socklen_t

version (Posix):
extern (C):

//
// Required
//
/*
struct hostent
{
    char*   h_name;
    char**  h_aliases;
    int     h_addrtype;
    int     h_length;
    char**  h_addr_list;
}

struct netent
{
    char*   n_name;
    char**  n_aliase;
    int     n_addrtype;
    uint32_t n_net;
}

struct protoent
{
    char*   p_name;
    char**  p_aliases;
    int     p_proto;
}

struct servent
{
    char*   s_name;
    char**  s_aliases;
    int     s_port;
    char*   s_proto;
}

IPPORT_RESERVED

h_errno

HOST_NOT_FOUND
NO_DATA
NO_RECOVERY
TRY_AGAIN

struct addrinfo
{
    int         ai_flags;
    int         ai_family;
    int         ai_socktype;
    int         ai_protocol;
    socklen_t   ai_addrlen;
    sockaddr*   ai_addr;
    char*       ai_canonname;
    addrinfo*   ai_next;
}

AI_PASSIVE
AI_CANONNAME
AI_NUMERICHOST
AI_NUMERICSERV
AI_V4MAPPED
AI_ALL
AI_ADDRCONFIG

NI_NOFQDN
NI_NUMERICHOST
NI_NAMEREQD
NI_NUMERICSERV
NI_NUMERICSCOPE
NI_DGRAM

EAI_AGAIN
EAI_BADFLAGS
EAI_FAIL
EAI_FAMILY
EAI_MEMORY
EAI_NONAME

EAI_SERVICE
EAI_SOCKTYPE
EAI_SYSTEM
EAI_OVERFLOW

void         endhostent();
void         endnetent();
void         endprotoent();
void         endservent();
void         freeaddrinfo(addrinfo*);
char* gai_strerror(int);
int          getaddrinfo(char*, char*, addrinfo*, addrinfo**);
hostent*     gethostbyaddr(void*, socklen_t, int);
hostent*     gethostbyname(char*);
hostent*     gethostent();
int          getnameinfo(sockaddr*, socklen_t, char*, socklen_t, char*, socklen_t, int);
netent*      getnetbyaddr(uint32_t, int);
netent*      getnetbyname(char*);
netent*      getnetent();
protoent*    getprotobyname(char*);
protoent*    getprotobynumber(int);
protoent*    getprotoent();
servent*     getservbyname(char*, char*);
servent*     getservbyport(int, char*);
servent*     getservent();
void         sethostent(int);
void         setnetent(int);
void         setprotoent(int);
void         setservent(int);
*/

version( linux )
{
    struct hostent
    {
        char*   h_name;
        char**  h_aliases;
        int     h_addrtype;
        int     h_length;
        char**  h_addr_list;
        extern (D) char* h_addr() { return h_addr_list[0]; } // non-standard
    }

    struct netent
    {
        char*   n_name;
        char**  n_aliases;
        int     n_addrtype;
        uint32_t n_net;
    }

    struct protoent
    {
        char*   p_name;
        char**  p_aliases;
        int     p_proto;
    }

    struct servent
    {
        char*   s_name;
        char**  s_aliases;
        int     s_port;
        char*   s_proto;
    }

    enum { IPPORT_RESERVED = 1024 }

    //h_errno

    enum
    {
        HOST_NOT_FOUND = 1,
        NO_DATA        = 4,
        NO_RECOVERY    = 3,
        TRY_AGAIN      = 2,
    }

    struct addrinfo
    {
        int         ai_flags;
        int         ai_family;
        int         ai_socktype;
        int         ai_protocol;
        socklen_t   ai_addrlen;
        sockaddr*   ai_addr;
        char*       ai_canonname;
        addrinfo*   ai_next;
    }

    enum
    {
        AI_PASSIVE         = 0x1,
        AI_CANONNAME       = 0x2,
        AI_NUMERICHOST     = 0x4,
        AI_NUMERICSERV     = 0x400,
        AI_V4MAPPED        = 0x8,
        AI_ALL             = 0x10,
        AI_ADDRCONFIG      = 0x20,


        NI_NOFQDN          = 4,
        NI_NUMERICHOST     = 1,
        NI_NAMEREQD        = 8,
        NI_NUMERICSERV     = 2,
        //NI_NUMERICSCOPE    = ?,
        NI_DGRAM           = 16,
        NI_MAXHOST         = 1025, // non-standard
        NI_MAXSERV         = 32,   // non-standard

        EAI_AGAIN          = -3,
        EAI_BADFLAGS       = -1,
        EAI_FAIL           = -4,
        EAI_FAMILY         = -6,
        EAI_MEMORY         = -10,
        EAI_NONAME         = -2,
        EAI_SERVICE        = -8,
        EAI_SOCKTYPE       = -7,
        EAI_SYSTEM         = -11,
        EAI_OVERFLOW       = -12,
    }
}
else version( OSX )
{
    struct hostent
    {
        char*   h_name;
        char**  h_aliases;
        int     h_addrtype;
        int     h_length;
        char**  h_addr_list;
        extern (D) char* h_addr() { return h_addr_list[0]; } // non-standard
    }

    struct netent
    {
        char*   n_name;
        char**  n_aliases;
        int     n_addrtype;
        uint32_t n_net;
    }

    struct protoent
    {
        char*   p_name;
        char**  p_aliases;
        int     p_proto;
    }

    struct servent
    {
        char*   s_name;
        char**  s_aliases;
        int     s_port;
        char*   s_proto;
    }

    enum { IPPORT_RESERVED = 1024 }

    //h_errno

    enum
    {
        HOST_NOT_FOUND = 1,
        NO_DATA        = 4,
        NO_RECOVERY    = 3,
        TRY_AGAIN      = 2,
    }

    struct addrinfo
    {
        int         ai_flags;
        int         ai_family;
        int         ai_socktype;
        int         ai_protocol;
        socklen_t   ai_addrlen;
        char*       ai_canonname;
        sockaddr*   ai_addr;
        addrinfo*   ai_next;
    }

    enum
    {
        AI_PASSIVE         = 0x1,
        AI_CANONNAME       = 0x2,
        AI_NUMERICHOST     = 0x4,
        AI_NUMERICSERV     = 0x1000,
        AI_V4MAPPED        = 0x800,
        AI_ALL             = 0x100,
        AI_ADDRCONFIG      = 0x400,

        NI_NOFQDN          = 0x1,
        NI_NUMERICHOST     = 0x2,
        NI_NAMEREQD        = 0x4,
        NI_NUMERICSERV     = 0x8,
        //NI_NUMERICSCOPE    = ?,
        NI_DGRAM           = 0x10,
        NI_MAXHOST         = 1025, // non-standard
        NI_MAXSERV         = 32,   // non-standard

        EAI_AGAIN          = 2,
        EAI_BADFLAGS       = 3,
        EAI_FAIL           = 4,
        EAI_FAMILY         = 5,
        EAI_MEMORY         = 6,
        EAI_NONAME         = 8,
        EAI_SERVICE        = 9,
        EAI_SOCKTYPE       = 10,
        EAI_SYSTEM         = 11,
        EAI_OVERFLOW       = 14,
    }
}
else version( FreeBSD )
{
    struct hostent
    {
        char*   h_name;
        char**  h_aliases;
        int     h_addrtype;
        int     h_length;
        char**  h_addr_list;
        extern (D) char* h_addr() { return h_addr_list[0]; } // non-standard
    }

    struct netent
    {
        char*   n_name;
        char**  n_aliases;
        int     n_addrtype;
        uint32_t n_net;
    }

    struct protoent
    {
        char*   p_name;
        char**  p_aliases;
        int     p_proto;
    }

    struct servent
    {
        char*   s_name;
        char**  s_aliases;
        int     s_port;
        char*   s_proto;
    }

    enum { IPPORT_RESERVED = 1024 }

    //h_errno

    enum
    {
        HOST_NOT_FOUND = 1,
        NO_DATA        = 4,
        NO_RECOVERY    = 3,
        TRY_AGAIN      = 2,
    }

    struct addrinfo
    {
        int         ai_flags;
        int         ai_family;
        int         ai_socktype;
        int         ai_protocol;
        socklen_t   ai_addrlen;
        char*       ai_canonname;
        sockaddr*   ai_addr;
        addrinfo*   ai_next;
    }

    enum
    {
        AI_PASSIVE         = 0x1,
        AI_CANONNAME       = 0x2,
        AI_NUMERICHOST     = 0x4,
        AI_NUMERICSERV     = 0x8,
        AI_V4MAPPED        = 0x800,
        AI_ALL             = 0x100,
        AI_ADDRCONFIG      = 0x400,

        NI_NOFQDN          = 0x1,
        NI_NUMERICHOST     = 0x2,
        NI_NAMEREQD        = 0x4,
        NI_NUMERICSERV     = 0x8,
        //NI_NUMERICSCOPE    = ?,
        NI_DGRAM           = 0x10,
        NI_MAXHOST         = 1025, // non-standard
        NI_MAXSERV         = 32,   // non-standard

        EAI_AGAIN          = 2,
        EAI_BADFLAGS       = 3,
        EAI_FAIL           = 4,
        EAI_FAMILY         = 5,
        EAI_MEMORY         = 6,
        EAI_NONAME         = 8,
        EAI_SERVICE        = 9,
        EAI_SOCKTYPE       = 10,
        EAI_SYSTEM         = 11,
        EAI_OVERFLOW       = 14,
    }
}
else version (Solaris)
{
    struct hostent
    {
        char* h_name;
        char** h_aliases;
        int h_addrtype;
        int h_length;
        char** h_addr_list;

        extern (D) char* h_addr() { return h_addr_list[0]; } // non-standard
    }

    struct netent
    {
        char* n_name;
        char** n_aliases;
        int n_addrtype;
        uint32_t n_net;
    }

    struct protoent
    {
        char* p_name;
        char** p_aliases;
        int p_proto;
    }

    struct servent
    {
        char* s_name;
        char** s_aliases;
        int s_port;
        char* s_proto;
    }

    enum
    {
        HOST_NOT_FOUND = 1,
        NO_DATA        = 4,
        NO_RECOVERY    = 3,
        TRY_AGAIN      = 2,
    }

    struct addrinfo
    {
        int ai_flags;
        int ai_family;
        int ai_socktype;
        int ai_protocol;

        version (SPARC)
            int _ai_pad;
        else version (SPARC64)
            int _ai_pad;

        socklen_t ai_addrlen;
        char* ai_canonname;
        sockaddr* ai_addr;
        addrinfo* ai_next;
    }

    enum
    {
        AI_PASSIVE = 0x0008,
        AI_CANONNAME = 0x0010,
        AI_NUMERICHOST = 0x0020,
        AI_NUMERICSERV = 0x0040,
        AI_V4MAPPED = 0x0001,
        AI_ALL = 0x0002,
        AI_ADDRCONFIG = 0x0004,

        NI_NOFQDN = 0x0001,
        NI_NUMERICHOST = 0x0002,
        NI_NAMEREQD = 0x0004,
        NI_NUMERICSERV = 0x0008,
        NI_DGRAM = 0x0010,
        NI_WITHSCOPEID = 0x0020,
        NI_NUMERICSCOPE = 0x0040,
        NI_MAXHOST = 1025,
        NI_MAXSERV = 32,

        EAI_AGAIN = 2,
        EAI_BADFLAGS = 3,
        EAI_FAIL = 4,
        EAI_FAMILY = 5,
        EAI_MEMORY = 6,
        EAI_NONAME = 8,
        EAI_SERVICE = 9,
        EAI_SOCKTYPE = 10,
        EAI_SYSTEM = 11,
        EAI_OVERFLOW = 14,
        EAI_PROTOCOL = 13,
        EAI_MAX = 14,
    }
}
else
{
    static assert(false, "Unsupported platform");
}

void         endhostent();
void         endnetent();
void         endprotoent();
void         endservent();
void         freeaddrinfo(addrinfo*);
char*        gai_strerror(int);
int          getaddrinfo(char*, char*, addrinfo*, addrinfo**);
hostent*     gethostbyaddr(void*, socklen_t, int);
hostent*     gethostbyname(char*);
hostent*     gethostent();
int          getnameinfo(sockaddr*, socklen_t, char*, socklen_t, char*, socklen_t, int);
netent*      getnetbyaddr(uint32_t, int);
netent*      getnetbyname(char*);
netent*      getnetent();
protoent*    getprotobyname(char*);
protoent*    getprotobynumber(int);
protoent*    getprotoent();
servent*     getservbyname(char*, char*);
servent*     getservbyport(int, char*);
servent*     getservent();
void         sethostent(int);
void         setnetent(int);
void         setprotoent(int);
void         setservent(int);
