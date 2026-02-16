== Chapter 6: Mechanism: Limited Direct Execution

There are a few problems in virtualizing the CPU

- performance -- how can we implement a virtualizer without adding overhead

- control -- how do we run them whie maitaining control over the CPU

Control is especially important.

=== 6.1 Basic Technique: Limited Direct Execution

The basic idea is to run the program directly on the CPU.

- create a process entry
- allocate memory
- load program
- setup stack (argc/argv)
- clear registers
- execute call main()
- - run main()
- - execute return from main
- free memory of process
- remove from process list

There are two problems. Namely,

1. How do we make sure the program we don't want it to do? While still running it efficiently.
2. How do we stop the process and switch to another?

This is where "limited" comes from. We have no control.

=== 6.2 Problem #1: Restricted Operations

How can we want to run a restricted operation (I/O request, or gain access to resources)?

We could let the process do whatever it wants, but then we wouldn't be able to restrict permissions based on some factors (file permissions).

One approach is to create different processor modes. *user mode* and *kernel mode*.

- user mode -- a process can't issue I/O requests, so it would get killed if it did so
- kernel mode -- code in this mode can basically do whatever it wants

A process can execute a system call that raises into kernel mode, in which the OS runs its code.

System calls deal with *trap* instructions and *return from trap* instructions. A *trap* instruction jumps into kernel and raises the privlege level to kernel mode. The *return from trap* instruction, returns back to user mode.

The kernel doesn't let the user program specify which address to jump to. That would allow for arbitrary code execution. Instead a *trap table* maps traps to their *trap handlers* (or essentially their addresses).

Note that being able to find the trap rables is a *privleged* operation. You don't want any process to just be able to write their own trap table.

Thus, we have two phases in *LDE*:

1. Boot time -- kernel initializes trap table; cpu remembers its location
2. Running a process -- kernel sets up a few things (node on the process list, allocating memory, etc)

=== 6.3 Problem #2: Switching Between Processes

Switching between processes is super complicated. If a process is running, that means the OS is *not* running.

==== A Cooperative Approach: Wait for System Calls

In the *cooperative* approach, the OS assumes that a process will give up the CPU periodically so that the OS can run something else.

- Systems like these have the *yield syscall* to allow for transfer back to the OS.

- Applications also transfer when they do illegal operations (divide by 0, access memory it can't, etc)

==== A Non-Cooperative Approach: The OS Takes Control

Aside from *rebooting the machine* there aren't many options to kill a process.

A quick approach to do this is to have a *timer interrupt* that raises an interupt every X amount of miliseconds. Thus, the OS regains control of the CPU.

Once the timer is started (in the boot sequence), the OS is safe to handle control over to different processes.

==== Saving and Restoring Context

Once the OS has control, a choice is made: (1) return back to the process (2) return to a different process. This choice is made by the *schedueler*

If a different one is selected, the OS executes a *context switch*. The OS saves a few register values from the current process, and restores the "new" process into memory.

The OS does the opposite for the current process.

During the context switch, the registers must be saved, and then registers are written to. The OS stores registers in software until they are needed.

=== 6.4 Worried About Concurrency?


