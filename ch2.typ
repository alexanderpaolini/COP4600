== Chapter 2: Introduction to Operating Systems

A running program executes instructions. We *fetch* -> *decode* -> *execute*. Then we move to the next one.

> This is the Von Neumann model of computing

Thus, this body is called the *Operating System*

The operating system *virtualizes* physical resources and create a general, easy to use *virtual machine*. These operating systems thereby provide *system calls* by which programs can interact with other parts. Thus, a *standard libraru*.

The operating system then manages these.

=== Virtualizing CPU

The operating system virtualizes the CPU to allow for multiple programs to "simultaneously" run. Do note that this isn't truly simultaneous.

The *policy* is the system by which the OS chooses which program to be running at any given time. This is mainly hueristics based on many factors.

=== Virtualizing Memory

Memory is just an array of bytes. *address* -> *data*. THe operating system virtualizes the memory in such a way that every program gets its own set of memory. This simplifies sharing memory.

Each process has its own *virtual address space* (or address space).

The OS manages the actual mapping of hardware memory.

=== Concurrency

Another thing the OS does is run multiple programs at the same time. Often, these programs need to access the same resources.

If programs were to directly access the same memory, they would end up with race conditions, wherein one would modify the memory before another, thus getting overwritten.

=== Persistence

The operating system must also handle persistence of data. Programs cannot exist only in memory -- they must have access to some amount of persistent storage. Whether that be files or whatnot.

Some of these might be *input/output (I/O)*, as well as storage in *hard disk drives (HDDs)* or *solid-state drives (SSDs)*.

THe software in the OS manages this *file system* and any *files* the user creates.

Files, unlike memory and CPU, are not virtual and are expected to be shared between programs. (You wouldn't want a file written by nvim to be only accessable by nvim, would you?)

=== Design Goals

The basic goal of the OS is to create enough *abstractions* to make the system easy to use for most developers.

Some other goals are for high performance, or to minimize the overheads of the OS. Virtualization is nice, but it does maintain an overhead that might not be wanted in other places.

We also want to provide *protection* between applications, and the OS and appplications. If we are to *isolate* different processes from eachother, we can reduce unexpected interference and thus have more stable programs.

Do note that building a reliable operating system is hard.

=== Some History

Operating systems have to be understood with respect to their history.

==== Early Operating Systems: Just Libraries

In the begining operating systems were just libraries of code in which programmers could rely on rather than creating for themselves.

This is because many computers were super large and would still be ran by human operators.

We used *batch* processing in which jobs were setup and run in a batch by the operator.

==== Beyond Libraries: Protection

After the basic libraries, operating systems began to add feature upon feature. We now have system calls to provide access to the system and a file systel to allow for persistence.

Procedures and system calls are different allowing for different levels of protection. For example, the application has no ability to write/read files, but the system can through a syscal.

The OS does this, and then returns through a *return-from-trap*

==== The Era of Multiprogramming

==== The Modern Era

=== Closing
