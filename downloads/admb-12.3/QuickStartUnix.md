---
layout: default
title: ADMB-12.3: Quick Start Linux
---

# ADMB Quick Start Linux

*ADMB-12.3*  
*Released March 7, 2021*  

Describe downloading, installing and using ADMB from binary release for Linux.

---

> _**Debugging**_ &mdash; To use admb with a debugger for testing, read [BuildingSourceUnix](BuildingSourceUnix.html) to build with debug symbols.  Since using the debug libraries will result in slower runs, it is only recommended for troubleshooting and debugging code. 

Prerequisites
-------------

The following tools are required to be installed on the local Linux computer.

* GNU C++
* GNU stream editor (sed)

Quick Start
-----------

1. **Download**

   Download [admb-12.3-linux.zip](https://github.com/admb-project/admb/releases/download/admb-12.3/admb-12.3-linux.zip).

2. **Install**

   Open a **Terminal**, then use the command below to extract contents of the downloaded zip file to _~/admb-12.3/_. 

   ```
   [~]$ unzip admb-12.3-linux.zip
   ```

3. **Use** ADMB

   In the **Terminal** window, use the steps below to build and run the simple example.

   Change to simple example directory.       

   ```
   [~]$ cd ~/admb-12.3/examples/admb/simple
   ```

   Build simple example.

   ```
   [~/admb-12.3/examples/admb/simple/]$ ~/admb-12.3/admb simple.tpl
   ```

   > **Debug** &mdash; Use the admb debug option *-g* for debugging.

   Run simple example.

   ```
   [~/admb-12.3/examples/admb/simple/]$ ./simple
   ```

   Read [manuals](http://www.admb-project.org/docs/manuals/) for more information.

Help
----

For help and support, contact <users@admb-project.org>.
