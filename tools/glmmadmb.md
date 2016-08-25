---
layout: default
title: glmmADMB
---

<h2>glmmADMB</h2>

<p>The <code>glmmADMB</code> package, built on the open-source <a href="http://admb-project.org">AD Model Builder</a>
platform, is an <a href="http://www.r-project.org">R</a> package for fitting generalized linear mixed models (GLMMs).

<p>Its capabilities include:

<ul>
  <li>a wide range of families (response distributions), including non-exponential families such as negative binomial
    (type 1 and 2), Beta, logistic, and truncated Poisson and negative binomial distributions as well as the standard
    exponential families (binomial, Poisson, Gamma, Gaussian).
  <li>a wide range of link functions: log, logit, probit, complementary log-log, identity, inverse.
  <li>Zero-inflation (currently only as a single constant term across all groups)
  <li>Single or multiple random effects, including both nested and crossed effects
  <li>Markov chain Monte Carlo (MCMC) summaries of uncertainty
</ul>

<p>In order to use glmmADMB effectively you should already be reasonably familiar with GLMMs, which in turn requires
familiarity with (i) generalized linear models (e.g. the special cases of logistic, binomial, and Poisson regression)
and (ii) 'modern' mixed models (those working via maximization of the marginal likelihood rather than by manipulating
sums of squares).

<p>Please visit the following webpages for more information about the <tt>glmmADMB</tt> package (<em>please note the
latter is somewhat out of date, although it may still contain useful information</em>):

<ul>
  <li><a href="http://r-forge.r-project.org/projects/glmmadmb/">R-Forge</a> (current development)
  <li><a href="http://admb-project.org/examples/r-stuff/glmmadmb">ADMB Project</a> (recent homepage)
</ul>

<h2>Installation</h2>

Your best bet is 
<pre>
install.packages("R2admb")
install.packages("glmmADMB", 
    repos=c("http://glmmadmb.r-forge.r-project.org/repos",
            getOption("repos")),
    type="source")
</pre>

<hr>
If you have trouble with the binary provided with your version of
glmmADMB, here are the instructions for replacing it with a newer/different
version:
<ol>
<li>look at the output of <code>glmmADMB:::get_bin_loc()</code> 
to determine where R will look for the compiled code for glmmADMB.</li>
<li>Go to the <a href="http://www.admb-project.org/buildbot/glmmadmb/">Buildbot page</a> and retrieve a binary that is compatible with your OS.  In general, the file name format is something like <code>glmmadmb-r[version]-[OS]-[compiler]-[nbit]bit.(bin|exe)</code>, although the file names do change from time to time. In general you want to look for the highest numbered version compatible with your system (go to the bottom of the list and scroll up, except that the Windows versions are named differently and ended up at the top of the list).  For example, as of today (7 Oct 2015) I would choose from among the following:
<pre>
glmmadmb-mingw64-r2928-windows8-mingw32.exe
glmmadmb-mingw64-r2928-windows8-mingw64.exe
glmmadmb-r2924-macos10-xcode7-32bit.bin
glmmadmb-r2924-macos10-xcode7-64bit.bin
glmmadmb-r2928-ubuntu14-64bit.bin
glmmadmb-r2928-fedora22-gcc5.1-32bit.bin
glmmadmb-r2928-fedora22-gcc5.1-64bit.bin
</pre>
(it looks like you may be stuck if you want to run on 32-bit Ubuntu).
Once you've found the binary you want, copy it to the location you determined in step #1 (you might want to make a backup of the old version).
</li>
<li>Try your code again and see if that helped.</li>
<li>If you can't find an appropriate binary on the system, you may have to buildthe  <code>glmmadmb</code> binary from its TPL (<code>system.file("tpl","glmmadmb.tpl",package="glmmADMB")</code>) on your system (or find someone with a compatible system who can do it for you) and copy it to the appropriate location.</li>
</ol>
<hr>
The binaries included in the <code>glmmADMB</code> will <strong>not</strong> run on MacOS 10.5 (Leopard) or earlier, and may have trouble with very old versions of Linux as well. If you encounter this problem, your choices are:
<ul>
  <li>Upgrade your system to a more recent version of MacOS (if possible).
  <li>Build <code>glmmadmb</code> from its TPL file on your machine.  This will be a bit tricky if you are not
        reasonably experienced.
    <ul>
      <li>Download the full AD Model Builder  source code from the <a href="http://admb-project.org/downloads/">AD
          Model Builder download page</a> and follow the
        <a href="http://admb-project.org/documentation/faq#build">directions</a> for building AD Model Builder from
        source; you may need to install Xcode, and you may need to ask for help at
        <code>users@admb-project.org</code>. (Googling "admb macos 10.5" will be helpful as well, although it's
        possible that you will need the most recent version of the ADMB source code to compile
        <code>glmmadmb.tpl</code> properly ...)
      <li>find the <code>glmmadmb.tpl</code> file in the <code>glmmADMB</code> package directories and use ADMB to
        compile it to a binary
      <li>copy the resulting binary to the <code>bin/macos32</code> or <code>bin/macos64</code> directory as
        appropriate.
    </ul>
  <li>Contact the maintainers to appeal for help and find out if there any new developments in support for MacOS
    versions less than 10.6.
  <li>A similar process may work for other unsupported operating systems such as Solaris, but in that case it's also
    probably a good idea to contact the maintainers.
</ul>
</ol>

<h2>Additional documentation</h2>

<ul>
  <li>Current (fairly minimal) documentation/example for ADMB in <a href="glmmADMB.html">HTML</a> and
    <a href="glmmADMB.pdf">PDF</a> format. This is also accessible from within R (once <code>glmmADMB</code> is
    installed) via <code>vignette("glmmADMB",package="glmmADMB")</code>.
  <li>The <a href="http://glmm.wikidot.com/faq">GLMM FAQ</a> page gives general advice about GLMMs, although its content
    is slightly more oriented toward the <code>lme4</code> package.
  <li>We recommend the R mixed models list at <code>r-sig-mixed-models@r-project.org</code> for <code>glmmADMB</code>
    questions, although if you feel that your question is more AD Model Builder-oriented than R-oriented you may also
    want to try the AD Model Builder user's list.
</ul>

<h2>Newer versions</h2>

<p>Newer versions of <tt>glmmADMB</tt> (>0.6.4) have the following major changes:

<ul>
  <li>new formula format, similar to that of the <tt>lme4</tt> package, where random and fixed effects are specified as
    part of a single formula (<tt>random</tt> can also be specified separately, as in <tt>lme</tt>).
  <li>multiple grouping variables (random effects) are allowed.
  <li>wider range of distributions and link functions supported (e.g. binomial with <em>N</em>&gt; 1).
</ul>

<p>The new release is somewhat slower (for the time being) than older (pre-0.5.2) versions: if you have a desperate need
for a copy of an old version, you can
<a href="http://www.math.mcmaster.ca/bolker/R/src/contrib/glmmADMB_0.5.2.tar.gz">download a source version</a> and
follow alternative #3 from the installation instructions above.
