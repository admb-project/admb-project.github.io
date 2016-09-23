---
layout: default
title: ADMB Frequently Asked Questions
---
<h2>ADMB Frequently Asked Questions (FAQs)</h2>
<p>If you have ideas for additions or modifications, please send them to
  <a href="mailto:Ian.Taylor@noaa.gov">Ian.Taylor@noaa.gov</a>.<br />
  ADMB developers with editing privileges are welcome
  to make changes, but should read the 
  <a href="/developers/contribute-documentation/faq/">
  Note on Editing the FAQ before doing so.</p>

  <!-- ===================================================
       Table of Contents in this file were created using
       the custom toc4faq function in R
       creation date: 2016-09-08 17:08:19
       =================================================== -->

<!-- Table of Contents -->
<h3><a href="#general">General Information</a></h3>
<ol>
      <li><a href="#what-is">What is ADMB?</a></li>
      <li><a href="#acronym">What does ADMB stand for?</a></li>
      <li><a href="#auto-diff">What is automatic differentiation?</a></li>
      <li><a href="#advantages">What is the advantage of using ADMB?</a></li>
      <li><a href="#why-better">Why is AD Model builder better than using spreadsheet solvers or other statistical packages?</a></li>
      <li><a href="#overparameterization">But aren't models with hundreds or even thousands of parameters overparameterized?</a></li>
      <li><a href="#obtaining">Where do I get it?</a></li>
      <li><a href="#OS">What operating systems are supported?</a></li>
      <li><a href="#cost">What does it cost?</a></li>
      <li><a href="#learning">How can I learn how to use ADMB?</a></li>
      <li><a href="#restrictive">Isn't this sort of package too restrictive?</a></li>
      <li><a href="#courses">Are there courses I can take?</a></li>
      <li><a href="#books">Are there any books on ADMB?</a></li>
      <li><a href="#learning">How can I learn more about ADMB?</a></li>
      <li><a href="#who-uses">Who uses ADMB?</a></li>
      <li><a href="#creator">Who created ADMB?</a></li>
      <li><a href="#core-team">Who is currently developing ADMB?</a></li>
      <li><a href="#improving">Can I help improve ADMB?</a></li>
      <li><a href="#financial-support">How is ADMB supported financially?</a></li>
      <li><a href="#citations">How can I cite ADMB?</a></li>
      <li><a href="#GUI">Is there a GUI for ADMB?</a></li>
      <li><a href="#editors">What editors work with ADMB?</a></li>
      <li><a href="#software-interaction">How does ADMB interact with other software?</a></li>
</ol>
<h3><a href="#installation">Installation</a></h3>
<ol>
      <li><a href="#install">How do I install ADMB?</a></li>
      <li><a href="#which-version">Which version is best for my computer?</a></li>
      <li><a href="#linux-packages">Is there a .rpm or .deb package for easy Linux installation?</a></li>
      <li><a href="#borland">Does ADMB work with Borland compilers?</a></li>
      <li><a href="#environment-variables">How do I set the PATH and other environment variables?</a></li>
      <li><a href="#install-fail">Why did my installation of ADMB fail?</a></li>
      <li><a href="#source">Is the ADMB source code available?</a></li>
      <li><a href="#build">Can I build ADMB directly from the source code?</a></li>
      <li><a href="#conflicts">How can I avoid conflicts between C++ compilers?</a></li>
</ol>
<h3><a href="#usage">Usage</a></h3>
<ol>
      <li><a href="#files">What are all the files produced by running an ADMB executable?</a></li>
      <li><a href="#memory">How do I control memory use in ADMB?</a></li>
      <li><a href="#hessian">What is the Hessian?</a></li>
      <li><a href="#positive-definite">Why does it sometimes say "Hessian does not appear to be positive definite"?</a></li>
      <li><a href="#debugging">Are there tips on debugging code that doesn't seem to be working right?</a></li>
      <li><a href="#migrating-from-borland">How do I compile old Borland TPL’s in MinGW?</a></li>
      <li><a href="#how-to-run-mcmc">What is necessary to run MCMC?</a></li>
      <li><a href="#mcmc-implementation">How is MCMC implemented in ADMB?</a></li>
      <li><a href="#splines">Can I do interpolation?</a></li>
      <li><a href="#parallel">Can ADMB do parallel processing?</a></li>
      <li><a href="#dll">Can ADMB produce DLLs (dynamic-link libraries)?</a></li>
