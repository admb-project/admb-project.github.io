---
layout: default
title: Compilers
---

Compilers
=========

GCC vs. Visual C++ vs. Borland (Windows vs. Linux, 32 bit vs. 64 bit)
Comparing four combinations of operating system and compiler 
conducted by Ian Taylor and Allan Hicks
17 Aug 2010 
(note: an incorrect legend in figure below and PDF file was corrected on 7 Sept. 2010).

```
testing_memory_inputs_summary.jpg
```

[ADMB memory test (PDF)](http://www.admb-project.org/developers/benchmarks/ADMBmemoryTest.pdf) is a write-up of a test comparing memory use, run time, and temporary file sizes for four combinations of operating system and compiler. The plot above summarizes some of the findings, including the improvement in speed that comes from 64 bit systems and some of the erratic behavior that comes from providing inputs for the memory settings that are beyond the definition of an integer in C++. General guidance to users and some recommendations for improvements to the ADMB source code are included in the write-up.

The R code used to conduct the test has been generalized so that it may be used for any ADMB model running in Windows or Linux and is available in the file [testing_memory_inputs_functions.R](http://www.admb-project.org/developers/benchmarks/testing_memory_inputs_functions.R). Please write to Ian.Taylor@noaa.gov or Allan.Hicks@noaa.gov if you have trouble running these functions. 

**catage**
conducted by Arni Magnusson
18 Mar 2010

Here is a set of benchmarks for different compilers and operating systems. The benchmarks are created using a dual-boot Lenovo T61 laptop with Intel Core 2 Duo T7500 processor and 4GB RAM, running Windows XP (win32) and Kubuntu 8.04 (linux64). The benchmarks are based on the 'catage' example included with ADMB, and the results show how many seconds one model run takes. 

catage -mcmc 100000 -mcsave 100

  11 admb-9.1-linux-gcc4.1-64bit (2009)
  18 admb-9.1-windows-mingw-gcc4.4-32bit (2009)
  19 admb-9.1-windows-mingw-gcc3.4-32bit (2009)
  20 admb-9.1-windows-vc9-32bit (2009)
  26 admb-5.0.1-windows-vc6 (2000)
  32 admb-9.1-windows-bcc551-32bit (2009)
  37 admb-5.0.2-windows-bcc52 (2001)
  38 admb-5.0.1-windows-gcc295 (2000)

In the 'catage' benchmark, linux64 runs around 64% faster than win32 (0.091 vs. 0.056 runs/sec). Previous benchmarks have shown that linux32 is only marginally slower than linux64 (ADMB Foundation Newsletter 1(1):2), implying that the 64% difference is mainly a Linux vs. Windows effect, rather than 32-bit vs. 64 bit. In Windows, GCC and Visual C++ show similar performance, around 59% faster than the current Borland compiler (0.053 vs. 0.031 runs/sec). The performance of all compilers has improved with later releases (bcc55>bcc52, gcc440>gcc295, and vc9>vc6).

The benchmark shows that PCs can do 64% more work when running Linux. This performance boost can benefit modellers who use Windows as their main working environment, if they configure their machines as dual boot or have access to a Linux machine. After compiling a model in Linux, it can be run on Windows-only machines with the help of Linux live CDs. Linux provides both simple (ssh, scp) and advanced ways (clusters) to distribute a large number of model runs between different machines on a network.

**Stock Synthesis**
conducted by Ian Taylor
September of 2009 (I think)

These speed tests were conducted on a Lenovo Z61t laptop with dual boot for either 32 bit Windows XP and 64 bit Ubuntu 9.04. The processor is Intel Core Duo T7200 with 2GB memory. The "Simple" model distributed with Stock Synthesis version 3.04 on the [NOAA Fisheries Toolbox website](http://nft.nefsc.noaa.gov/Download.html) was used and the inputs -gbs 100000000 and -cbs 100000000 were applied in all cases. The ss3_opt.exe compiled for windows using Microsoft Visual C++ and the Linux executable (not yet part of distribution) was compiled using GCC 4.1.2.

|Run                                  |  windows32|    linux64|
|-------------------------------------|-----------|-----------|
|SS3_opt                              | 98 seconds| 61 seconds|
|SS3_opt -noest -mcmc 10000 -mcsave 10|328 seconds|215 seconds|

It's not clear how much of the greater speeds of running in linux are due to the qualities of linux as opposed to the 64 bit vs 32 bit operating systems. A previous, poorly recorded comparison between linux32 and linux64 on this same computer showed the 64 bit faster, but by a smaller margin, indicating that both factors likely play a role in the observed difference noted above, which is consistent with the observations Arni made previously.
