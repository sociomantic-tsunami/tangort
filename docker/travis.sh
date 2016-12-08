#!/bin/sh
set -xe

git submodule foreach --recursive git submodule deinit --force --all
export F=production
make all
make test
make pkg
