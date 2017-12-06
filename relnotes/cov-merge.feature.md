## Coverage merging works without pre-existing files

The code coverage option to merge reports didn't do anything before if no
pre-existing reports were found. There is no good reason for this behaviour, and
makes it more complicated to do multiple runs, as one must know which will have
to happen first to pass the merge option conditionally, so it's better to just
create new reports if they don't exist while merging.
