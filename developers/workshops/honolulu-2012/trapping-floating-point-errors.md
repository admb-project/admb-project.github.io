---
layout: default
---

Trapping floating point errors
------------------------------

Dave's simple additions to a TPL file to trap floating point errors

Add #include <fenv.h> to the GLOBALS_SECTION and a call to feenableexcept(EXCEPTION) to TOP_OF_MAIN_SECTION where EXCEPTION is one of the macros to trap specific exceptions. Refer to the man page for fenv or <http://pubs.opengroup.org/onlinepubs/009604599/basedefs/fenv.h.html>. (Each of the macros FE_DIVBYZERO, FE_INEXACT,  FE_INVALID,  FE_OVERFLOW, and FE_UNDERFLOW  is  defined.)

```
    TOP_OF_MAIN_SECTION
       feenableexcept(FE_DIVBYZERO); // to trap division by zero

    GLOBALS_SECTION
      // the order of the include statements is important
      #include <fenv.h> // must appear before admodel.h
      #include <admodel.h>
```

Build the executable to use a debugger and run the program. When the program crashes, do a back trace (Status->Backtrace in DDD) to find the line in the .cpp file that caused the exception.

**Warning:** Jim reported some problems using fenv.h and discovered that it not available on some platforms. Apparently there are some unresolved portability problems and this function is missing on all non-glibc platforms: MacOS X 10.5, FreeBSD 6.0, NetBSD 5.0, OpenBSD 3.8, AIX 5.1, HP-UX 11, IRIX 6.5, OSF/1 5.1, Solaris 11 2010-11, Cygwin 1.7.7, mingw, Interix 3.5, BeOS. [See][1] for more information.

[1]: http://www.gnu.org/software/gnulib/manual/html_node/Glibc-Function-Substitutes.html#Glibc-Function-Substitutes