</ol>
<h3><a href="#ADMB-IDE">ADMB-IDE</a></h3>
<ol>
      <li><a href="#what-is-ADMB-IDE">What is ADMB-IDE?</a></li>
      <li><a href="#ADMB-IDE-platforms">Is ADMB-IDE available for Mac or Linux as well as Windows?</a></li>
      <li><a href="#ADMB-IDE-uses">Can I use ADMB-IDE for compiling C++?</a></li>
</ol>
<hr />
<!-- end of Table of Contents -->

<!-- Start of FAQ -->

<h1><a name="general">General Information</a></h1>
<h2><a name="what-is">What is ADMB?</a></h2>
<p>ADMB is a free and open source software suite for non-linear statistical
  modeling. It was created by David Fournier and now being developed by the
  ADMB Project, a creation of the non-profit ADMB Foundation. An extension of
  the language, ADMB-RE is available for modeling random effects.</p>
<h2><a name="acronym">What does ADMB stand for?</a></h2>
<p>"AD Model Builder", where the "AD" refers to the automatic
  differentiation capabilities that come from the AUTODIF Library, a C++
  language extension also created by <a class="external-link" href="http://admb-foundation.org/?page_id=19">David Fournier</a>, which implements reverse
  mode automatic differentiation.</p>
<h2><a name="auto-diff">What is automatic differentiation?</a></h2>
<p>Automatic differentiation (AD) is a method to evaluate the derivative of
  a function. Unlike, symbolic differentiation, AD can work on extremely
  complex problems. And AD methods are more precise than the approximations
  that come from numerical differentiation. These calculations are done behind
  the scenes, so the user needs only to provide the code to calculate an
  objective function to be minimized. One minor challenge of using AD methods
  is that care needs to be taken that the objective function to be minimized
  is differentiable with respect to the parameters. To meet this challenge,
  ADMB provides some the smoothed alternatives to functions like absolute
  value that can be used to keep things differentiable. For more details,
  see <a href="https://en.wikipedia.org/wiki/Automatic_differentiation">Automatic
    Differentiation on Wikipedia</a>.</p>
<h2><a name="advantages">What is the advantage of using ADMB?</a></h2>
<p>The main advantages are speed, accuracy, stability, and the ability
  to build large models. ADMB has been estimated to perform faster at solving
  complex optimization problems than the numerical programming languages
  GAUSS, MATLAB, S-PLUS, and R. In one example, ADMB solved a minimization
  problem with 100 parameters in 3 seconds, while the "nlminb" function in R
  took 93 minutes to achieve the same solution
  (see <a href="http://www.otter-rsch.com/tresults.htm">http://www.otter-rsch.com/tresults.htm</a> 
  for code of both models).</p>
<h2><a name="why-better">Why is AD Model builder better than using spreadsheet solvers or other statistical packages?</a></h2>
<p>The major problem in nonlinear statistical modeling is fitting the model to
  data. This involves nonlinear optimization. For the kinds of problems
  generally encountered in statistical modeling the best nonlinear
  optimization routines employ the derivatives of the function being
  maximized. Spreadsheet solvers and other statistical modeling packages use
  finite difference approximations for the derivatives of the function to be
  maximized in their solvers. This approach has two major limitations. The
  inaccuracy of the derivative approximations leads to instability in the
  solver. The result is that the solver becomes unreliable for ill-conditioned
  problems (naturally most real problems of interest are ill-conditioned).
  Also with finite difference approximations it takes at least <em>n</em> function
  evaluations to obtain the finite difference approximation for a function
  with <em>n</em> independent variables. As a result it is generally impossible
  to fit models with more than 20 or so parameters reliably with this
  approach. The automatic differentiation used by ADMB makes it possible to
  fit models with hundreds or even thousands of parameters in an efficient and
  reliable manner. In addition AD Model Builder produces a compiled executable
  which generally executes faster than the interpreters used by spreadsheets
  and other statistical packages.</p>
