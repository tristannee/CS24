This folder contains files that I wrote/completed (test.c was already provided) to experiment with threads.

- glue.s

Contains assembly routines to help us perform a context switch in __sthread_schedule() routine.
ALso initializes a new thread context in the __sthread_initialize() routine.

- sthread.c

Contains the main thread scheduler in the __sthread_scheduler() function. Creates a new thread
in the sthread_create() function. Finally deletes a finished thread in the __sthread_delete() function.

- test_arg.c

Test code for the threading package showing that sthread_create correctly passes its argument to the thread function.

- test_ret.c

Also test code to show that returning from a thread causes the thread to be reclaimed.
