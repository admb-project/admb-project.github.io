---
layout: default
title: ADMB-12.3: Quick Start Windows
---

# ADMB Quick Start Windows

*ADMB-13.0*  
*Released May 31, 2022*  

Describe downloading, installing and using ADMB from binary release for Windows.

---

**Alternative** &mdash; To install from zip file, read [QuickStartWindowsZip](QuickStartWindowsZip.html).

Quick Start
-----------

1. **Download**

   Download installer [admb-12.3-windows.exe](https://github.com/admb-project/admb/releases/download/admb-12.3/admb-12.3-windows.exe) which includes MinGW-w64 C++ compiler from Rtools-4.0.

2. **Install**

   Double click downloaded installer file and follow menu prompts.

3. **Use** ADMB

   In the Windows Start Menu, locate and double click **ADMB-12.3 Command Prompt**, then use the steps below to build and run the simple example.

   Change to simple example directory.

   ```
   C:\> cd \admb-12.3\examples\admb\simple
   ```

   Build simple example.

   ```
   C:\admb-12.3\examples\admb\simple> admb simple.tpl
   ```

   Run simple example.

   ```
   C:\admb-12.3\examples\admb\simple> simple.exe
   ```

   Read [manuals](http://www.admb-project.org/docs/manuals/) for more information.

4. _Optional_ &mdash; **Configure PATH**

   An alternative to using the **ADMB-12.3 Command Prompt** is to add the ADMB directories **C:\admb-12.3\bin** and **C:\admb-12.3\utilities** to the system enviroment **PATH** variable.  This will allow admb to be used in every **Windows Command Prompt**.

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
