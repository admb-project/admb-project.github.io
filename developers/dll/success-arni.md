---
layout: default
title: DLL Success - Arni
---

DLL Success - Arni
==================

Please upload your platform-specific DLL "success stories"

```
                      dll  simple  simpdll

admb050-bcc52         yes     804      812
admb050-gcc295        yes     993     1057
admb050-vc6           yes     496      536
admb091-bcc55          **     501      505**
admb091-gcc345          *    1846     1900*
admb091-gcc440          *    1840     1906*
admb091-vc9            no     780        -
admb100-gcc450-win32    *    1877     1942*
admb101-gcc452-win32    *    1894     1972*
admb101-linux-64       no     833        -
admb101_r364-vc10-32  yes    1379     1406
admb101_r364-vc10-64  yes    1673     1691

*:half-broken dll - can do either .C(...) or x<-.C(...), not both
**:broken dll - R crashes
```

The table above shows the level of DLL compilation success by platform, along with the size (in KB) of executables and DLLs.
