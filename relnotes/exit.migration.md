## Call `_Exit(3)` instead of `exit(3)` in the GC child process

This is just a bug fix, but since it's a change on behaviour you should be aware
of it. The GC child process called `exit()` which will call `atexit()` functions
and flush `stdio` streams, which is not what we want because the GC should run
without any side-effects, so it was changed to use `_Exit()` which doesn't do
those things.
