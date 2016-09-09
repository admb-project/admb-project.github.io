---
layout: default
title: DLL compilation for VS with an R access example
---

DLL compilation for VS with an R access example
-----------------------------------------------

DLL compilation for the Windows VS compiler is now working. Enter the following command at the command line in the directory in which you save these files: admb - d simple. Open the R gui in the same directory and issue this command: source("simple.r"). Then look at the ouput object: xx

[simple.tpl](simple.tpl)
: A very simple example of a TPL used to create a DLL.

[simple.r](simple.r)
: A simple R script used to access the objects inside a DLL created from simple.tpl
