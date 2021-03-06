---
layout: default
title: ADMB-12.3: Quick Start MacOS from Zip
---

# ADMB Quick Start MacOS from Zip

*ADMB-12.3*  
*Released March 7, 2021*  

Describe describe downloading, installing and using ADMB from Zip release.

---

**Prerequisite** &mdash; [Apple Developer Tools (XCode)](https://developer.apple.com/xcode/) must be installed with the command line tools.  To install or update command line tools, use the command below in the MacOS Terminal, then click "Install" button in the window.

```
[~]$ xcode-select --install
```

Quick Start
-----------

1. **Download**

   Download [admb-12.3-macos.zip](https://github.com/admb-project/admb/releases/download/admb-12.3/admb-12.3-macos.zip).

   To test and debug admb programs using a debugger, download [admb-12.3-macos-debug.zip](https://github.com/admb-project/admb/releases/download/admb-12.3/admb-12.3-macos-debug.zip) with debugging symbols. Since using the debug libraries will result in slower runs, it is only recommended for troubleshooting and debugging code. 

2. **Install**

   Open a Terminal, then use the command below to extract contents of the zip file to **~/admb-12.3/**. 

   ```
   [~]$ unzip admb-12.3-macos.zip
   ```

3. **Use** ADMB

   In the **Terminal** window, use the steps below to build and run the simple example.

   Change to the simple example directory.       

   ```
   [~]$ cd ~/admb-12.3/examples/admb/simple
   ```

   Build simple example.

   ```
   [~/admb-12.3/examples/admb/simple/]$ ~/admb-12.3/admb simple.tpl
   ```
   > **Debug** &mdash; Use the admb debug option *-g* for debugging.

   Run simple example.

   ```
   [~/admb-12.3/examples/admb/simple/]$ ./simple
   ```

   Read [manuals](http://www.admb-project.org/docs/manuals/) for more information.

Help
----

For help and support, contact <users@admb-project.org>.
