### ClassInfo.init is deprecated, renamed to `initializer`

This change matches recent deprecation in D2 upstream druntime and is intended
to eliminate confusion between built-in `T.init` property of all types and
member function of `ClassInfo` with the same name.
