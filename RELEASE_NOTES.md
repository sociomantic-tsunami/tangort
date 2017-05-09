Dependencies
============

Dependency | Version
-----------|------------------
dmd1       | >= v1.080.0
rdmd       | >= 2.067.0

Migration Instructions
======================


New Features
============

* `rt.profilegc` `rt.tracegc`

  Preliminary support for `-profile=gc` switch backported to DMD1 compiler. In
  its current shape matches upstream implementation but works only in
  single-threaded environments.

* `core.sys.linux.sys.evenfd`

  New module with evenfd bindings

* `core.sys.posix.time`

  Add `clock_gettime`/`clock_settime` bindings and `CLOCK_MONOTONIC`

* `core.sys.posix.stdio`

  Add `getline` and `getdelim` bindings

* `core.exception`

  Now prints file and line of the exception causing `FinalizeError`

Deprecations
============
