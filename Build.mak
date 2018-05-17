# This build script is a bit more complex than usual because there is a lot
# going on to build Tango compared to a regular D project:
#
# * We have to build the runtime, which is part of the language
# * We have to build 2 flavours of the runtime: (debug,release)
# * Two flavors of gc were supported originally but only cdgc remains now
# * We have to build a Debian package with all the flavours above
# * We have to build a Debian package with the user library sources
# * We have to build a runtime before we can run the unittests
#
# So, Tango flavours have special names:
#
# * cdgc.debug
# * cdgc.release
#
# We get some configuration information straight from the flavour name (the GC
# to use and if it's a release/debug build).
#
# So to build one particular flavour you can use, for example:
# 	make F=cdgc.release
#
# To build the Debian packages, just use:
# 	make deb
# Make will be called recusively using the appropriate flavours to build the
# 4 different libraries.
#
# To run the tests, just use:
# 	make test
# This will build a custom runtime (without any Tango user library modules)
# just for the tests, using the selected flavours configuration, so you can
# also do:
# 	make test F=cdgc.release
# For example

override DFLAGS += -O -inline -release -version=WithDateTime
override CFLAGS += -O2

override DFLAGS += -I$T/src/rt/include

ifeq ($(suffix $F),.debug)
override CFLAGS += -g
libsuffix := -dbg
endif

export D_GC := $(basename $F)

# Libraries directory
L ?= $G/lib
setup_lib_dir__ := $(shell mkdir -p $L $O/lib)

# Calculate version string
version := $(shell git describe --dirty | cut -c2- | \
		sed 's/-\([0-9]\+\)-g\([0-9a-f]\{7\}\)/+\1-\2/' | \
		sed 's/\(-[0-9a-f]\{7\}\)-dirty$$/-dirty\1/')

# Sources
src := $(call find_files,.[dcS],,$C/src)

# Objects to be compiled
obj := $(filter-out %.d,$(src))
obj := $(obj:.c=.o)
obj := $(obj:.S=.o)
obj := $(patsubst $C/%,$O/%,$(obj))
obj += $(filter %.d,$(src))


# Build the actual library
.PHONY: lib
lib: $L/libtangort-dmd-$(D_GC)$(libsuffix).a
all += lib
$L/libtangort-dmd-$(D_GC)$(libsuffix).a: $(obj)
	$(call exec,$(DC) $(DFLAGS) -lib -of$@ $^)

# We need to disable some modules because they will clash with stuff provided
# by the runtime, or because some modules use reserved words
TEST_FILTER_OUT := \
	$T/src/rt/invariant.d \
	$T/src/object.d \
	$T/src/rt/%/intrinsic.d


RDMDFLAGS := -w --force --compiler=$(DC)

# Override rule to build the unittest program to not use the UnitTestRunner as
# it's not available here
$O/allunittests.d $O/fastunittests.d: $G/build-d-flags
	$(call exec,printf 'module $(patsubst $O/%.d,%,$@);\n\
		\n$(foreach f,$(filter %.d,$^),\
		import $(subst /,.,$(patsubst $C/$(SRC)/%.d,%,$f));\n)\n\
		int main() { return 0; }' > \
			$@,,gen)

# If we build the tests with release, all the DBC testing and array bound
# checking is lost, so we remove the -release for tests.
$O/%unittests: override DFLAGS := $(filter-out -release,$(DFLAGS))
$O/%unittests: override LDFLAGS += -L$G/lib
$O/allunittests $O/fastunittests: lib
$O/%unittests: override DFLAGS += -defaultlib=tangort-dmd-cdgc $(TESTDDFLAGS)

# Pattern rules for the different type of files and the main target

$O/%.o: %.c
	$Vmkdir -p `dirname $@`
	$(call exec,$(COMPILE.c) $(OUTPUT_OPTION) $<)

$O/%.o: %.S
	$Vmkdir -p `dirname $@`
	$(call exec,$(COMPILE.S) $(OUTPUT_OPTION) $<)

# Packages dependencies
$O/pkg-libtangort-dmd-dev.stamp: \
	$C/dmd1.conf \
	$C/src/rt/include/std/intrinsic.d \
	$C/src/object.d \
	$(call find_files,.d,,$C/src/core) $(call find_files,.di,,$C/src/core) \
	cdgc-debug cdgc-release

# Aliases to build the Debian package for all the flavours of the library
.PHONY: cdgc-debug cdgc-release
cdgc-debug:
	$(MAKE) F=cdgc.debug
cdgc-release:
	$(MAKE) F=cdgc.release
