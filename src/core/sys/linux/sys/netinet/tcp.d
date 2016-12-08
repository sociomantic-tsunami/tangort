/*******************************************************************************

    D bindings for the Linux's netinet/tcp.h structures.

    Defines constants found in tcp.h header on Linux system.

    Copyright (c): 1982; 1986; 1993 * The Regents of the University of
    California.  All rights reserved.

    Redistribution and use in source and binary forms; with or without
    modification; are permitted provided that the following conditions
    are met:
    1. Redistributions of source code must retain the above copyright
       notice; this list of conditions and the following disclaimer.
    2. Redistributions in binary form must reproduce the above copyright
       notice; this list of conditions and the following disclaimer in the
       documentation and/or other materials provided with the distribution.
    4. Neither the name of the University nor the names of its contributors
       may be used to endorse or promote products derived from this software
       without specific prior written permission.

    THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND
    ANY EXPRESS OR IMPLIED WARRANTIES; INCLUDING; BUT NOT LIMITED TO; THE
    IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
    ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
    FOR ANY DIRECT; INDIRECT; INCIDENTAL; SPECIAL; EXEMPLARY; OR CONSEQUENTIAL
    DAMAGES (INCLUDING; BUT NOT LIMITED TO; PROCUREMENT OF SUBSTITUTE GOODS
    OR SERVICES; LOSS OF USE; DATA; OR PROFITS; OR BUSINESS INTERRUPTION)
    HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY; WHETHER IN CONTRACT; STRICT
    LIABILITY; OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
    OUT OF THE USE OF THIS SOFTWARE; EVEN IF ADVISED OF THE POSSIBILITY OF
    SUCH DAMAGE.

    @(#)tcp.h 8.1 (Berkeley) 6/10/93

*******************************************************************************/

module core.sys.linux.sys.netinet.tcp;

/// User-settable options (used with setsockopt).
const TCP_NODELAY            = 1;  /// Don't delay send to coalesce packets
const TCP_MAXSEG             = 2;  /// Set maximum segment size
const TCP_CORK               = 3;  /// Control sending of partial frames
const TCP_KEEPIDLE           = 4;  /// Start keeplives after this period
const TCP_KEEPINTVL          = 5;  /// Interval between keepalives
const TCP_KEEPCNT            = 6;  /// Number of keepalives before death
const TCP_SYNCNT             = 7;  /// Number of SYN retransmits
const TCP_LINGER2            = 8;  /// Life time of orphaned FIN-WAIT-2 state
const TCP_DEFER_ACCEPT       = 9;  /// Wake up listener only when data arrive
const TCP_WINDOW_CLAMP       = 10; /// Bound advertised window
const TCP_INFO               = 11; /// Information about this connection.
const TCP_QUICKACK           = 12; /// Bock/reenable quick ACKs.
const TCP_CONGESTION         = 13; /// Congestion control algorithm.
const TCP_MD5SIG             = 14; /// TCP MD5 Signature (RFC2385)
const TCP_COOKIE_TRANSACTIONS     = 15; /// TCP Cookie Transactions
const TCP_THIN_LINEAR_TIMEOUTS    = 16; /// Use linear timeouts for thin streams
const TCP_THIN_DUPACK             = 17; /// Fast retrans. after 1 dupack
const TCP_USER_TIMEOUT       = 18; /// How long for loss retry before timeout
const TCP_REPAIR             = 19; /// TCP sock is under repair right now
const TCP_REPAIR_QUEUE       = 20; /// Set TCP queue to repair
const TCP_QUEUE_SEQ          = 21; /// Set sequence number of repaired queue.
const TCP_REPAIR_OPTIONS     = 22; /// Repair TCP connection options
const TCP_FASTOPEN           = 23; /// Enable FastOpen on listeners
const TCP_TIMESTAMP          = 24; /// TCP time stamp
const TCP_NOTSENT_LOWAT      = 25; /// Limit number of unsent bytes in  write queue.
const TCP_CC_INFO            = 26; /// Get Congestion Control (optional) info.
const TCP_SAVE_SYN           = 27; /// Record SYN headers for new connections.
const TCP_SAVED_SYN          = 28; /// Get SYN headers recorded for connection.
