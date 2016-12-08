
# Provide release and debug versions for CDGC
VALID_FLAVORS := cdgc.debug cdgc.release

# We honour the D_GC environment variable to determine the default flavour
D_GC ?= cdgc
F := $(D_GC).release
