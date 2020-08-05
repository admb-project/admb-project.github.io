---
layout: default
title: ADMB-12.2: Quick Start Linux
---

# ADMB Quick Start Linux

*ADMB-12.2*  
*Released July 31, 2020*  

Describe downloading, installing and using ADMB from binary release for Linux.

---

Prerequisites
-------------

The following tools are required to be installed on the local Linux computer.

* GNU C++
* GNU stream editor (sed)

Quick Start
-----------

1. **Download**

   Download [admb-12.2-linux.zip](https://github.com/admb-project/admb/releases/download/admb-12.2/admb-12.2-linux.zip).

   For developers and users using a debugger to examine admb core libraries should download [admb-12.2-linux-debug.zip](https://github.com/admb-project/admb/releases/download/admb-12.2/admb-12.2-linux-debug.zip) with debugging symbols.  Since using the debug libraries will result in slower runs, it is only recommended for troubleshooting and debugging code. 

2. **Install**

   Open a **Terminal**, then use the command below to extract contents of the downloaded zip file to _~/admb-12.2/_. 

   ```
   [~]$ unzip admb-12.2-linux.zip
   ```

3. **Use** ADMB

   In the **Terminal** window, use the steps below to build and run the simple example.

   Change to simple example directory.       

   ```
   [~]$ cd ~/admb-12.2/examples/admb/simple
   ```

   Build simple example.

   ```
   [~/admb-12.2/examples/admb/simple/]$ ~/admb-12.2/admb simple.tpl
   ```

   Run simple example.

   ```
   [~/admb-12.2/examples/admb/simple/]$ ./simple
   ```

   Read [manuals](http://www.admb-project.org/docs/manuals/) for more information.

Help
----

For help and support, contact <users@admb-project.org>.
