---
layout: default
title: Quick Start Unix
---

Quick Start Unix
================

*ADMB-12.0*  
*Released December 21, 2017*  

Installing and using ADMB from binary zip distributions for Unix operating systems such as Linux, MacOS, Solaris and BSD.

---

Prerequisites
-------------

The following programs are required to be installed on the local computer.

* C++ compiler

  Supported C++ Compilers for Unix

  * GNU C++
  * Intel C++ Compiler
  * Oracle Solaris Studio
            

* GNU stream editor (sed)

_**Note** &mdash; For MacOS, install XCode with command line tools includes all the prerequistes._

Quick Start
-----------

1. Open a **Terminal** window

2. **Download** ADMB

   Download binary zip distribution

   * For Ubuntu 14 (64Bit), download [admb-12.0-ubuntu14-64bit](https://github.com/admb-project/admb/releases/download/admb-12.0/admb-12.0-ubuntu14-64bit.zip).
   * For Ubuntu 16 (64Bit), download [admb-12.0-ubuntu14-64bit](https://github.com/admb-project/admb/releases/download/admb-12.0/admb-12.0-ubuntu16-64bit.zip).
   * For Fedora 25 (64Bit), download [admb-12.0-fedora25-gcc5.1-64bit](https://github.com/admb-project/admb/releases/download/admb-12.0/admb-12.0-fedora25-gcc5.1-64bit.zip).
   * For Fedora 25 (32Bit), download [admb-12.0-fedora25-gcc5.1-64bit](https://github.com/admb-project/admb/releases/download/admb-12.0/admb-12.0-fedora25-gcc5.1-32bit.zip).
   * For Centos 6 and Oracle Solaris Studio 12.5 (64Bit), download [admb-12.0-centos6-solarisstudio12.5-64bit](https://github.com/admb-project/admb/releases/download/admb-12.0/admb-12.0-centos6-solarisstudio12.5-64bit.zip).
       * For Centos 6 and Intel C++ Compiler 2017 (64Bit), download [admb-12.0-centos6-intelicpc2017-64bit](https://github.com/admb-project/admb/releases/download/admb-12.0/admb-12.0-centos6-intelicpc2017-64bit.zip).   

   Use the command below to extract contents of zip file to _~/admb/_. 

   For Ubuntu 14 (64Bit),

           [~]$ unzip admb-12.0-ubuntu14-64bit.zip

   For Ubuntu 16 (64Bit),

           [~]$ unzip admb-12.0-ubuntu16-64bit.zip

   For Fedora 25 (64Bit),

           [~]$ unzip admb-12.0-fedora25-gcc5.1-64bit.zip

   For Fedora 25 (32Bit),

           [~]$ unzip admb-12.0-fedora25-gcc5.1-32bit.zip

   For Centos 6 and Oracle Solaris Studio 12.5 (64Bit),

           [~]$ unzip admb-12.0-centos6-solarisstudio12.5-64bit.zip

   For Centos 6 and Intel C++ Compiler 2017 (64Bit),

           [~]$ unzip admb-12.0-centos6-intelicpc2017-64bit.zip

3. **Use** ADMB

   In the **Terminal** window, use the steps below to build and run the simple example.

   Change to simple example directory.       

           [~]$ cd admb/examples/admb/simple

   Build simple example.

           [~/admb/examples/admb/simple/]$ ~/admb/admb simple.tpl

   For building with MinGW or Cygwin shells, use the **'admb.sh'** script.

           [~/admb/examples/admb/simple/]$ ~/admb/admb.sh simple.tpl

   Run simple example.

           [~/admb/examples/admb/simple/]$ ./simple

   Read [manuals](https://github.com/admb-project/admb/releases/tag/admb-12.0/) for more information.

4. _**Optional**_ &mdash; Multi-User Installation    

   Installs binary distribution folder to /usr/local/ as super-user.

           [~/admb/]$ sudo make install

   Build and run the simple example without the directory prefix.

           [~]$ cd admb/examples/admb/simple
           [~/admb/examples/admb/simple/]$ admb simple.tpl
           [~/admb/examples/admb/simple/]$ ./simple

   _If unable to build simple example, then use the Manual Installation below._

   _**Alternative**_ &mdash; Manual Installation    

   Copy binary distribution folder to /usr/local/ as super-user.

           [~]$ sudo cp -Rvf admb /usr/local/admb

   Create symlink to main admb script.  Directory _/usr/local/bin/_ should already exist.

           [~]$ sudo ln -sf /usr/local/admb/admb /usr/local/bin/admb

--------------------------------------------------------------------------------
For help and support, contact <users@admb-project.org>.
