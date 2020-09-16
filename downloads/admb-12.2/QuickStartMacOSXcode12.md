---
layout: default
title: ADMB-12.2: Quick Start for ADMB Terminal
---

# ADMB Quick Start MacOS

*ADMB-12.2*  
*Released July 31, 2020*  
*Added September 16, 2020*

Describe downloading, installing and using ADMBTerminal from binary release for MacOS with Xcode 12.

---

**Prerequisite** &mdash; [Apple Developer Tools (XCode)](https://developer.apple.com/xcode/) must be installed with the command line tools.  To install or update command line tools, use the command below in the MacOS Terminal, then click "Install" button in the window.

```
[~]$ xcode-select --install
```

Quick Start
-----------

> **Note** &mdash; To install from zip file, read [QuickStartMacOSXcode12Zip](QuickStartMacOSXcode12Zip.html).

1. **Download**

   Download [admb-12.2-macos-xcode12.dmg](https://github.com/admb-project/admb/releases/download/admb-12.2/admb-12.2-macos-xcode12.dmg).

2. **Install**

   Double click downloaded dmg file.

   In the mounted disk image, move **ADMBTerminal** into the **/Applications** folder or preferred folder.

   _**Note**_ &mdash; To allow ADMBTerminal to open in MacOS, open **Security & Privacy** in the **System Preferences**, then click **Open Anyway** for the ADMBTerminal.

3. **Use** ADMB

   Drag examples folder from mounted disk image to home directory.

   Double click **ADMBTerminal** from **/Applications**.

   In the ADMBTerminal, follow the step below:

   Change to the simple example directory.

   ```
   [~]% cd examples/admb/simple
   ```

   Build simple example.

   ```
   [~/examples/admb/simple/]% admb simple
   ```

   Run simple example.

   ```
   [~/examples/admb/simple/]% ./simple
   ```

   Read [manuals](http://www.admb-project.org/docs/manuals/) for more information.

Help
----

For help and support, contact <users@admb-project.org>.
