---
layout: default
title: Quick Start Visual C++ from Source
---

Quick Start Visual C++ from Source
==================================

*ADMB-12.0*  
*Released December 21, 2017*  

ADMB source build and usage procedures for Windows and Visual C++ compilers.

---

Quick Start
-----------

**Prerequisite** &mdash; Visual Studio C++ is installed on the local computer.

_**Note**_ &mdash; A free version is available go to [Visual Studio Express](http://www.visualstudio.com/downloads/download-visual-studio-vs#d-express-windows-desktop).

1. **Download** ADMB source

   - Download source distribution [admb-12.0-src.zip](https://github.com/admb-project/admb/releases/download/admb-12.0/admb-12.0-src.zip).

   - Double click downloaded zip file and copy admb directory to **C:\\admb\\>**.

2. **Build** ADMB source

   - Open Visual Studio **Developer Command Prompt** window

     * For Visual C++ 2015, Double click **Developer Command Prompt for VS2015** in **Visual Studio Tools**.

     * For Visual C++ 2013, Double click **Developer Command Prompt for VS2013** in **Visual Studio Tools**.

     * For Visual C++ 2012, Double click **Developer Command Prompt for VS2012** in **Visual Studio Tools**.

   - In the Visual Studio **Developer Command Prompt** window, use the steps below to build ADMB.

     - Change to admb directory.

       ````
       C:\> cd admb
       ````

     - To build ADMB, use the commands below.

       ````
       C:\admb\> nmake
       ````

     - If debug symbols are needed, use the command below.

       ````
       C:\admb\> nmake debug
       ````

     - Close Visual Studio **Developer Command Prompt** window.

3. **Use** ADMB

   - Using Windows Explorer, double click the **ADMB Command Prompt** shortcut located in **C:\admb\>**.

   - In the **ADMB Command Prompt** window, use the steps below to build and run the simple example.
 
   - Change to simple example directory.       

     ````
     C:\> cd admb\examples\admb\simple
     ````

   - Build simple example.

     ````
     C:\admb\examples\admb\simple\> admb simple
     ````

   - Run simple example.

     ````
     C:\admb\examples\admb\simple\> simple
     ````

   - Read [manuals](https://github.com/admb-project/admb/releases/tag/admb-12.0/) for more information.

---
For help and support, contact <users@admb-project.org>.
