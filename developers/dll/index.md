---
layout: default
title: 2012-03-26 Email 
---

```

Date: Mon, 26 Mar 2012
From: Arni Magnusson
Subject: DLL compilation

Hi all,

During the ADMB Developers' Meeting in Honolulu earlier this month, we defined tasks and assigned names, and these will probably form a key part of the meeting report. DLL compilation is one task that should probably be included in the report that Jim is putting together.

Shortly before the meeting, Dave Fournier posted a message (https://groups.google.com/forum/?fromgroups#!msg/admb-users/3kYBQ1pWUwM/YOJG0CluVmEJ) reporting that he found DLL compilation to be working fine on the Linux-GCC platform, given the right compilation flags throughout the build process, all the way from ADMB sources to the model executable. See also https://groups.google.com/forum/?fromgroups#!topic/admb-users/zlQVyAFJ28U and earlier discussions.

This needs to be explored further, by those of us with sufficient interest in DLL compilation and some knowledge of C++ compilation in general. The first step is to see which platforms (OS & compiler combinations) we can already build healthy DLLs on. The next steps include streamlining that process and get DLL compilation to work on as many platforms as possible. The recent decision to drop Borland support will make this task a bit easier.

The task could look something like this in the report:

---

DLL compilation on all platforms

GCC (linux), Aaron, Arni, Iago, Matthew
GCC (windows), Arni, Chris, Weihai
MSVC, Allan, Laurie
Clang, Matthew

---

Cheers,

Arni
```