<h2><a name="overparameterization">But aren't models with hundreds or even thousands of parameters overparameterized?</a></h2>
<p>Well of course a model should only have as many parameters as it needs
  - no more but no less. One use of many parameters in statistical
  models is in the Bayesian equivalent of structural time-series models. In
  this approach parameters which would be assumed to be constant in the
  classical frequentist approach are allowed to vary slowly over time if there
  is evidence in the data being analyzed which supports such change. The
  advantage of the Bayesian approach over the structural time series approach
  is that the methods are exact even in the nonlinear case and it is simple to
  replace the usual assumption of normality with robust distributions.</p>
<h2><a name="obtaining">Where do I get it?</a></h2>
<p>From the <a href="/downloads/">downloads page</a>
  on this website.</p>
<h2><a name="OS">What operating systems are supported?</a></h2>
<p>ADMB is available for Windows, Mac OS X, Linux, and OpenSolaris. 64-bit
  versions for Windows are not yet complete, but all other systems have both
  32-bit and 64-bit versions available.</p>
<h2><a name="cost">What does it cost?</a></h2>
<p>Nothing.</p>
<h2><a name="learning">How can I learn how to use ADMB?</a></h2>
<p>The syntax of ADMB is based on C++, so any knowledge of C++ or similar
  languages will be useful. However it is not necessary to know any of the
  advanced object-oriented aspects of C++ programming such as classes,
  derived classes, function overloading etc. to use ADMB. A key requirement
  of ADMB compared to C++ is that parameters have to be declared in a special way
  that notifies the program that these are the quantities with respect to
  which the derivative of the objective function will be calculated.</p>
<p>The ADMB downloads include a collection of example files and more
  examples are available on
  the <a href="https://github.com/admb-project/examples">examples page</a> of this
  website. The documentation has numerous snippets of code that can be adapted
  to your needs.</p>
<p>If you use BUGS, there is an article about converting WinBUGS to ADMB in
  the <a href="http://admb-foundation.org/?page_id=39">June 2010 edition of
    the ADMB Foundation Newletter</a>.</p>
<h2><a name="restrictive">Isn't this sort of package too restrictive?</a></h2>
<p>ADMB employs an open architecture. It is possible to insert any
  legal C++ code into many parts of the template to customize the performance
  of your model. Also if desired you can always work directly with the C++
  source code which ADMB produces from your TPL file.</p>
<h2><a name="courses">Are there courses I can take?</a></h2>
<p>Yes, courses have been offered by various people with experience in ADMB.
  A list of previously offered courses and contact information for potential
  instructors is
  at <a href="/courses/">courses</a>.
  The University of Washington has also offered a course "Numerical Computing
  for the Natural Resources" taught by Andre Punt, which is focused on ADMB.
  Other Universities may offer courses as well (let us know so they can be
  added to this FAQ).</p>
<h2><a name="books">Are there any books on ADMB?</a></h2>
<p>Not yet.</p>
<h2><a name="learning">How can I learn more about ADMB?</a></h2>
<p>This website includes updates with news related to ADMB. All users should
  also consider joining
  the <a href="mailto:users@admb-project.org">users@admb-project.org</a> email
  list <a href="https://groups.google.com/a/admb-project.org/d/forum/users">
    (link to info)</a>.</p>
<h2><a name="who-uses">Who uses ADMB?</a></h2>
<p>A growing group of people in a variety of fields. The largest group of
  users are working in fisheries science, both because David Fournier, the
  creator of ADMB has worked in this field, and because fisheries models often
  have hundreds of parameters and would be intractable without ADMB. A list of worldwide institutions using ADMB is available <a href="/community/" class="external-link">here</a>. A list of
  publications that depend on ADMB is
  posted <a href="/community/bibliography/">here</a>.</p>
<h2><a name="creator">Who created ADMB?</a></h2>
<p>David Fournier created ADMB, ADMB-RE, and the AUTODIF Library in the
  1980s. More information on the history of ADMB is
  available <a href="/background.html">here</a>.</p>
