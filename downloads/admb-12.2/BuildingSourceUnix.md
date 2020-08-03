---
layout: default
title: ADMB-12.2: Building Source for Unix
---

# ADMB Building Source for Unix

*ADMB-12.2*  
*Released July 31, 2020*  

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

_**Note** &mdash; For MacOS, install XCode with command line tools that includes all the prerequisites._

Building Source
---------------

1. **Download**

   Download ADMB source distribution [admb-12.2-src.zip](https://github.com/admb-project/admb/releases/download/admb-12.2/admb-12.2-src.zip)

   Open a **Terminal** window

   Use the command below to extract contents of zip file to _~/admb-12.2/_. 

   ```
   [~]$ unzip admb-12.2-src.zip
   ```

   _**Alternative**_ &mdash; Use Git client (see command below) to get source from version control repository.

   ```
   [~]$ git clone https://github.com/admb-project/admb.git
   ```

   This will download latest source repository to _~/admb/_.


2. **Build**

   Change to admb directory.

   ```
   [~]$ cd admb-12.2
   ```

   To build ADMB, use the commands below.
   
   ```
   [~/admb-12.2/]$ make
   ```

   _**Note**_ &mdash; When the build is completed, **~/admb/build/admb/** is the binary distribution directory.

3. **Test**

   In the **Terminal** window, use the steps below to build and run the simple example.

   Build examples

   ```
   [~/admb-12.2/]$ make --directory=examples all
   ```

4. _**Optional**_ &mdash; Multi-User Installation    

   Installs binary distribution folder to /usr/local/ as super-user.

   ```
   [~/admb-12.2/]$ sudo make install
   ```

   Build and run the simple example without the directory prefix.

   ```
   [~/admb-12.2/]$ cd examples/admb/simple
   [~/admb-12.2/examples/admb/simple/]$ admb simple.tpl
   [~/admb-12.2/examples/admb/simple/]$ ./simple
   ```

   _If unable to build simple example, then use the Manual Installation below._

   _**Alternative**_ &mdash; Manual Installation    

   Copy binary distribution folder to /usr/local/ as super-user.

   ```
   [~/admb-12.2/]$ sudo cp -Rvf build/admb /usr/local/admb-12.2
   ```

   _**Note**_ &mdash; The dist folder can be copied to other computers with similar configurations.

   Create symlink to main admb script.  Directory **/usr/local/bin/** should already exist.

   ```
   [~/admb-12.2/]$ sudo ln -sf /usr/local/admb-12.2/admb /usr/local/bin/admb
   ```

   Read [manuals](http://www.admb-project.org/docs/manuals/) for more information.

Help
----

For help and support, contact <users@admb-project.org>.