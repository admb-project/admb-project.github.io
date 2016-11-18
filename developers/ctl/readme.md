---
layout: default
title: Readme
---

Readme
======

```
Date: Sat, 18 Jan 2014 10:03:50 +0000 (UTC)
From: Arni Magnusson <arnima@hafro.is>
To: developers@admb-project.org
Subject: Re: Control files and basic MCMC

Excellent.

ADMB version r1509 proudly presents the LUP vector. A new overloaded
function init_bounded_number(LUP) that accepts as an argument a vector
of length 3 that specifies the lower bound, upper bound, and phase.

As the rest of us were getting excited about pseudocode and issue
tickets Dave ended the discussion by just writing the code... Steve
Martell then committed the code to the trunk (r1509).

I have created a Plone directory dedicated to this development at
http://admb-project.org/developers/ctl

It currently contains three models (example, pella, pella2) that
demonstrate the new capability. As advertised, the code shrinks and
simplifies considerably. In pella2, the control file is now LUP instead
of PLUI, so the initial values are set in a .pin file. One could of
course specify the initial values at the bottom of the control file, or
put everything in the .dat file, like John Sibert mentioned.

I hope the http://admb-project.org/developers/ctl directory will
encourage developers to test and upload new ideas about further
improvements of the control file functionality in ADMB. John's XML idea
could be valuable, also to establish a general interface to external
programs or data servers. ADMB can handle big data, right?

Arni

```

CTL Models

* [example](example/)
* [pella](pella/)
* [pella2](pella2/)