<h2><a name="core-team">Who is currently developing ADMB?</a></h2>
<p>The ADMB core-team is currently about 20 people. They are listed in two places:<br/>
<a href="/developers/core-team">core-team</a><br/>
<a href="https://github.com/admb-project/admb/blob/master/src/nh99/model7.cpp">model7.cpp</a><br />
This list is displayed when a user runs 'mymodel -info'.</p>
<h2><a name="improving">Can I help improve ADMB?</a></h2>
<p>Yes. Please consider attending one of the <a href="/developers/workshops/" class="external-link">ADMB developers workshops</a> and joining the&nbsp;<a href="mailto:users@admb-project.org">users@admb-project.org</a>. You can also e-mail the developers core team:&nbsp;developers@admb-project.org.</p>
<h2><a name="financial-support">How is ADMB supported financially?</a></h2>
<p>The ADMB Project is currently supported by the ADMB Foundation, and a grant from NOAA Fisheries to the Joint Institute of Marine and Atmospheric Research. In the past it has received&nbsp;support from the National Center for Ecological
  Analysis and Synthesis, and the Pelagic Fisheries Research Program.</p>
<h2><a name="citations">How can I cite ADMB?</a></h2>
<p>Fournier, D.A., H.J. Skaug, J. Ancheta, J. Ianelli, A. Magnusson, 
  M.N. Maunder, A. Nielsen, and J. Sibert. 2012. AD Model Builder: 
  using automatic differentiation for statistical inference of highly 
  parameterized complex nonlinear models. Optim. Methods Softw. 27:233-249.</p>
<p>The paper is freely available through open access at 
  <a href="http://www.tandfonline.com/doi/abs/10.1080/10556788.2011.597854">
    http://www.tandfonline.com/doi/abs/10.1080/10556788.2011.597854</a>.</p>
<h2><a name="GUI">Is there a GUI for ADMB?</a></h2>
<p>There is a GUI that runs in R, through the PBSadmb package.</p>
<h2><a name="editors">What editors work with ADMB?</a></h2>
<p>An integrated development environment (ADMB-IDE) is available on
  the <a href="/downloads/">downloads page</a>. It is
  based on Emacs but configured to be easy to learn. Many other editors have
  been used by ADMB programs.
  See <a href="/tools/editors/">editing tools
    page</a> for comments on configuring various editors for ADMB
  programming.</p>
<h2><a name="software-interaction">How does ADMB interact with other software?</a></h2>
<p>The most common interaction between ADMB and other languages is through
  the text files input to and output from ADMB programs. Many users of ADMB
  use R to summarize or plot results of their ADMB models (a list of R
  packages associated with ADMB output is
  available <a href="/tools/r/">here</a>).
  There is a package glmmADMB for R that utilizes ADMB and some users have
  compiled ADMB models as DLLs to help it interact with other software.</p>
<hr />

<h1><a name="installation">Installation</a></h1>
<h2><a name="install">How do I install ADMB?</a></h2>
<p>Please see the <a href="/docs/install/">installation instructions</a>.</p>
<h2><a name="which-version">Which version is best for my computer?</a></h2>
<p>Obviously this depends on the type of computer you have. For Windows
  users, there are multiple compiler options. Among the three, the
  installer for GCC compiler is the only one for which the compiler is 
  included with the ADMB installer (because it is open source and can be 
  distributed in this way). For this reason, the Windows GCC installer 
  is the recommended choice. <a href="/developers/benchmarks/">Some
    benchmarks</a> have been completed to compare compilers, and more will
  likely be added in the future.</p>
<h2><a name="linux-packages">Is there a .rpm or .deb package for easy Linux installation?</a></h2>
<p>Not yet. Folks are attempting to put a Debian package together (see discussions 
  <a href="https://groups.google.com/d/topic/admb-developers/4uUbXzPua60/discussion">
    here</a> and 
  <a href="https://groups.google.com/d/topic/admb-developers/OmAjf0KWKy0/discussion">
    here</a>). And hopefully this will be available in the near future.</p>
<h2><a name="borland">Does ADMB work with Borland compilers?</a></h2>
<p>As of March 2012, the use of Borland compilers is no longer supported by the ADMB Project. Although Borland was a common compiler for ADMB in the past, the number of ADMB users working with Borland had declined and the effort that had been spent on maintaining compatibility was directed elsewhere. TPL files that worked under Borland should in general work with other compilers. Also see notes below under "<a href="#migrating-from-borland">How do I compile old Borland TPL’s in MinGW?</a>" for more information.</p>
<h2><a name="environment-variables">How do I set the PATH and other environment variables?</a></h2>
<p>In some cases the environment variables that point 
  to the ADMB files may not have been set correctly, e.g. when installing as a 
  non-administrator. In Windows this is indicated by an error message like</p>
