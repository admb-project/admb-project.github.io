---
layout: default
title: Profiling with Valgrind
---
<h2>Valgrind</h2>

Describe the procedure for using Valgrind to profile and check memory leaks.

**Purpose**

Describe the procedure for using [Valgrind](http://www.valgrind.org/) to profile and check memory leaks. 

Valgrind runs on Linux and MacOS platforms. 

**Procedure**

1. Follow the [INSTALL.txt](https://github.com/admb-project/admb/blob/master/INSTALL.txt) to build from source with debugging.   

   ```
   [admb-trunk]$ make debug 
   ```

2. Build model with debug.

   ```
   [admb-trunk/examples/admb/simple/]$ admb -g simple 
   ```

3. Check memory.

   ```
   [admb-trunk/examples/admb/simple/]$ valgrind --tool=memcheck --leak-check=full ./simple 
   ```

   Output gives description of any leaks.

4. Check profile.

   ```
   [admb-trunk/examples/admb/simple/]$ valgrind --tool=callgrind ./simple  
   ```

   Visualize profile

   ```
   [admb-trunk/example/admb/simple/]$ kcachegrind callgrind.*
   ```
