---
layout: default
title: Updating the MCMC documentation
---

Updating the MCMC documentation
===============================

Ideas for improvements/clarifications for the existing documentation on MCMC methods.
I (Cole), volunteered to revise and expand the ADMB user manual section on MCMC methods. Below are some things I plan on adding, but feel free to add more or any other suggestions you may have.

1. I've talked to users who were not able to discern the basic work flow (e.g. -mcmc and then -mceval). I think this is the top priority.

2. Simple methods to get results into R or other software for diagnostics and analysis.

3. The mcrb and mcprobe options aren't explained so it's not clear when to expect them to be effective. I will detail the underlying algorithms and propose scenarios when the user should consider them.

4. Detail (and provide R code) for how to specify an arbitrary correlation matrix for the proposal function. Dave Fournier pointed out at the Seattle meeting that this can easily lead to non-positive definite matrices which will throw an error.

5. (Long term, lowest priority) Present more theory and examples of how to tune the hybrid MCMC.
