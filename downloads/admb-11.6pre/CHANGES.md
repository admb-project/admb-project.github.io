---
layout: default
title: ADMB-11.6pre changes
---

*ADMB-11.6pre*  
*Released December 12, 2016*  

Describe changes and features for each release.

---

Release Notes
-------------
The goals for all releases are
 
* Continually improve algorithms
* Add new requested features
* Correct defects (bugs)
* Continually streamline installation and build process
* Continually improve and update documentation

ADMB-11.6
---------

####New Supported Compilers

* GNU C++ 6.2 and 5.3
* Rtools 3.4
* Oracle Developer Studio 12.5
* Intel C++ Compiler 2017

####Changes and Improvements

* Added floating point checking into tpl2cpp and tpl2rem.

  To check for floating point errors, build executable with -g option.

  $ admb -g "model.tpl"

  Run executable with debugger (such as gdb) to locate file and line number
  where error occured.

  $ gdb ./model

* Configured and automated builds for ADMB-IDE.
* Merged Kasper Kristensen and Anders Nielsen bug fixes.
* Added new features such as tiny_ad.hpp and vectorize developed by DTU. See the report [Extending TMB and ADMB functionality jointly](http://www.admb-project.org/developers/workshops/seattle-2016/Kristensen_Anders_Report.pdf).
* Able to use Rtools\bin\make to build admb from source.
* Replaced rgamma function.
* Fixed numerous bugs and added various improvements.
* Compilers should support C++11 standard to build ADMB.
* Added experimental Hybrid Monte Carlo function by Cole Monnahan.
* Added experimental JSON data structure for data input.
* Added support for C++11 standard into admb script and build files.
* Added support for C++14 standard into admb script and build files if supported by compiler.
* Added release version into admb scripts -h option to help troubleshooting installation conflicts.

  The new output include **Release Version** info.

  $ admb -h

  Builds AD Model Builder executable or library.

  Usage: admb [-c] [-d] [-g] [-r] [-f] model [src(s)]

  **Release Version: 11.6pre**

  Options:
  -c     Build only object file(s) (.obj).
  -d     Build a shared library (.so).
  -g     Build with debug symbols.
  -r     Build with Random effects library (ADMB-RE).
  -f     Build with Fast optimized mode library (no bounds checking).
         By default, admb script builds with bounds checking.
  model  TPL file (ie 'simple.tpl' or the filename 'simple' with no .tpl
         extension)
  src(s) C/C++ Source file(s) containing classes, methods and variables that
         are used in model.
  
* MinGW-w64 Windows installers now include GNU GCC 6.2 compiler.
* Other bug fixes and improvements

####Developers changes

* Added tool for checking for [testing code coverage](https://codecov.io/gh/admb-project/admb).

####Website changes

* Moved website to GitHub pages (see [repository](https://github.com/admb-project/admb-project.github.io)).

ADMB-11.5
---------

####New Supported Compilers
* Microsoft Visual C++ 14.0
* Intel C++ 2016
* GNU C++ 5.1

####Compilers no longer supported
* Microsoft Visual C++ 11.0

####Changes and Improvements
* Change to Dave Fournier's version of cspline.cpp.
* Added Dave Fournier's memory leak patches.
* Fixed memory leaks reported by Valgrind and XCode.
* Added more api documentation.
* mfexp will call ad_exit if computed result is not in range.
* Added more unit tests for better code coverage.
* Fixed MacOS ADMBTerminal from opening two terminals.
* Other bug fixes and improvements

ADMB-11.4
---------

####Changes and Improvements
* Fixed unix shared builds. 
* Other bug fixes and improvements

ADMB-11.3
---------

####Changes and Improvements
* Steve Martell's changes to gamma function.
* Other bug fixes and improvements

ADMB-11.2
---------

####Changes and Improvements
* Default safe libs include overflows checks.
* Changes to derivative checker prompts.
* Added description documentation to the programming interface.
* Improvements to admb scripts (see New Features).
* Added more unit tests for improved code coverage. 
* Fixed reported and found bugs.
* Fixed compilers warnings.
* Add more checks in admb scripts to test for errors.
* Added Quickstart*.txt markup documentation for building and using ADMB.
* User interface: Windows admb bash script has a .sh extension to avoid 
  conflict with batch file.  So in MinGW or Cygwin shell, user will need
  to use 

        [~/admb/examples/admb/simple/]$ ~/admb/admb.sh simple

* Fixed 'admb -d' for unix, mingw and cygwin shells.
* Able to use Rtools for building, but will need to use the utilities\make.exe
  for building.
* Improved the build by restructuring and reworking the GNUmakefiles file.
* Able to use parallel build option (-j) with verify and contrib targets for 
  faster builds.
* To build with optimized libraries use fast option (-f) instead of (-o). 

        $ admb -f model.tpl

* Fix shared (libadmb.so) and dynamic (admb.dll) builds.

        [~/admb/]$ make shared

        C:\admb\> utilities\make shared

  Note &mdash; This is great for testing linker errors.

* Added contributed method to save gradient values to a file.
  Contributed by Jiashen Tang and David Fournier.

        REPORT_SECTION
          save_gradients(gradients);

* Added back the MacOS binary ADMBTerminal app.
* Packaged mingw compilers (32 and 64 bit) with windows installers.
* admb scripts can determine which parser (tpl2cpp or tpl2rem) to use.

        [~/admb/examples/admb-re/union/]$ ~/admb/admb union

  _Note: Option *-r* is no longer needed to build the random effects model._

* Separate build/dist and build/debug for easily switching between the both.
* Allow > 2GB buffers for MinGW-w64 builds.

####New Supported Compilers

* GNU C++ 4.8 compiler
* Apple XCode 6
* MinGW 64 Bit
* Microsoft C++ 2013

 _Note: Borland 5.5 compiler is no longer supported._

####New Features

* Add debug target to build files.

        $ make debug

* Add shared target to build files (Unix only).

        $ make shared

* admb scripts can be called directly and do not require setting enviromental variables
  ADMB_HOME and PATH.

    For Unix,  
   
        [~/admb/example/admb/simple/]$ ~/admb/admb simple

    For Windows, 
  
        C:\admb\example\admb\simple\> C:\admb\admb simple

* admb scripts can build C++ source files and link.

    For Unix, 
  
        [~/admb/example/admb/simple/]$ ~/admb/admb simple.tpl mysource.cpp

    For Windows, 
  
        C:\admb\example\admb\simple\> C:\admb\admb simple.tpl mysource.cpp

* admb scripts have a new option -f for optimized library "OPT_LIB".

    For Unix, 
  
        [~/admb/example/admb/simple/]$ ~/admb/admb -f simple.tpl mysource.cpp

    For Windows, 
  
        C:\admb\example\admb\simple\> C:\admb\admb -f simple.tpl mysource.cpp

* admb scripts have a new option -c for only building object files.

    Both commands below will only build simple.o and mysource.o compiled object files.  
    The model application will not be built. 

    For Unix, 
      
        [~/admb/example/admb/simple/]$ ~/admb/admb -c simple.tpl mysource.cpp

    For Windows, 
  
        C:\admb\example\admb\simple\> C:\admb\admb -c simple.tpl mysource.cpp

    _Note: This is the almost the same as using 'adcomp mysource'._

####Priorities: Next Release

The following are planned or requested features for the next release.

- [ ] Add Threading Support (High)
- [ ] Write Design Documentation (High)
- [ ] Write Developer Documentation (High)
- [ ] Atan2

ADMB-11.1
---------

*ADMB-11.1*  
*Released May 10, 2013*  

####Changes

* Updated Visual Studio nmake build files.

* Improved Unix build files.
 
  * Only outdated files are rebuilt.
  * Fast parallel building with source distribution
        
        [~/admb/]$ make -j
        
  * Building from source will create distribution folder in 'build/dist' instead of 'build/os-compiler-arch'.

* Combined mulitple libraries to a single library 'libadmb.a'. 

* Reverted some algorithms to previous version-9 code.

* The compilation scripts (adcomp, adlink, admb) compile in "safe" mode by 
  default.

* added 's' option with the Ctrl^C

* contributed libraries are built with the main libraries.
 
* flex is not needed to build ADMB, but it is needed to develop the tpl2cpp.lex 
  and tpl2rem.lex files.
  
* Improved documentation.

####New Features
* admb script can now build tpl models without the need to set ADMB_HOME
  or PATH. For example, 

        [~/admb-11.1/examples/admb/simple/]$ ~/admb-11.1/admb simple

* Functions from user-contributed packages can be loaded from
  directory 'contrib'. Read 'contrib/README.txt'.

* New class 'init_table' to read input data into a matrix.

* New function sumsq() to calculate sum of squared values,
  equivalent to norm2().

* New constant PI for 3.141593... Makes models more portable
  than using M_PI or other compiler-specific constants.

* New shell command 'ad2csv' to write binary files to screen 
  or to a file.

* admb is now able to handle .obj, .cpp and .tpl files on
  the commandline.

    For example,

        $ admb model.tpl supportcode.cpp anotherfile.cpp

    Output is executable 'model'.

####Bug Fixes

* Catch exit errors for adlink and adcomp.
* Watch out for spaces in admb scripts
* Fix memory leaks.

Changes 9.2 to 11.0
-------------------
* Fixed gammln functions
* Fixed configure script
* Fixed atan2 functions
* Documentation changes
* Script changes
* Various bug fixes

---
For help and support, email <users@admb-project.org>.
