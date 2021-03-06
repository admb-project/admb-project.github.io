---
layout: default
title: ADMB-12.3: Building ADMB Source using Windows and Visual Studio
---

# Building ADMB Source using Windows and Visual Studio

*ADMB-12.3*  
*Released March 7, 2021*  

Describe building ADMB from source for Windows and Visual C++ compilers.

---

Prerequisites
-------------

* Visual Studio C++ is installed on the local computer.

Building Source
---------------

1. **Download**

   Download source distribution [admb-12.3-src.zip](https://github.com/admb-project/admb/releases/download/admb-12.3/admb-12.3-src.zip).

   Double click downloaded zip file and extract admb directory to **C:\\admb-12.3\\>**.

2. **Build**

   Open Visual Studio **Developer Command Prompt** window

   * For Visual C++ 2015, Double click **Developer Command Prompt for VS2015** in **Visual Studio Tools**.

   * For Visual C++ 2017, Double click **Developer Command Prompt for VS2017** in **Visual Studio Tools**.

   * For Visual C++ 2019, Double click **Developer Command Prompt for VS2019** in **Visual Studio Tools**.

   In the Visual Studio **Developer Command Prompt** window, use the steps below to build ADMB.

   Change to admb directory.

   ```
   C:\> cd admb-12.3
   ```

   To build ADMB, use the command below.

   ```
   C:\admb-12.3\> nmake
   ```

   To build ADMB for debugging, use the command below.

   ```
   C:\admb-12.3\> nmake DEBUG=yes
   ```

3. **Test**

   In the **Developer Command Prompt** window, use the steps below to build and run the examples.

   Build examples

   ```
   C:\admb-12.3\> cd examples
   C:\admb-12.3\examples\> nmake all
   ```

   Read [manuals](http://www.admb-project.org/docs/manuals/) for more information.

Help
----

For help and support, contact <users@admb-project.org>.
