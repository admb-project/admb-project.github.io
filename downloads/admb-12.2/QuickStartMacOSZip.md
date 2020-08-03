---
layout: default
title: ADMB-12.2: Quick Start MacOS
---

# ADMB Quick Start MacOS from zip

*ADMB-12.2*  
*Released July 31, 2020*  

Using ADMB zip release for MacOS, describe downloading, installing and using ADMB.

---

**Prerequisite** &mdash; [Apple Developer Tools (XCode)](https://developer.apple.com/xcode/) must be installed.

Quick Start
-----------

1. **Download**

   Download [admb-12.2-macos.zip](https://github.com/admb-project/admb/releases/download/admb-12.2/admb-12.2-macos.zip) or [admb-12.2-macos-debug.zip](https://github.com/admb-project/admb/releases/download/admb-12.2/admb-12.2-macos-debug.zip) with debugging symbols.

2. **Install**

   Open a Terminal, then use the command below to extract contents of zip file to **~/admb-12.2/**. 

   ```
   [~]$ unzip admb-12.2-macos.zip
   ```

3. **Use** ADMB

   In the **Terminal** window, use the steps below to build and run the simple example.

   Change to simple example directory.       

   ```
   [~]$ cd ~/admb-12.2/examples/admb/simple
   ```

   Build simple example.

   ```
   [~/admb-12.2/examples/admb/simple/]$ ~/admb-12.2/admb simple.tpl
   ```

   Run simple example.

   ```
   [~/admb-12.2/examples/admb/simple/]$ ./simple
   ```

   Read [manuals](http://www.admb-project.org/docs/manuals/) for more information.

Help
----

For help and support, contact <users@admb-project.org>.