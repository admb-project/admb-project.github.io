---
layout: default
title: ADMB-12.3: Building ADMB Source with Unix
---

# Building ADMB Source with Unix

*ADMB-12.3*  
*Released March 7, 2021*  

Describe building ADMB from source for Unix.

---

Prerequisites
-------------

The following tools should be installed on the local computer.

* C++ compiler

  Supported C++ Compilers for Unix

  * GNU C++
  * Apple Clang
    
* GNU make
* GNU stream editor (sed)
* GNU flex
* _**Optional**_ &mdash; Git client to download from version control.

_**Note** &mdash; For MacOS, install XCode with command line tools which includes all the prerequisites._

Building Source
---------------

1. **Download**

   Download ADMB source distribution [admb-12.3-src.zip](https://github.com/admb-project/admb/releases/download/admb-12.3/admb-12.3-src.zip)

   Open a **Terminal** window

   Use the command below to extract contents of zip file to _~/admb-12.3/_. 

   ```
   [~]$ unzip admb-12.3-src.zip
   ```

   _**Alternative**_ &mdash; Use Git client (see command below) to get source from version control repository.

   ```
   [~]$ git clone https://github.com/admb-project/admb.git
   ```

   This will download the latest source repository to _~/admb/_.


2. **Build**

   Change to admb directory.

   ```
   [~]$ cd admb-12.3
   ```

   To build ADMB, use the command below.
   
   ```
   [~/admb-12.3/]$ make
   ```

   To build ADMB for debugging, use the command below.
   
   ```
   [~/admb-12.3/]$ make DEBUG=yes
   ```

   _**Note**_ &mdash; When the build is completed, **~/admb-12.3/build/admb/** is the binary distribution directory.

3. **Test**

   In the **Terminal** window, use the steps below to build and run the ADMB examples.

   Build examples

   ```
   [~/admb-12.3/]$ make --directory=examples all
   ```

4. _Optional_ &mdash; **Multi-User Installation**    

   Installs binary distribution folder to /usr/local/ as super-user.

   ```
   [~/admb-12.3/]$ sudo make install
   ```

   Build and run the simple example without the directory prefix.

   ```
   [~/admb-12.3/]$ cd examples/admb/simple
   [~/admb-12.3/examples/admb/simple/]$ admb simple.tpl
   [~/admb-12.3/examples/admb/simple/]$ ./simple
   ```

   _If unable to the build simple example, then use the Manual Installation below._

   _**Alternative**_ &mdash; Manual Installation    

   Copy binary distribution folder to /usr/local/ as super-user.

   ```
   [~/admb-12.3/]$ sudo cp -Rvf build/admb /usr/local/admb-12.3
   ```

   _**Note**_ &mdash; The dist folder can be copied to other computers with similar configurations.

   Create symlink to main admb script.  Directory **/usr/local/bin/** should already exist.

   ```
   [~/admb-12.3/]$ sudo ln -sf /usr/local/admb-12.3/admb /usr/local/bin/admb
   ```

   Read [manuals](http://www.admb-project.org/docs/manuals/) for more information.

Help
----

For help and support, contact <users@admb-project.org>.
