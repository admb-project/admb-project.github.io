---
layout: default
title: TO COMPILE AN ADMB DLL 64 BIT (RUN WITH 64 BIT R ONLY)
---

TO COMPILE AN ADMB DLL 64 BIT (RUN WITH 64 BIT R ONLY)
======================================================

```
SET PATH=C:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\BIN\amd64;%PATH%
set Include=C:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\INCLUDE;C:\Program Files\Microsoft SDKs\Windows\v7.1\include
SET LIB=C:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\LIB\amd64

tpl2cpp -dll simpdll
cl -c /EHsc /LD /Ox -DUSE_LAPLACE -DWIN32 -DOPT_LIB  -D__MSVC32__=8 -I. -I"C:\ADMB\ADMB10.1\Microsoft\64bit"\include simpdll.cpp
cl /LD simpdll.obj df1b2o.lib admod32.lib ado32.lib adt32.lib /link /libpath:"C:\ADMB\ADMB10.1\Microsoft\64bit\lib" /libpath:"C:\Program Files\Microsoft SDKs\Windows\v7.1"\lib\x64 


#32 BIT (RUN WITH 32-BIT R)
SET PATH=C:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\BIN;%PATH%
set Include=C:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\INCLUDE;C:\Program Files\Microsoft SDKs\Windows\v7.1\include
SET LIB=C:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\LIB

tpl2cpp -dll simpdll
cl -c /EHsc /LD /Ox -DUSE_LAPLACE -DWIN32 -DOPT_LIB  -D__MSVC32__=8 -I. -I"C:\ADMB\ADMB10.1\Microsoft\32bit"\include simpdll.cpp 
cl /LD simpdll.obj df1b2o.lib admod32.lib ado32.lib adt32.lib /link /libpath:"C:\ADMB\ADMB10.1\Microsoft\32bit"\lib /libpath:"C:\Program Files\Microsoft SDKs\Windows\v7.1"\lib 




### YOU MUST RUN THE CORRECTLY COMPILED BIT VERSION IN THE SAME BIT VERSION OF r
### For example, 32-bit R needs a 32-bit dll (64-bit won't run), and 64-bit R needs a 64-bit dll (32-bit won't run)

x <- rep(0,100)
f <- 0

dyn.load("C:/ADMB/Examples/dll/simpdll.dll")

.C("simpdll", as.integer(length(x)), as.double(x), as.double(f), "")
xx <- .C("simpdll", as.integer(length(x)), as.double(x), as.double(f), "")

dyn.unload("C:/ADMB/Examples/dll/simpdll.dll")
```
