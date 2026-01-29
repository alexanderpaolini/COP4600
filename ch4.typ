== Chapter 4: The Abstraction: The Process

A *process* is just a *running program*. Program itself just sits on the disk -- You can think of the program as the actual executable. The process as what is running. 

In order to run more than one process at a time, we *virtualize* the CPU. This means to *time share* the cpu.

*mechanisms* -- low level machinery. They are low level methods/protocls that implement a needed piece of functionality.

*context switch* -- what gives the OS the ability to stop one program and start another.

*schedueling policy* -- makes the decision of which programs should run. 

=== 4.1 The Abstraction: A Process

*machine state* -- what a program can read or update when its running.

Composes of: _memory_, _registers_

Some of those registers are special. The *program counter (PC)*, *stack pointer*, *frame pointer*.

Programs have persistent storage device. (I/O information as well).

=== 4.2 Process API

The process api has a few required features:

- Create -- the method to create the process.
- Destroy -- the method to destroy the process. This is forceful.
- Wait -- To wait for a process to stop running. 
- Miscellaneus Control -- suspend, etc
- Status -- get info from the process

=== 4.3 Process Creation: A Little More Detail

1. The os *loads* the code (and static data) into memory

Modern OSes do this *lazily*. Older OSes do this *eagerly*.

See: *paging* and *swapping*

2. The os allocates for the *run-time stack* (or just stack)

3. The os allocates for the program's *heap*

4. Then the OS will do other initialization tasks. Setting up IO. Jumping into \_start

=== 4.4 Process States

Processes (obviously) have different states.

- Running -- duh
- Ready -- The program is ready to run, but its not runnning quite yet.
- Blocked -- The program has performed an operation that makes it not ready until some other event takes place. Think I/O requests.

Being moved from ready to running means the process is *scheduled*

Being moved from running to ready means the process is *descheduled*

Processes which are blocked, will stay blocked until their event has occured.

=== 4.5 Data Structures

The OS is a program, and like all programs, it has some data to keep.

The OS has a *process lsist* for all processes. Including states and other ifnromation.

```c
// the registers xv6 will save and restore
// to stop and subsequently restart a process
struct context {
int eip;
int esp;
int ebx;
int ecx;
int edx;
int esi;
int edi;
int ebp;
};
// the different states a process can be in
enum proc_state { UNUSED, EMBRYO, SLEEPING,
RUNNABLE, RUNNING, ZOMBIE };
// the information xv6 tracks about each process
// including its register context and state
struct proc {
char *mem; // Start of process memory
uint sz; // Size of process memory
char *kstack; // Bottom of kernel stack
// for this process
enum proc_state state; // Process state
int pid; // Process ID
struct proc *parent; // Parent process
void *chan; // If !zero, sleeping on chan
int killed; // If !zero, has been killed
struct file *ofile[NOFILE]; // Open files
struct inode *cwd; // Current directory
struct context context; // Switch here to run process
struct trapframe *tf; // Trap frame for the
// current interrupt
};
```
Note that there are more states. For example *final/zombie* or *initial*. 

You can reach zombie state if you are looking at the exit codes or something.

=== 4.6 Summary 

process = running program
