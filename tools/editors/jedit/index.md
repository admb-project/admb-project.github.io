---
layout: default
title: jEdit Installation
---

jEdit Installation
------------------

How to obtain jEdit and install the syntax highlighting

[jEdit](http://www.jEdit.org/) is yet another free open source editor which has the advantage over the others listed here of running on Linux and Mac operating systems as well as Windows.

The ADMB syntax files for the Crimson Editor have been adapted to the XML format used by jEdit. Download the [admb.xml](admb.xml) file and save it in the folder C:\Documents and Settings\username\.jedit\modes\

In that same folder, look for a file called "catalog" and modify or newly create to include the following (the important line obviously is the one with "ADMB" in it):

```xml
<?xml version="1.0"?>
<!DOCTYPE MODES SYSTEM "catalog.dtd">

<MODES>

<MODE NAME="ADMB" FILE="admb.xml" FILE_NAME_GLOB="*.tpl" />

</MODES>
```
