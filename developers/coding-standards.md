---
layout: default
title: ADMB Coding Standards
---

ADMB Coding Standards
=====================

Coding Standards are guidelines and recommendations for writing and maintaining source code.  The  purpose of standards is to improve readability and to help insure that code written by multiple authors has the same appearance. ADMB uses some rules from

* "The Elements of C++ Style" by Trevor Misfeldt, Gregory Bumgardner and Andrew Gray. A summary of this references is available [on-line](http://www.abxsoft.com/ecs/ecs-std.html).
* "C++ Coding Standards" by Herb Sutter and Andrei Alexandrescu
* "[Google C++ Style Guide](http://google-styleguide.googlecode.com/svn/trunk/cppguide.xml)" by Benjy Weinberger, Craig Silverstein,Gregory Eitzmann, Mark Mentovai,Tashana Landray.

General Principles
------------------

The most important principles are the first 2 from Misfeldt et al

1. Adhere to the style of the original.
2. Adhere to the Principle of Least Astonishment.

ADMB Coding Standards
---------------------

1. All files should have CR line endings. Exceptions are the windows batch files. Windows text files that are opened in unix show ^M characters which makes the file less readable.
2. Avoid the use of tabs in source files. Tabs are displayed differently in editors. Use two (2) spaces for indents. This is common in most coding standards.  See Indent tool below.
3. Lines should be no longer than 80 characters. This makes it easier to print and improves readability.
4. Avoid spaces at the end of lines.
5. Place opening and closing braces on their own lines to avoid having to search for them. For example. 

   ```
   if (x<0.0)
   {
     y = a;
   }
   else
   {
      y = b * x;
   }
   ```

   **Indenting tool**

   Many linux-like systems have the indent utility. The following bash script produces nice-looking code, but it is not perfect, and some additional work with an editor may be required. See.

   ```
   #!/bin/bash
   #
   # reformats source code to ADMB style using indent
   # see http://www.gnu.org/software/indent/
   #
   # Author: John Sibert
   #
   cp -v $1 $1.bak
   indent -nbad -bap -bbo -nbc -bl -blf -bli0 -bls -c33\
    -cd33 -ncdb -ce -ci3 -cli0 -cp33 -cs -d0 -di1 -nfc1\
    -nfca -hnl -i3 -ip0 -l75 -lp -npcs -nprs -npsl -saf\
    -sai -saw -nsc -nsob -nss $1 -o indent.out
   cp -v indent.out $1
   ```

6. Do not use camelBack notation (ie getSomething()).

Adding new functions and files
------------------------------

**Adding a new function**

* Allocate the file to the source sub-directory (linad99,  sparse, df1b2-separable,  nh99 , tools99)  in the  src directory with most similar content (according to your judgement) and insert your new function there. 
  * Avoid duplicating existing functions (do a "grep").
* Include a function declaration in one of the header files:
  * If your function is of ordinary ADMB/autodif type (not df1b2) the header file is "src/linad99/fvar.hpp"
  * If your function is using one of the df1b2 types (for the random effects stuff) the header file is "src/df1b2-separable/df1b2fun.h"
* When you write a function involving df1b2 objects as arguments (and return type) there always needs to be a complimentary function of ordinary ADMB/autodif variable type. An example of a set of complimentary functions is:

  ```
  df1b2vector sin(const df1b2vector&);
  dvar_vector sin(const dvar_vector&);
  ```

Adding new files
----------------

When a new cpp file is added to a directory it must be listed in the "objects.lst" file in that directory in order to be compiled into the libraries. 

  * Example: "my_new.cpp" would be listes as "my_new.obj".

Naming conventions
----------------
_ToDo_

