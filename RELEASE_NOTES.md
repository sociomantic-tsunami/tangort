Warning
=======

Please note this is the first open source release of an internal Tango fork, so
this is not a comprehensive changelog for all the changes since Tango was
forked. This release notes only describe changes done to the previous internal
v1.5.x version series, which already have many changes to the original Tango
runtime.

Dependencies
============

Dependency | Version
-----------|------------------
dmd1       | >= v1.078.0
rdmd       | >= 2.067.0

Migration Instructions
======================

- Check your `SIGABRT` signal handling

  The runtime functions `thread_abortHandler()` and `setthread_abortHandler()`
  were completely removed as well as the `SIGABRT` signal handling making the
  process to `exit(-1)`. If you need to handle the `SIGABRT` signal in
  non-default POSIX way, please register a signal handler yourself via standard
  POSIX mechanisms.

  Tango runtime was installing a `SIGABRT` signal handler, with the intention
  that one could hook into it, using `settthread_abortHandler()`, and completely
  ignoring the `SIGABRT` delivered to the thread. However, if one would not do
  that, the runtime would just call `exit(-1)`, overriding the system default
  setting (dumping a core), making `abort()` call close to useless.

New Features
============

- `core.sys.posix.sys.ioctl` was copied (and adapted) from druntime.

Deprecations
============

- `core.sys.linux.termios`

  Use `core.sys.posix.sys.ioctl` instead.

