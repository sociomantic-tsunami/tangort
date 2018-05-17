### `ClassInfo.init()` is also available as `initializer`

This change matches recent deprecation in D2 upstream druntime and is intended
to eliminate confusion between built-in `T.init` property of all types and
member function of `ClassInfo` with the same name.

Now tangort provides both names so that applications doing transition to D2 can
make a switch without breaking D1 build.
