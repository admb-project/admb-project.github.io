---
layout: default
title: ADMB-12.2: Quick Start Windows from Zip 
---

# ADMB Quick Start Windows from Zip

*ADMB-12.2*  
*Released July 31, 2020*

Describe downloading, installing and using ADMB from binary zip release for Windows.

---

**Prerequisite** &mdash; Installed Supported C++ Compiler: Rtools 3.5, Rtools 4.0, Msys2 and Microsoft Visual Studio 2015, 2017 and 2019.

Quick Start
-----------

1. **Download**

   Download [admb-12.2-windows.zip](https://github.com/admb-project/admb/releases/download/admb-12.2/admb-12.2-windows.zip) or [admb-12.2-windows-debug.zip](https://github.com/admb-project/admb/releases/download/admb-12.2/admb-12.2-windows-debug.zip).

2. **Install**

   Double click downloaded zip file and extract to **C:\ADMB-12.2**.

3. **Use** ADMB

   Change to simple example directory.

   ```
   C:\> cd \ADMB-12.2\examples\admb\simple
   ```

   Build simple example.

   ```
   C:\ADMB-12.2\examples\admb\simple> C:\ADMB-12.2\admb simple.tpl
   ```

   Run simple example.

   ```
   C:\ADMB-12.2\examples\admb\simple> simple.exe
   ```

   Read [manuals](http://www.admb-project.org/docs/manuals/) for more information.

4. **Configure PATH** &mdash; _Optional_

   Add the ADMB directories **C:\ADMB-12.2\bin** and **C:\ADMB-12.2\utilities** to the system enviroment **PATH** variable.  This will allow admb to be used in every **Windows Command Prompt**.

AD Studio
---------

Alternatively, install [AD Studio](https://github.com/admb-project/adstudio), a
dedicated environment for developing ADMB and TMB models. It uses the C++
compiler from Rtools and has especially good support for R, LaTeX, Markdown,
GDB, and Git.

AD Studio 1.0 comes with ADMB 12.0, which is one version older than 12.1.

Help
----

For help and support, contact <users@admb-project.org>.
