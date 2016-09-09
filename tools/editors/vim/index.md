---
layout: default
title: Vim Usage
---

Vim Usage
---------

Where to get Vim and how to setup syntax highlighting
Vim is available for many different systems and there are several versions and can be freely [downloaded](http://www.vim.org/download.php).

To activate syntax highlighting under linux, copy [filetype.vim](filetype.vim) into the .vim directory in your home directory, and copy [tpl.vim](tpl.vim) in the syntax subdirectory of the .vim directory. That is,

```
$ ls -R .vim
.vim:
filetype.vim  syntax/
.vim/syntax:
tpl.vim
```

There must be a way to activate highlighting under Windoze, but I can't figure it out.

The syntax highlighting is an extenstion of default Vim C++ highlighting and is generated from the ADMB flex input files. Template sections are highlighted as C++ keywords and ADMB template types are highlighted as C++ types.
