#include <stdio.h>
#include "sthread.h"

/*
 * We check that the argument is positioned correctly when the function uses
 * the argument. Also, we check that the thread finishes at the end of loop.
 * Thread 1 decrements a number and prints out that number after decrementing.
 * Thread 2 increments a number and prints out that number after incrementing.
 */

/* This thread-function decrementing and prints the number after decrementing */
static void decrement(void *arg) {
    for (int i = 0; i < 100; i++) {
        *((int *)arg) -= 1;
	printf("Number: %d", *((int *)arg));
        sthread_yield();
    }
}

/* This thread-function incrementing and prints the number after incrementing */
static void increment(void *arg) {
    for (int i = 0; i < 100; i++) {
        *((int *)arg) += 1;
	printf("Number: %d", *((int *)arg));
        sthread_yield();
    }
}

/*
 * The main function starts the two functions in separate threads,
 * then start the thread scheduler.
 */
int main(int argc, char **argv) {
    int x = 3;
    int y = 5;
    sthread_create(decrement, (void*)&x);
    sthread_create(increment, (void*)&y);
    sthread_start();
    return 0;
}


