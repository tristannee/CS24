#
# Keep a pointer to the main scheduler context.
# This variable should be initialized to %esp;
# which is done in the __sthread_start routine.
#
        .data
        .align 4
scheduler_context:      .long   0

#
# __sthread_schedule is the main entry point for the thread
# scheduler.  It has three parts:
#
#    1. Save the context of the current thread on the stack.
#       The context includes only the integer registers
#       and EFLAGS.
#    2. Call __sthread_scheduler (the C scheduler function),
#       passing the context as an argument.  The scheduler
#       stack *must* be restored by setting %esp to the
#       scheduler_context before __sthread_scheduler is
#       called.
#    3. __sthread_scheduler will return the context of
#       a new thread.  Restore the context, and return
#       to the thread.
#
        .text
        .align 4
        .globl __sthread_schedule
__sthread_schedule:

        # Save the process state onto its stack
        pushl   %ebp # Push ebp
	pushl   %esp # Push esp
	pushl   %eax # Push eax
	pushl   %ebx # Push ebx
	pushl   %ecx # Push ecx
	pushl   %edx # Push edx
	pushl   %esi # Push esi
	pushl   %edi # Push edi
	pushfl # Push the EFLAGS

        # Call the high-level scheduler with the current context as an argument
        movl    %esp, %eax # Move context into eax
        movl    scheduler_context, %esp # Move scheduler context into esp
        pushl   %eax # Push this context onto the stack for scheduler
        call    __sthread_scheduler # Call scheduler function

        # The scheduler will return a context to start.
        # Restore the context to resume the thread.
__sthread_restore:

        movl    %eax, %esp # Move the stack pointer to the argument context 
	popfl # Pop the EFLAGS
	popl    %edi # Pop edi
	popl    %esi # Pop esi
	popl    %edx # Pop edx
	popl    %ecx # Pop ecx
	popl    %ebx # Pop ebx
	popl    %eax # Pop eax
	popl    %esp # Pop esp
	popl    %ebp # Pop ebp

        ret

#
# Initialize a process context, given:
#    1. the stack for the process
#    2. the function to start
#    3. its argument
# The context should be consistent with the context
# saved in the __sthread_schedule routine.
#
# A pointer to the newly initialized context is returned to the caller.
# (This is the stack-pointer after the context has been set up.)
#
# This function is described in more detail in sthread.c.
#
#
        .globl __sthread_initialize_context
__sthread_initialize_context:

        pushl   %ebp # Push old base pointer
	movl    %esp, %ebp # Let current base pointer be esp
	movl    12(%ebp), %edx # Put function into edx
	movl    16(%ebp), %ebx # Put argument into ebx
	movl    8(%ebp), %esp # Let stack pointer be stackp
	pushl   %ebx # Push argument onto stack
	pushl   $__sthread_finish # Push return address onto stack
	pushl   %edx # Push function onto stack

        pushl   %ebp # Push ebp onto stack
	pushl   %esp # Push esp onto stack
	pushl   %eax # Push eax onto stack
	pushl   %ebx # Push ebx onto stack
	pushl   %ecx # Push ecx onto stack
	pushl   %edx # Push edx onto stack
	pushl   %esi # Push esi onto stack
	pushl   %edi # Push edi onto stack
	pushfl # Push EFLAGS onto stack
	movl    %esp, %eax # Put context into eax
	movl    %ebp, %esp # Pop stack until the base pointer
	popl    %ebp # Restore old base pointer

        ret

#
# The start routine initializes the scheduler_context variable,
# and calls the __sthread_scheduler with a NULL context.
# The scheduler will return a context to resume.
#
        .globl __sthread_start
__sthread_start:
        # Remember the context
        movl    %esp, scheduler_context

        # Call the scheduler with no context
        pushl   $0
        call    __sthread_scheduler

        # Restore the context returned by the scheduler
        jmp     __sthread_restore
