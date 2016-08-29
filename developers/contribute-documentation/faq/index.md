---
layout: default
title: FAQediting
---

FAQediting
==========

Note on Editing the FAQ

A key feature of the the Frequently Asked Questions page is the table of contents (TOC) and a series of hidden "anchors" throughout the text that the TOC links to. This both allows the reader to quickly find an answer they're looking for and also allows a direct link to a any question to be copied into an email in a brief form, like http://admb-project.org/documentation/faq#positive-definite.

In order to ensure that the TOC is complete and the links work properly, it is generated from the questions themselves using the R function toc4faq.R. For this to work properly, the HTML associated with each question needs to strictly follow a simple format.

For those of you with editing privileges for the FAQ page, if you feel like adding a question, please click the HTML button on the right hand side of the Plone Toolbar that appears when editing the body of the page. Then within Plone or after copying into a text editor, try to make the format of any new questions match the existing questions. This should be something like

```
<h2><a name="positive-definite">Why does it sometimes say "Hessian does not appear to be positive definite"?</a></h2>
```

where the name="*" element defines the anchor which is used in the link and therefore should be a brief and unique phrase. You're then welcome to either run the R function to generate the TOC and then paste the augmented file back into Plone, or attempt to add your new question to the TOC by hand, recognizing that the next time the R function is run it will replace everything outside the <!-- Start of FAQ --> and <!-- End of FAQ --> comments.

If this seems like a pain, just send me your suggested changes at Ian.Taylor@noaa.gov and I'll do the work for you.
