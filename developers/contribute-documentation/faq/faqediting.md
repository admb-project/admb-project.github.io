---
layout: default
title: Editing the ADMB FAQ
---

Editing the ADMB FAQ
==========

A key feature of the the [Frequently Asked Questions page](/docs/faq/) is the table of contents (TOC) and a series of hidden "anchors" throughout the text that the TOC links to. This both allows the reader to quickly find an answer they're looking for and also allows a direct link to any question to be copied into an email in a brief form, like http://admb-project.org/documentation/faq#positive-definite.

In order to ensure that the TOC is complete and the links work properly, the TOC is generated from the questions themselves using the R function [toc4faq.R](/developers/contribute-documentation/faq/toc4faq.R). For this to work properly, the HTML associated with each question needs to strictly follow a simple format. This should be something like

```
<h2><a name="positive-definite">Why does it sometimes say "Hessian does not appear to be positive definite"?</a></h2>
```

where the name="*" element defines the anchor which is used in the link and therefore should be a brief and unique phrase. The R function can then be used to generate the TOC and augment the file. You can also add new entries in the TOC by hand, recognizing that the next time the R function is run it will replace everything outside the <!-- Start of FAQ --> and <!-- End of FAQ --> comments.

If this seems like a pain, just send your suggested changes at Ian.Taylor@noaa.gov and I'll do the work for you.