<pre>'admb' is not recognized as an internal or external command,
operable program or batch file.</pre>
<p> Discussion of this point, with instructions for setting 
  Environment Variables, are in the email archives,
  <a href="https://groups.google.com/d/topic/admb-users/BeDlgA0cs2s/discussion">here</a>, 
  <a href="https://groups.google.com/d/topic/admb-users/WQHFLAzy4C0/discussion">here</a>, and <a class="external-link" href="https://groups.google.com/d/topic/admb-users/KSKd6uapxhc/discussion">here</a>.</p>
<p>The key is to make sure that the PATH environment variable includes the 
  directory where the ADMB files are located. In DOS, if you type "echo %PATH%", 
  you should see the folder with ADMB files. If you don't, follow the links above 
  for suggestions on how to set those variables.</p>
<h2><a name="install-fail">Why did my installation of ADMB fail?</a></h2>
<p>Installation of ADMB is getting easier and easier, but problems may still
  crop up. If you don't have an ADMB user nearby to consult, write
  to <a href="mailto:users@admb-project.org">users@admb-project.org</a>,
  providing details of your computer, what version of ADMB you downloaded, and
  a description of the problem.</p>
<h2><a name="source">Is the ADMB source code available?</a></h2>
<p>Yes. You can download all source files for the latest release of ADMB from 
  <a href="/downloads/">downloads</a>. 
  Or you can check out the latest development version of the source code using 
  the information
  <a href="/2011/04/11/services.html">
    here</a>. To learn about keeping synchronized with the development code, you may
  want to read about <a href="http://subversion.apache.org/">Subversion (SVN)</a>.</p>
<h2><a name="build">Can I build ADMB directly from the source code?</a></h2>
<p>Yes. There are instructions in the README file included with the source code. 
  It has been <a href="https://groups.google.com/d/topic/admb-users/DTnWU7mW3Ak/discussion">
    suggested</a> (at least for those familiar with the compiling process) that 
  "if you experience a strange crash recompile and get a coffee before you waste time
  thinking about it." Obviously the determination of what constitutes "strange" 
  may be somewhat subjective.</p>
<h2><a name="conflicts">How can I avoid conflicts between C++ compilers?</a></h2>
<p>The precompiled "Windows and GCC" version of ADMB comes with the C++ compiler 
  included. This has the potential to conflict with the compilers included with 
  other programs, such as <a href="http://cran.r-project.org/bin/windows/Rtools/">Rtools</a>.
  Some ideas for avoiding such conflicts are discussed in an email 
  <a href="https://groups.google.com/d/topic/admb-developers/2hEMzi3I1u0/discussion">
    here</a>.</p>
<hr />


<h1><a name="usage">Usage</a></h1>
<h2><a name="files">What are all the files produced by running an ADMB executable?</a></h2>
<p>Most files contain results of the model in either ASCII or binary format.
  Some are temporary files created in the process of running the model and can
  be ignored. The most commonly used output files are</p>
<ul>
  <li>Parameter Estimate file (.par),</li>
  <li>Standard Deviation file (.std),</li>
  <li>Correlation Matrix file (.cor), and</li>
  <li>User-Defined Output file (.rep).</li></ul>
<p>A good source of more information on all the files
  is <a href="/developers/workshops/la-jolla-2010/ADMBGettingStartedGuide.pdf#page=45" class="internal-link" title="ADMB Getting Started Guide (draft)">Chapter
    6 of the draft ADMB Getting Started Guide</a>.</p>
<h2><a name="memory">How do I control memory use in ADMB?</a></h2>
<p>ADMB has inputs to allocate memory for different types of calculations. These are controlled 
  either via lines in the TPL file such as</p>
<pre>  arrmblsize = 200000; // use instead of gradient_structure::set_ARRAY_MEMBLOCK_SIZE
  gradient_structure::set_GRADSTACK_BUFFER_SIZE(100000000);
  gradient_structure::set_CMPDIF_BUFFER_SIZE(50000000);</pre>
