---
layout: default
title: ADMB Installation Visual C++
---
                <h1 id="parent-fieldname-title" class="documentFirstHeading">
                    ADMB Installation Visual C++
                </h1>
            
                <div id="parent-fieldname-description" class="documentDescription">
                   Shows the procedure to install, build and run ADMB with Visual C++.
                </div>
            
<p><em>If you have problems with installation, please write to&nbsp;users@admb-project.org with information about your operating system, Microsoft .NET framework version, Microsoft SDK version, Microsoft Visual Studio version, the version of ADMB you're trying to install, and what error messages or other problems you had.</em></p>
<h3>Introduction</h3>
<p>Microsoft Visual Studio 2010 express includes a free compiler (CL.exe).&nbsp; This compiler can be used to build ADMB programs.&nbsp; Below shows the procedure to install and configure ADMB with Visual Studio 2010 Express for both 32-bit and 64-bit versions.&nbsp; This method allows you to use admb from any DOS window or in a compile command inside an editor or Integrated Development Environment (IDE).&nbsp; Using a Visual Studio command prompt is unnecessary.</p>
<p><em><strong>The free version of Visual Studio 2010 does not include the 64-bit compiler, but the SDK does.&nbsp; Following this method ensures both the 32-bit and 64-bit VC++ compilers are installed for free.</strong></em></p>
<h3>Procedure</h3>
<ol type="1" start="1"><li>Download and install the following three software packages from Microsoft, and install them in the order listed.&nbsp; <strong>If Visual Studio is installed prior to installing the Windows SDK, the installation of the Windows SDK may fail with a code of 5100 in the logfile.&nbsp; If this happens, uninstall ALL Visual studio products and re-run the SDK installer.&nbsp; </strong>Popups should be enabled for these sites, or use Internet Explorer to download if you have trouble with other browsers:</li>
<ol type="A"><li>Microsoft .NET 4 Framework:<br /><a class="external-link" href="http://www.microsoft.com/download/en/details.aspx?id=17851">http://www.microsoft.com/download/en/details.aspx?id=17851</a><br /></li><li>Microsoft Windows SDK 7.1:<br /><a class="external-link" href="http://www.microsoft.com/download/en/details.aspx?id=8279">http://www.microsoft.com/download/en/details.aspx?id=8279</a><br /></li><li>Microsoft Visual Studio 2010 Express:<br /><a class="external-link" href="http://www.microsoft.com/visualstudio/en-us/products/2010-editions/visual-cpp-express">http://www.microsoft.com/visualstudio/eng/products/visual-studio-express-products</a><br /></li></ol>
<li>Download the most recent executable installer from the downloads page (<a href="/downloads/" class="internal-link" title="ADMB Downloads">ADMB Downloads</a>), <a class="external-link" href="http://admb-project.googlecode.com/files/admb-11.1-windows-vc10-64bit.exe">http://admb-project.googlecode.com/files/admb-11.1-windows-vc10-64bit.exe</a> and run it.&nbsp; Make sure to choose the install location as C:\ADMB or another location without spaces in the name.<br /></li><li>Add the following to the PATH in the order given. If you are using a 32-bit machine, enter only the first, third, fourth, and fifth path listed in that order.&nbsp; If you are using a 64-bit machine, enter all five paths in the order listed.&nbsp; If you are compiling for a 64-bit machine, the second path listed here must reflect which architecture you want to compile for, this example is for Intel 64-bit processors - for most people this should not be changed.&nbsp; Also, if you are on a 32-bit machine, remove the ' (x86)' from these paths.<br />
<ol><li>C:\Program Files\Microsoft SDKs\Windows\v7.1</li><li>C:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\bin\amd64</li><li>C:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\bin</li><li>C:\Program Files (x86)\Microsoft Visual Studio 10.0\Common7\IDE</li><li>C:\ADMB\bin</li></ol>
</li><li>&nbsp;Add the following environment variables:<br />
<ul><li>&nbsp;&nbsp; ADMB_HOME = C:\ADMB</li></ul>
<ul><li>&nbsp;&nbsp; INCLUDE = C:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\include;C:\Program Files\Microsoft SDKs\Windows\v7.1\Include<br /><br />For the LIB variable, choose either 32-bit or 64-bit.<br />32-bit LIB:<br /></li></ul>
<ul><li>&nbsp;&nbsp; LIB = C:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\lib;C:\Program Files\Microsoft SDKs\Windows\v7.1\Lib<br /><br />64-bit LIB:</li><li>&nbsp;&nbsp; LIB = C:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\lib\amd64;C:\Program Files\Microsoft SDKs\Windows\v7.1\Lib\x64<br />
<br /></li></ul>
</li><li>Logout and login again to make the environment variables take effect.<br />
</li><li>&nbsp;You may now open any command shell (DOS window) or call admb from within an editor window using whatever compile command you would like. Try this using the "Simple" example.&nbsp; Open a command window,&nbsp; by clicking Start-&gt;Run then typing cmd.exe and enter the following commands in the window:<br />&gt; C:<br />&gt; cd ADMB\examples\admb\simple<br />&gt; admb simple<br />&gt; simple<br /></li></ol>
<h3>Notes</h3>
<p>To edit the PATH in Microsoft Windows 7, click Start then right-click on "Computer" and click "Properties".&nbsp; Click "Advanced system settings" on the left, then a new window will appear.&nbsp; Click the "Advanced" tab on this window, then the "Environment Variables" button at the bottom.&nbsp; The PATH is located in the "System Variables" list.&nbsp; Step 3 above requires you to add these paths to the PATH.&nbsp; Highlight the PATH variable and click "Edit".&nbsp; Add the paths, with each separated by a single semicolon (;).&nbsp; No spaces are permitted in the PATH variable.&nbsp; <em><strong>It is important that you do not erase what is in the PATH variable but only add to it, if you do many of your installed programs will fail to run.</strong></em>&nbsp; If you have previous versions of Visual Studio or Microsoft Windows SDK with entries on the PATH before these new additions, ADMB may fail to run properly.&nbsp; You must remove those paths from the PATH variable.</p>
<h3>Alternative C++ configurations</h3>
<p>Configuring ADMB with alternative C++ versions, some are outdated but still provided in case they are useful to users.</p>
<p><a href="config-vc6-marc.html" class="internal-link" title="Configuring MS Visual C++ 6.0 with ADMB (Marc)">Configuring MS Visual C++ 6.0 with ADMB (Marc Labelle)</a></p>
<p><a href="ADMB_VC.pdf" class="internal-link" title="ADMB_VC.pdf">Configuring MS Visual C++ 6.0 with ADMB (Melissa Haltuch)</a></p>
<p><a href="SettingUpADMB_Win32bitAND64bit.pdf" class="internal-link" title="SettingUpADMB_Win32bitAND64bit.pdf">Configuring MS Visual C++ 2010 (32 and 64 bit) with ADMB (Allan Hicks, Ian Taylor)</a></p>
<h3>Problems</h3>
<p>Please email <a href="mailto:users@admb-project.org">users@admb-project.org</a> for any problems with the procedure above.</p>

