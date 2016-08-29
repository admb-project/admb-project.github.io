---
layout: default
title: ADMB Release Procedure
---

ADMB Release Procedure
======================

Annual Release
--------------

As a general rule, a new version of ADMB is released annually, 1-3 months after the annual Developers' Workshop. The following procedure starts a few weeks after a workshop.

1. Notify developers@admb-project.org.
2. Select issues to target for release.
3. Once issues are completed, notify foundation members which trunk revision will be the new release.
4. Copy trunk revision to branches/'release-number' where 'release-number' is the format Major.Minor (e.g. 10.1).
5. Update release date, version, copyright in the source files, README.txt, and installers.  Also, update the acknowledgements section.
6. Make sure manuals are up to date, easy to follow, and that end users are able to follow the procedure successfully.
7. Request testing from the core developers group.
8. Release test (beta) distributions to the users community.
9. If no major issues, tag the branch as the release.
10. Upload buildbot generated distributions and installers to code.google.com. 
11. Email announce@admb-project.org of the new release.
12. Add new item and update downloads page.

Other Releases
--------------

In addition to the main annual release, minor versions may be released to address specific needs.  Minor releases will include
bug fixes and document corrections.
 
