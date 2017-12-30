---
layout: default
title: Quick Start Unix from Source
---

Quick Start Unix from Source
============================

*ADMB-12.0*  
*Released December 21, 2017*  

ADMB source build and usage procedures for Unix operating systems such as Linux, MacOS, Solaris and BSD.

---

Prerequisites
-------------

The following programs should be installed on the local computer.

* C++ compiler

      Supported C++ Compilers for Unix

      * GNU C++
      * Intel C++ Compiler
      * Oracle Solaris Studio 12.3     
    
    
* GNU make
* GNU stream editor (sed)
* GNU flex
* _**Optional**_ &mdash; Subversion Client to download from source version control.

_**Note** &mdash; For MacOS, install XCode with command line tools includes all the prerequistes._

Quick Start
-----------

1. Open a **Terminal** window

2. **Download** ADMB source distribution

       Download ADMB source distribution [admb-12.0-src.zip](https://github.com/admb-project/admb/releases/download/admb-12.0/admb-12.0-src.zip).

       Use the command below to extract contents of zip file to _~/admb/_. 

           [~]$ unzip admb-12.0-src.zip

       _**Alternative**_ &mdash; Use Git client (see command below) to download directly from ADMB version control repository.

           [~]$ git clone https://github.com/admb-project/admb.git

       This will download latest source repository to _~/admb/_.

3. **Build** ADMB source

       Change to admb directory.

           [~]$ cd admb

       To build ADMB, use the commands below.

           [~/admb/]$ make

       If debug symbols are needed, use the commands below.

           [~/admb/]$ make debug

       _**Note**_ &mdash; When the build is completed, **~/admb/build/dist/** is the binary distribution directory.

4. **Use** ADMB

       In the **Terminal** window, use the steps below to build and run the simple example.

       Change to simple example directory.       

           [~/admb/]$ cd examples/admb/simple

       Build simple example.

           [~/admb/examples/admb/simple/]$ ~/admb/admb simple.tpl

       _**Note**_ &mdash; For MinGW-Msys and Cygwin shells, use the **'admb.sh'** script.

           [~/admb/examples/admb/simple/]$ ~/admb/admb.sh simple.tpl

       Run simple example.

           [~/admb/examples/admb/simple/]$ ./simple

       Read [manuals](https://github.com/admb-project/admb/releases/tag/admb-12.0/) for more information.

5. _**Optional**_ &mdash; Multi-User Installation    

       Installs binary distribution folder to /usr/local/ as super-user.

           [~/admb/]$ sudo make install

       Build and run the simple example without the directory prefix.

           [~/admb/]$ cd examples/admb/simple
           [~/admb/examples/admb/simple/]$ admb simple.tpl
           [~/admb/examples/admb/simple/]$ ./simple

       _If unable to build simple example, then use the Manual Installation below._

       _**Alternative**_ &mdash; Manual Installation    

       Copy binary distribution folder to /usr/local/ as super-user.

           [~/admb/]$ sudo cp -Rvf build/dist /usr/local/admb

       _**Note**_ &mdash; The dist folder can be copied to other computers with similar configurations.

       Create symlink to main admb script.  Directory **/usr/local/bin/** should already exist.

           [~/admb/]$ sudo ln -sf /usr/local/admb/admb /usr/local/bin/admb

--------------------------------------------------------------------------------
For help and support, contact <users@admb-project.org>.
