---
layout: default
---

Simple Makefile for ADMB
------------------------

Tested with gnu make under 64bit linux. Some modifications required for other configurations. Steve added contributed libraries to path.

```
    # to make executables with ADMB "safe" library, simply type make target
    # to make executables with ADMB "optimized" library, type make OPT=TRUE (yes, upper case) target
    # the safe version also sets the debugger flag and does no optimization
    #
    # identify some extra file name suffixes
    .SUFFIXES: .tpl .cpp .o .obj

    # tell make not to delete these intermediate targets
    .PRECIOUS: %.cpp %.o %.obj

    # make some special targets
    .PHONY: default rules

    # does this if no target is specified on command line
    default:
    	@echo No target specified.
    	@echo Usage: make target, e. g. make simple
    	@echo        specify OPT=TRUE to build optimized version

    # establish the C   compiler
    CC=g
    # and linker
    LL=$(CC)

    # set up ADMB flags and appropriate libraries
    # make the "safe" version by default
    # to make "the optimized" version, type  `make OPT=TRUE
    ifeq ($(OPT),TRUE)
      CC_OPT = -O3 -DOPT_LIB
      LFLAGS=  -L$(ADMB_HOME)/lib -L$(ADMB_HOME)/contrib -ldf1b2o -ladmod -ladt -lado -lcontribo -ldf1b2o -ladmod -ladt -lado -lcontribo
    else
      CC_OPT = -v -ggdb -DSAFE_ARRAYS
      LFLAGS= -v -L$(ADMB_HOME)/lib -L$(ADMB_HOME)/contrib -ldf1b2s -ladmod -ladt -lads -ldf1b2s -lcontribs -ladmod -ladt -lads -ldf1b2s -lcontribs
      OPT = FALSE
    endif

    # set general compiler flags
    CFLAGS = -c -m64 -Wall -Wno-deprecated -fpermissive $(CC_OPT) -I$(ADMB_HOME)/include -I$(ADMB_HOME)/contrib -I. -D__GNUDOS__ -Dlinux -DUSE_LAPLACE

    # link the object file into the executable
    %:%.o;
    	$(LL) -o $@ $^ $(LFLAGS)

    # compile the C   into an object file
    %.o:%.cpp;
    	$(CC) $(CFLAGS)  -o $@ $<

    # translate the ADMB template into C   code
    %.cpp:%.tpl;
    	$(ADMB_HOME)/bin/tpl2cpp $*

    # generate some information about what your are doing
    rules:
    	@echo OPT = $(OPT)
    	@echo CC_OPT = $(CC_OPT)
    	@echo PWD = $(PWD)
    	@echo OSTYPE = $(OSTYPE)
    	@echo OS     = $(OS)
    	@echo ADMB_HOME = $(ADMB_HOME)
    	@echo CC = $(CC)
    	$(CC) --version
    	@echo LL = $(LL)
    	@echo CFLAGS = $(CFLAGS)
    	@echo LFLAGS = $(LFLAGS)
```
