---
layout: default
title: Documenting ADMB Code
---

Documenting ADMB Functions and Classes
======================================

Guidelines for using Doxygen to create documentation for ADMB functions and classes. Also known as the application programming interface (API), or more simply the dox.

Doxygen is system to create documentation for computer code written in C++ (and other languages). It can generate on-line documentation in HTML and off-line documentation in LaTeX, RTF, and other formats. Doxygen processes special comment blocks and commands within these blocks to create documentation for computer code.

Preliminaries
-------------

Install [Doxygen](http://www.doxygen.org/index.html) and have a look at the documentation. Source code as well as installation instructions and binaries for Linux, MacOS and Windows are available.
Make sure you have write access to the ADMB Subversion repository.
Check out a working copy of the source code or update your existing working copy.

Writing documentation
---------------------

Class and function documentation, or API, consists of text and Doxygen "special commands" enclosed in Doxygen comment blocks. These comment blocks are a superset of standard C comments opening with /** and closing with */. Leading '*' within the comment block are allowed, but since thay are omitted from the dox, they should be avoided since they cutter up the source code.

The bulk of the documentation is written in the C++ header and source code files.The ADMB header (.h and .hpp) files are already pretty long, so avoid adding documentation to the header files if possible. Put Doxygen comment blocks in the .cpp files. The obvious exceptions are classes and their member variables and in-line functions.

The documentation is built and maintained in the directory docs/api on the ADMB subversion reposotory. The Doxygen configuration file, Doxyfile, Makefile and supporting utilities are in this directory.

General introductory information and group definitions are the file docs/api/dox-share/mainpage.txt

Variables in header files can be succinctly documented inline with the special Doxygen notation "///< comment" after the variable, for example "double x; ///< value of the variable". Inline functions should also be documented in the header files.

Do not place the same Doxygen comment blocks in **both** .h and .cpp files because the information will be duplicated in the HTML.

Doxygen will interpret LaTeX-like math notation, so if a function does something mathematically interesting, math formulas should be included. See the [Chapter 6](http://www.stack.nl/~dimitri/doxygen/formulas.html) in Doxygen manual.

Minimum documentation
---------------------

**Files**: Every file should include the \file command to generally indicate what is in the file. The Doxygen special command \file indicates specifies information that will be linked to the file list. Here is the documentation for the file fvar.hpp.

```
/** \file fvar.hpp
AUTODIF classes.
Class definitions for reverse mode automatic differentiation.
Function prototypes for math functions.
Macro definitions.
*/
```

The text prior to the first period (full stop) is treated as a "brief comment" and will also appear in the file list. Text after the first period will appear in the "Detailed Description" for the file.  The Doxygen special command \ingroup should **not** be associated with \file command in a comment block because it will cause to file to be listed in the "Modules" tab discussed further below.

**Classes**: Classes should be described in the header file. All member variables of the class should be described. Here is a fragment of the documentation for class dvector taken from fvar.hpp.

```
/** Vector of double precision numbers.
A basic container class for a one dimensional array of double precision
floating point numbers. 
Fundamental building block for higher dimensional arrays.
All ADMB vector classes have similar functionality.
*/
class dvector
{
 protected:
   double *v;			///< pointer to the data
   int index_min;		///< minimum valid subscript 
   int index_max;		///< maximum valid subscript
   /// pointer to vector "shape"
#if defined(THREAD_SAFE)
   ts_vector_shapex *shape;
#else
   vector_shapex *shape;
#endif
.
.
.
};
```

The class description appears in the Doxygen block before the class declaration. The first sentence serves a brief comment and appears in the class list. The "///<" Doxygen comment is used to create "in-line" documentation for the variables v, index_min, and index_max. The "///" Doxygen comment is used to describe documentation for the variable shape, because Doxygen does not define the macro THREAD_SAFE.

**Functions**: The Doxygen comment block for functions should be placed immediately before the definition of the function. All parameters of functions taking parameters should be described using the \param command. Return values should be described with the \return command.The \ingroup command should be used to assign group membership if appropriate.

```
  /**  Log Poisson density; constant objects.
  \ingroup PDF
  \param x Number of observed occurrences, \f$k\f$.
  \param mu Mean or expected value, \f$\mu\f$.
  \return Log of Poisson density. \f$-\mu+k*\log(\mu)-k!\f$.
  */
  double log_density_poisson(double x,double mu)
  {
```

In this example the \ingroup PDF special command indicates that this function will be listed under Probability Density Functions on the Modules tab. The \param special command is used to describe the arguments and the\return special command is used to describe the object returned. Doxygen LaTeX capabilities, using the \f$ special commands. ares used to provide more explicit definitions of the parameters and the return value, for example, \f$-\mu+k*\log(\mu)-k!\f$ in the \return special command produces $-\mu+k*\log(\mu)-k!$.

Groups and "Modules"
--------------------

Functions and other elements can be grouped and and displayed on the "Modules" tab. The groups are defined (using \defgroup) in docs/api/dox-share/mainpage.txt. Each group definition consists of a "name", a brief "description", and optionally, a \details. Subgroups can be created using the \ingroup special command. The subgroup  name should be used in the Doxygen comment blocks. The "Modules" rubric seems a bit inappropriate. If some one can figure out how to change "Modules" to something more intuitive like "Funtion Reference" The current groups and their subgroups are:

Group Name
Subgroup Name
Description
matop
 	Vector and Matrix Operations
PDF	 	Probability Density Functions
RNG	 	Random Numbers
misc	 	"Helper" Functions
DEVEL	 	Development Utilities
gammafunc	 	Factorial, gamma and related functions
eigen
 	Eigenvalues and eigenvectors
cub_spline	 	Classes and methods for cubic splines
RA	 	RETURN_ARRAY_INCREMENT and RETURN_ARRAY_DECREMENT 
AD	 	Classes for Automatic Differentiation
 	BAD	Reverse mode Automatic Differentiation
 	FAD	Forward mode Automatic Differentiation
CONTRIB	 	User-contributed Libraries
 	STATLIB	Statistical Functions
 	ECOL	Functions useful in Ecology
 	QFC	Functions created at the Quantitative Fisheries Center(QFC), Michigan State University

Compiling the documentation
---------------------------

The easiest way to locally make the dox on your computer is to use the Makefile in the docs/api directory The Makefile will generate the dox using subversion utilities to insert the ADMB version and trunk revision number into the html header information. The Makefile also causes Doxygen to insert the Subversion "Id:" string for each file into the dox for the file.

Alternatively, simply run doxygen from a command prompt in the docs/api folder. The Doxygen GUI may also be used to build the documentation (perhaps).

In any case, the results will be placed in dox/html and can be examined by opening dox/html/index.html in a browser.

You do not need to worry about making your new dox contributions visible online. The ADMB Doxygen server communicates with the ADMB Subversion server and will automatically update the online dox, usually within minutes of committing changes. You can monitor progress by clicking on the "api" row in the ADMB Buildbot grid display. Please read the next section.

To remove the current Doxygen output from your computer, delete the docs/api/dox folder, or run "make clean".

Precautions
-----------

Committing changes to source code files triggers two actions: (1) the ADMB Buldbot will begin to compile all of the source code on all of the supported operating systems and compilers; (2) the Doxygen server will recompile the on-line dox so that they are publicly visible.

Adding and changing documentation requires changes to the ADMB source code, and breaking code while creating dox will result in the award of negative [beer points](../beer-points.html). Testing before committing changes to the repository would therefore be prudent. You should compile the documentation as described above, and verify that the changes you have made appear as expected by opening dox/html/index.html in a browser. You should also make sure that you did not break the source code by recompiling the source (refer to [README.txt](https://github.com/admb-project/admb/blob/master/README.txt)). If you have changed a header file, you should run "make clean" before recompiling the source.

Tweaking the dox
----------------

Doxygen is feature-rich with many options for changing the content of the API documentation and appearance of the html. Most of these options are specified in the configuration file, Doxyfile. Rudimentary flowchart-like diagrams can be generated. The html header and footer and the CSS style sheet can all be changed. These options are described in more detail in the "[Configuration](http://www.stack.nl/~dimitri/doxygen/config.html)" chapter of the Doxygen manual. Exploring the behavior of Doxygen by changing these options is a useful exercise for learning Doxygen and could lead to better documentation.
