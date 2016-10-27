/*
 * Simple thread API.
 */
#ifndef _STHREAD_H
#define _STHREAD_H


/*! Thread handles. */
typedef struct _thread Thread;


/* The function that is passed to a thread must have this signature. */
typedef void (*ThreadFunction)(void *arg);


/*
 * Thread operations.
 */
Thread *sthread_create(ThreadFunction f, void *arg);
void sthread_yield(void);
void sthread_block(void);
void sthread_unblock(Thread *threadp);


/*
 * The start function should be called *once* in
 * the main() function of your program.  This function
 * never returns.
 */
void sthread_start(void);


#endif /* _STHREAD_H */

