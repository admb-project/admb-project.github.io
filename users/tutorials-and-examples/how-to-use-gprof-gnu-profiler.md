---
layout: default
title: How to use gprof, the GNU profiler
---

How to use gprof, the GNU profiler
----------------------------------

Instructions on compiling your ADMB executable to work with the GNU profiler, which records the amount of time spent on individual tasks within the code

These steps successfully created a profile for a model compiled and run on linux. This was all based on instructions for gprof at http://sourceware.org/binutils/docs-2.20/gprof/index.html and trial and error. There may be an easier way already built in to ADMB for all I know. Please correct this as you wish.
-Ian T. Nov 15, 2010.

1. Within the admb/bin directory, create a file "adcomp_pg" which is identical to "adcomp", except that the line near the end has the additional command "-pg":

```
CMD="g++ -c -O3 -Wno-deprecated ${g}${dll}${opt}-D__GNUDOS__ -Dlinux -DUSE_LAPLACE -fpermissive -I. -I$ADMB_HOME/include ${ARG}$model.cpp -pg"
```

2. Also in that directory, create a file "adlink_pg" which is identical to "adlink", except that the line near the end has the additional command "-pg":

```
CMD="g++ ${s}${shared}-L$ADMB_HOME/lib $model.o $df1b2lib -ladmod -ladt $adlib $df1b2lib -ladmod -ladt $adlib ${ARG}$out -pg"
```

3. Compile the model using these scripts instead of the usual ones with the additional of the "-g" option, which will "insert debugging symbols" in the executable (all this could presumably be rolled into something like the "admb" script):

```
tpl2cpp mymodel
adcomp_pg -g mymodel
adlink_pg -g mymodel
```

4. Run the model as you normally would, which should go slightly slower and produce an additional file called "gmon.out"

```
./mymodel
```

5. Convert the gmon.out file into something useful using the "gprof" command:

```
gprof mymodel > myprofile.txt
```

6. Look at the file myprofile.txt. What to actually do with this information is something that I haven't figured out yet.
