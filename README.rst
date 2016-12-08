Description
===========

This project is a fork of Tango's runtime for D1.

`Tango <http://www.dsource.org/projects/tango/>`_ is a cross-platform
open-source software library and runtime for the `D1 Programming Language
<http://digitalmars.com/d/1.0/index.html>`_.

This Tango fork consists of a D1-only runtime, the user library has been
removed.  If you are looking for an up to date Tango-like user library, we
recommend using `Ocean <https://github.com/sociomantic-tsunami/ocean>`_, which
was also based on Tango so it will feel very familiar, and it's compatible with
both D1 and D2.

The main changes since the fork are:

* Removal of the Tango user library.
* Rewrite of the build system (now using `MakD
  <https://github.com/sociomantic-tsunami/makd>`_).
* Bug fixes (some of them were contributed upstream).
* Some minor new features and extensions.
* Additions to ``stdc`` and ``sys.linux`` C standard headers.
* Only Linux 64bit is supported.
* Only the DMD runtime is supported.
* Re-structuring to bring it closer to D2's `Druntime
  <https://github.com/dlang/druntime>`_ to make porting to D2 easier.


Releases
========

`Latest stable release notes
<https://github.com/sociomantic-tsunami/tangort/releases/latest>`_ | `Current, in
development, release notes
<https://github.com/sociomantic-tsunami/tangort/blob/master/RELEASE_NOTES.md>`_ | `All
releases <https://github.com/sociomantic-tsunami/tangort/releases>`_

Releases are handled using `GitHub releases
<https://github.com/sociomantic-tsunami/tangort/releases>`_. The release notes
provided there are usually structured in 3 sections, a **Migration
Instructions**, which are the mandatory steps the users have to do to update to
a new version, **Deprecated** which contains deprecated functions which is
recommended not to use but will not break any old code, and the **New
Features** which are optional new features available in the new version that
users might find interesting.  Using them is optional, but encouraged.

These instructions should help developers to migrate from one version to
another. The changes listed here are the steps you need to take to move from
the previous version to the one being listed. For example, all the steps
described in version **v1.5** are the steps required to move from **v1.4** to
**v1.5**.

If you need to jump several versions at once, you should read all the steps from
all the intermediate versions. For example, to jump from **v1.2** to **v1.5**,
you need to first follow the steps in version **v1.3**, then the steps in
version **v1.4** and finally the steps in version **v1.5**.

There are also sometimes *patch-level* releases, in that case there are no
breaking changes or new features, just bug fixes, and thus, only bug fixes are
listed in the release notes.


