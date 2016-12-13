---
layout: default
title: Downloads ADMB-11.6pre
---

*ADMB-11.6*  
*Released December 12, 2016*  

ADMB binary installation and usage procedure for Windows and Visual C++ compilers using installer.

---
_**Note** &mdash; For Microsoft Visual C++ 2010, read [installation][help] documentation._
[help]: http://www.admb-project.org/documentation/installation/admb-installation-visual-c


Quick Start
-----------

**Prerequisite** &mdash; Visual Studio C++ is installed on the local computer.

_**Note**_ &mdash; A free version is available from: [Visual Studio Express](http://www.visualstudio.com/downloads/download-visual-studio-vs#d-express-windows-desktop)

1. **Download** ADMB Windows Installer for Visual C++

   * For Visual C++ 2015 (64Bit), download [admb-11.6pre-windows10-vc14-64bit](https://github.com/admb-project/admb/releases/download/admb-11.6pre/admb-11.6pre-windows10-vc14-64bit.exe).

   * For Visual C++ 2013 (64Bit), download [admb-11.6pre-windows10-vc12-64bit](https://github.com/admb-project/admb/releases/download/admb-11.6pre/admb-11.6pre-windows10-vc12-64bit.exe).

   * For Visual C++ 2013 (32Bit), download [admb-11.6pre-windows10-vc12-32bit](https://github.com/admb-project/admb/releases/download/admb-11.6pre/admb-11.6pre-windows10-vc12-32bit.exe).

2. **Install** ADMB

   Double click the downloaded **ADMB Windows Installer for Visual C++** and follow instructions.

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
