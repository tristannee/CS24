#include <stdio.h>
#include "sthread.h"

/*
 * This code starts four threads that call a single loop function, but with
 * different loop lengths. The threads should terminate at different times.
 */

/* This thread-function takes an integer argument as the length of for loop
   and then just returns after each iteration of the for loop */
static void loop(void *arg) {
    for (int i = 0; i < *((int *)arg); i++) {
        sthread_yield();
    }
}

/*
 * The main function starts the loops of different lengths four different,
 * threads, then starts the thread scheduler.
 */
int main(int argc, char **argv) {
    int a = 10;
    int b = 20;
    int c = 50;
    int d = 100;
    sthread_create(loop, (void*)&a);
    sthread_create(loop, (void*)&b);
    sthread_create(loop, (void*)&c);
    sthread_create(loop, (void*)&d);
    sthread_start();
    return 0;
}


