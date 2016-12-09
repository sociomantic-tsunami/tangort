#!/bin/sh
set -xe

export F=cdgc.release
make -r pkg
make -r all
make -r test UTFLAGS="-x build/cdgc.release/tmp/unittests.xml"
