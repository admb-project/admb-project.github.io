---
layout: default
title: ADMB vs. Gauss vs. Matlab vs. R/S-Plus
---

Obsolete benchmark (1998/2006)
==============================

ADMB vs. Gauss vs. Matlab vs. R/S-Plus
Summary written by Arni Magnusson, 16 June 2010

Schnute et al. (1998) published a benchmark comparing the performance of different optimization software. They tested ADMB, Gauss, Matlab, and S-Plus with a catch-at-age model by Schnute and Richards (1995), using datasets simulated with S-Plus.

The simulated datasets included T years of data and A age classes, resulting in m=T+A+5 estimated parameters. The computer had a 133 MHz processor and 48 MB RAM, running Windows NT 4.0.

 

Benchmark trials for two cases of a catch-at-age model, in which T years of data are available for A age classes and the total number of parameters is m=T+A+5.

Case
T	A	m	Product	ms/call	Calls
Time
Scale
1	20
12
37
ADMB
29
161
4.6 s
1.0




GAUSS
42
4,041
2.8 min
1.0




MATLAB
178
1,936
5.8 min
1.0




S-PLUS
1429
n/a
n/a

2
80
15
100
ADMB
131
291
38 s
8.3




GAUSS
167
23,365
1.08 hr
23.1




MATLAB
639
18,360
3.25 hr
33.6




S-PLUS
n/a
n/a
n/a

 

 

S-Plus exhausted the computer memory before finishing the calculations, and in smaller examples where evaluations were obtained, S-Plus was much slower than the other products.

ADMB performed much faster and required fewer function calls than its competitors in this benchmark. The reduced number of function calls stems directly from automatic differentiation. One call in ADMB evaluates both the function and its gradient. The other products approximate gradients by making a small change to each estimated parameter, requiring m+1 function calls to achieve the same result. Furthermore, ADMB obtains gradients accurate to machine precision, instead of approximations.

Case 2 scales the problem by a factor of 100/37=2.7, but the computation time increases by a greater factor. ADMB appears more scalable than the other products, probably from the efficiencies of reverse automatic differentiation.

---

Schnute, J.T. and L.J. Richards. 1995. The influence of error on population estimates from catch-age models. Canadian Journal of Fisheries and Aquatic Sciences 52:2063-2077.

Schnute, J.T., L.J. Richards, and N. Olsen. 1998. In: F. Funk et al. (eds.) Fishery stock assessment models. Fairbanks: Sea Grant Program, pp. 171-184.

**Update**

In Nov 2006, Dave Fournier ported the S-Plus model to R and benchmarked it against ADMB on newer hardware. With T=80 years and A=15 ages, the updated benchmark corresponds to Case 2 in the original benchmark:

Product	ms/call
Calls
Time
Function value
ADMB
10.79
278
3 s
3718.693119
R
33.17
56,074
31 min
3717.469
R
33.81
165,000
93 min
3718.693119

In the first run, R was manually interrupted after 31 minutes, to check the function value and parameter estimates. The function value was still far from the optimal value, and one parameter, gamma, was at 0.61, far from the optimal value of 0.42.

In the other run, R was allowed to converge. This took 93 minutes, more than 1000 times longer than ADMB.

---

The updated benchmark is described on http://otter-rsch.com/tresults.htm
