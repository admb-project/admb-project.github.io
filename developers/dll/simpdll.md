---
layout: default
title: simpdll
---

simpdll
=======

The simpdll.tpl is an example from the ADMB user manual, which can be used to test whether DLL compilation is working or not.

In the shell:

```
admb -d simpdll
```

In R:

```
x <- rep(0,100)
f <- 0

dyn.load("c:/simpdll/simpdll.dll")

.C("simpdll", as.integer(length(x)), as.double(x), as.double(f), "")
x <- .C("simpdll", as.integer(length(x)), as.double(x), as.double(f), "")
```

On some platforms, R hangs when the DLL is first called .C() and then assigned x<-.C(), as shown in the example above.

The goal is of course to make the DLL robust, so R doesn't hang in the example above. That is what Dave Fournier is referring to when he reports that "The code seems to be reentrant for this example" in his recent tests on the Linux-GCC platform.
