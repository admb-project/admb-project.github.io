---
layout: default
title: Using ADMB on linux
---

Using ADMB on linux
-------------------

Tips for people converting to linux from Windows

**Installation**

Note, this is just a supplement to the instructions on the [ADMB Installation Linux](/docs/user-contributed-tutorials/admb-installation-linux) page.

To have the $ADMB_HOME and $PATH environmental variables set for all future sessions, edit the ~/.gnomerc (or ~/.bashrc, ~/.bash_login, or some other file that will be loaded when you open a terminal or connect to your computer) and add the following lines. If you're using the ADMB-IDE, it seems best to choose .gnomerc. You may replace /home/USERNAME/admb with /usr/local/admb or any other location where you choose to unzip the ADMB files.

```
#!/bin/bash
export ADMB_HOME=/home/USERNAME/admb
PATH=$PATH:$ADMB_HOME/bin
export PATH
```

For additional perspectives on installation, see this page.

**Compiling**

Compiling may be done in multiple steps, using "tpl2cpp" to convert the TPL file to a C++ file, and "adcomp" and "adlink" to compile and link the C++ file. Or in one step with the "admb" command.

Unlike Windows, the executable file created by this process has no extension, and to run it, you need to add "./" in front of the filename. Thus, a typical sequence might be,

```
admb MYMODEL
./MYMODEL
```

**Input files**

If you're using input files for your model that were created in Windows, you may have problems related to differences in the newline characters. This may have been fixed in recent versions of ADMB. To get around this you can either replace all blank lines with a hash mark (#), or use the command,

```
dos2unix MYFILE.dat
```

to convert the newline characters.The converted files should work on both linux and Windows.