Or via command line inputs such as
<pre>    mymodel.exe -ams 200000 -gbs 100000000 -cbs 50000000</pre>
The numbers are in bytes except for the GRADSTACK_BUFFER_SIZE, which is in chuncks of about 36 bytes depending on the context
(a quirk that can be avoided by using the new set_GRADSTACK_BUFFER_BYTES instead). See Section 1.28 
"The TOP OF MAIN section" and Chapter 12 "Command line options" in the 
<a href="/docs/manuals/">ADMB User Manual</a> for more
information. 

There are a few things to watch out for:
<ul>
  <li>Don't try to input any values greater than 2^31 - 1 = 2147483647</li>
  <li>Don't use scientific notation when using command line options</li>
  <li>Watch out for large temporary files associated with insufficient memory use</li></ul>
There is more detailed information on this topic within this website
<a href="/developers/benchmarks/">here</a>, and 
<a href="/users/tutorials-and-examples/memory-management">here</a>.

And many discussions in the <a href="https://groups.google.com/d/forum/admb-users">archives of the ADMB Users email list</a>.
<p>&nbsp;</p>
<h2><a name="hessian">What is the Hessian?</a></h2>
<p>It is a matrix of second-order partial derivatives of the objective
  function defined in your model, which in ADMB is calculated at the
  parameter values which have minimized this function. This represents the
  curvature of the likelihood surface and is used to calculate estimates of
  uncertainty for all the estimated model parameters and chosen derived
  quantities.</p>
<h2><a name="positive-definite">Why does it sometimes say "Hessian does not appear to be positive definite"?</a></h2>
<p>This generally happens if a minimum has not been found. The are various
  possible causes. Probably the most common is that the model has been written
  incorrectly so the objective function is not differentiable with respect to
  all the parameters. Another common cause is parameters hitting bounds. 
  Non-positive-definite Hessians can also occur if the data are too perfect 
  (see discussion 
  <a href="https://groups.google.com/d/topic/admb-users/74AA16IWQNk/discussion">here</a>).</p>
<h2><a name="debugging">Are there tips on debugging code that doesn't seem to be working right?</a></h2>
<p>An example of the debugging process applied by Dave Fournier (for a model 
  with the error "Function minimizer not making progress") is described 
  <a href="https://groups.google.com/d/topic/admb-users/OmBngvxRIzE/discussion">
    here</a>.</p>
<h2><a name="migrating-from-borland">How do I compile old Borland TPL’s in MinGW?</a></h2>
<p>Now that Borland is no longer supported by ADMB, users will need to ensure that their programs work with other compilers. In many cases there will be no issues. However, header files (include statements I put in the GLOBALS_SECTION) may be compiler specific. Here's a suggestion from Mark Fowler based on his experience making the switch:</p>
<p>First step. Simply remove the ‘.h’ extensions of the Borland includes. MinGW has many equivalents for Borland includes that differ only in the extension (e.g. iostream, fstream, iomanip, string).</p>
<p>Second step. Identify remaining ‘source’ includes (just those in your TPL, not those of the includes themselves) that still balk the MinGW compiler. Disable all those that still produce an error. Now the compiler will only choke on absent commands that derive from disabled includes. Some of my TPLs simply compiled at this step, as I had been carrying over spurious includes across programs, so there were no commands in the TPL associated with them. For those that still trip the compiler do a web search on “[header_file] Borland MinGW” to find the right include to substitute, or a go-around. Most of these seemed to derive from user groups focused on web programming.</p>
<h2><a name="how-to-run-mcmc">What is necessary to run MCMC?</a></h2>
<p>MCMC is easy to implement in ADMB using the -mcmc N -mcsave N2
  commands when running a model to run a chain of length N and save
  the output every N2 steps. To get output of parameter values that
  have been saved, you need to either read the binary .psv file 
  (i.e. using the readBin function in R--see 
  <a href="/courses/previous/admb-workshop-at-international-statistical-ecology-conference-2010-5-july-2010/uncertainty.pdf">example code</a>), 
  or include in the code some commands to
  write to a file which are conditioned on the
  statement if(mceval_phase()) and then run the model again using the -mceval command. Finally, it is necessary to have at
  least one derived quantity designated as an sdreport variable in
  your model. For more on MCMC, see chapter 2 of
  the <a href="/docs/manuals/">ADMB User
    Manual</a></p>
