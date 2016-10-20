In these files, I wrote code to retrieve the user ID and group ID from the kernel.

- get_ids.s

Contains an assembly routine to make a system call. Takes two arguments: the first is a pointer
to an integer to receive the user ID, and the second is a pointer to an integer to receive the
group ID.

- myids.c and myids.h

Calls the get_ids.s assembly function and prints the result.
