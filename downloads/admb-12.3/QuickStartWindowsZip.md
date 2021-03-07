---
layout: default
title: ADMB-12.3: Quick Start Windows from Zip 
---

# ADMB Quick Start Windows from Zip

*ADMB-12.3*  
*Released March 7, 2021*

Describe downloading, installing and using ADMB from binary zip release for Windows.

---

**Prerequisite** &mdash; Installed a supported C++ compiler: [Rtools 3.5](https://cran.r-project.org/bin/windows/Rtools/history.html), [Rtools 4.0](https://cran.r-project.org/bin/windows/Rtools/), [Msys2](https://www.msys2.org) or Microsoft Visual Studio 2015, 2017 and 2019.

> _**Debugging**_ &mdash; To use admb with a debugger for testing, read [BuildingSourceVisualStudio](BuildingSourceVisualStudio.html) to build with debug symbols.  Since using the debug libraries will result in slower runs, it is only recommended for troubleshooting and debugging code. 

Quick Start
-----------

1. **Download**

   Download [admb-12.3-windows.zip](https://github.com/admb-project/admb/releases/download/admb-12.3/admb-12.3-windows.zip).

2. **Install**

   Double click downloaded zip file and extract **admb-12.3** folder to **C:\**.

3. **Use** ADMB

   Change to simple example directory.

   ```
   C:\> cd \admb-12.3\examples\admb\simple
   ```

   Build simple example.

   ```
   C:\admb-12.3\examples\admb\simple> C:\admb-12.3\admb simple.tpl
   ```
   > **Debug** &mdash; Use the admb debug option *-g* for debugging.

   Run simple example.

   ```
   C:\admb-12.3\examples\admb\simple> simple.exe
   ```

   Read [manuals](http://www.admb-project.org/docs/manuals/) for more information.

4. _Optional_ &mdash; **Configure PATH**

   Add the ADMB directories **C:\admb-12.3\bin** and **C:\admb-12.3\utilities** to the system enviroment **PATH** variable.  This will allow admb to be used in every **Windows Command Prompt**.

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