<h2><a name="mcmc-implementation">How is MCMC implemented in ADMB?</a></h2>
<p>AD Model Builder uses the hessian to produce an (almost) multivariate
  normal distribution for the Metropolis-Hastings algorithm. It is not
  exactly multivariate normal because the random vectors produced are
  modified to satisfy any bounds on the parameters. See the user manual for
  various modifications to the MCMC that are available, such as to deal with
  highly correlated parameters. Hybrid Monte Carlo sampling can also be used
  through the -hybrid command, but thorough benchmarks have not
  been conducted for this method.</p>
<h2><a name="splines">Can I do interpolation?</a></h2>
<p>Cubic splines are available in ADMB, but haven't yet been documented. 
  Some example code is on this website <a href="/users/tutorials-and-examples/splines/">here</a> and in <a href="https://groups.google.com/d/topic/admb-users/5roZavNHjcA/discussion">this email</a>. <a href="http://buildbot.admb-project.org/api/group__cub__spline.html">Here</a> is another useful source of information.</p>
<h2><a name="parallel">Can ADMB do parallel processing?</a></h2>
<p>Parallel processing capabilities are currently in development. To see a 
  description of current capabilities, see 
  <a href="">
    "Open MPI Presentation"</a> and 
  <a href="/developers/workshops/honolulu-2012/openmpi.pdf">"
    Parallelization in ADMB"</a> in the folder 
  <a href="/developers/workshops/honolulu-2012/">
    commmunity/admb-developers-workshop-march-13-16-2012</a>.</p>
<h2><a name="dll">Can ADMB produce DLLs (dynamic-link libraries)?</a></h2>
<p><em>Note: this information is from 
    <a href="https://groups.google.com/d/topic/admb-users/zlQVyAFJ28U/discussion">
      an email by Arni Magnusson</a> sent to the ADMB-Users email list.</em></p>
<p>At this time (January 2011) the DLL compilation is broken on most platforms 
  - but probably not all.</p>
<p>Many years ago, Dave Fournier implemented fully working DLL compilation on all 
  ADMB platforms (e.g. ADMB 5.0 in 2000). My understanding is that Dave did not 
  continue to maintain this feature, because it took a lot of effort and it 
  looked like few or no users were compiling ADMB DLLs.</p>
<p>When I wrote the adcomp/adlink/admb scripts in 2009, I decided to provide 
  the -d option, knowing that the feature was at least half-broken. The idea is 
  to highlight a feature that can probably be resurrected - and of course to 
  provide DLL compilation on the few platforms where it still works.</p>
<p>The development team has only allocated limited efforts to examine the 
  issue of DLL compilation, but encourages interested users to do so. Several 
  discussions can be found 
  <a href="https://groups.google.com/a/admb-project.org/d/forum/users">
    here</a>.</p>

<a name="ADMB-IDE"/>
ADMB-IDE
--------

<h2><a name="what-is-ADMB-IDE">What is ADMB-IDE?</a></h2>
<p>An <a href="https://en.wikipedia.org/wiki/Integrated_development_environment">Integrated
    Developement Environment</a> which augments a text editor with a variety of
  tools for compiling, running, and debugging ADMB models.
  See <a href="/tools/admb-ide/manual.pdf">the
    ADMB-IDE manual</a> for details, including screenshots.</p>
    
**<a name="ADMB-IDE-platforms">Is ADMB-IDE available for Mac or Linux as well as Windows?</a>**
<p>Yes, although there is no installer, so the user has to do a little
  setup.
  See <a href="/tools/admb-ide/manual.pdf#page=6">Section
    1.3 of the ADMB-IDE user manual</a> for details.</p>
<h2><a name="ADMB-IDE-uses">Can I use ADMB-IDE for compiling C++?</a></h2>
<p>Definitely. To see some suggestions on configuring the ADMB-IDE to make
  this easier,
  see <a href="https://groups.google.com/d/topic/admb-users/dx2WwoL6M-k/discussion">this
    discussion</a> on the ADMB-users email list.</p>

<!-- End of FAQ -->
    <!-- ====================================================================
    copyright, disclaimers, and whatnot should go down here if required

    ==================================================================== -->
