/*
 * A simple test program for exercising the threads API.
 */
#include <stdio.h>
#include "sthread.h"


/*
 * Thread 1 prints "Hello".
 * Thread 2 prints "Goodbye".
 *
 * In this version of the code,
 * thread scheduling is explicit.
 */

/*! This thread-function prints "Hello" over and over again! */
static void loop1(void *arg) {
    while(1) {
        printf("Hello\n");
        sthread_yield();
    }
}

/*! This thread-function prints "Goodbye" over and over again! */
static void loop2(void *arg) {
    while(1) {
        printf("Goodbye\n");
        sthread_yield();
    }
}

/*
 * The main function starts the two loops in separate threads,
 * the start the thread scheduler.
 */
int main(int argc, char **argv) {
    sthread_create(loop1, NULL);
    sthread_create(loop2, NULL);
    sthread_start();
    return 0;
}


