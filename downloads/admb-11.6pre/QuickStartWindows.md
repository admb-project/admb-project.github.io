---
layout: default
title: Downloads ADMB-11.6pre
---

*ADMB-11.6pre*  
*Released December 12, 2016*  

ADMB binary installation and usage procedure for Windows using installer.

---

_For Windows computers with Visual C++ compiler already installed, 
read and follow the instuctions in [QuickStart for Visual C++](QuickStartVisualC.html)._

_For builds within *Cygwin* and *MinGW-Msys* shells, read and follow the
instructions in the [QuickStart for Unix](QuickStartUnix.html)._

Quick Start
-----------
_**Warning** &mdash; Uninstall any existing installations of ADMB._

1. **Download** ADMB Windows Installer

       * For Windows 64Bit, download [admb-11.6pre-windows10-mingw64](https://github.com/admb-project/admb/releases/download/admb-11.6pre/admb-11.6pre-windows10-mingw64.exe).

       * For Windows 32Bit, download [admb-11.6pre-windows10-mingw32](https://github.com/admb-project/admb/releases/download/admb-11.6pre/admb-11.6pre-windows10-mingw32.exe).

       _**Note**_ &mdash; Installers include open source MinGW C++ compiler.

2. **Install** ADMB 

       Double click the downloaded **ADMB Windows Installer** and follow instructions.

3. **Use** ADMB

       On the Desktop, double click **ADMB Command Prompt** shortcut to open command line window.

       In the **ADMB Command Prompt** window, use the steps below to build and run the simple example.
 
       Copy the simple example directory.

           C:\> xcopy /I /E "%ADMB_HOME%\examples\admb\simple" simple

       Change to simple example directory.       

           C:\> cd simple

       Build simple example.

           C:\simple\> admb simple

       Run simple example.

           C:\simple\> simple

       Read [manuals](https://github.com/admb-project/admb/releases/tag/admb-11.6pre/) for more information.

---
For help and support, contact <users@admb-project.org>.
