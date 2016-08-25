---
layout: default
title: ADMB Installation Mac XCode
---
<h2>ADMB Installation Mac XCode</h2>

Describes the installation procedure for the MacOS package installer.

**Prerequistes**

Apple Developer Tools (XCode) must be installed from http://developer.apple.com/xcode/.

**Procedure**

Download the 32 or 64 bit MacOS dmg file from the downloads tab of this website.
Open ADMB dmg file. 
In the mounted disk image "ADMB 11", copy "ADMB-11 Terminal" to the "Applications" folder.

**Quick Start**

_Describes the procedure for building and running the ADMB simple example._

1. Open Terminal located in /Applications/Utilities, then type admb for Usage options.
2. Copy the "simple" model from the examples directory.

   ```
   $ cp -R /usr/local/admb/examples/admb/simple .
   ```

3. Must change to the copied simple directory.

   ```
   $ cd simple
   ```

4. Build the simple example.

   ```
   $ admb simple
   ```

5. Run the simple example.

   ```
   $ ./simple
   ```

6. If those commands give output like that shown in the screenshot below, your installation is a success. Consult the ADMB manual for description of the simple output files.
screenshot of testing installation on a Mac

   <img src="images/Screenshot20120326at3.36.39PM.png/image_large"/>
