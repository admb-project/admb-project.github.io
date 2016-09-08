---
layout: default
title: Install
---

Install
-------

How to install Emacs & admb-mode
Emacs is a powerful and complex editor, providing >1000 editing functions that can be bound to any keystrokes. Users can write their own functions in a feature-rich programming language called Emacs Lisp. Provides standard tools like syntax highlighting, automatic indentation, and code navigation for all major programming languages. Particularly good support for R, LaTeX, and backup/revision control.

1. **Install Emacs**

	1.1. **Linux**

	Open a shell and type

```
	emacs &
```

	Depending on your distribution, you need to do one of the following:

	Nothing, since Emacs is already installed and will open.
	Type the command suggested by the shell, to install GNU Emacs from within the shell.
	Open the package manager, select and install GNU Emacs.

	1.2. **Windows**

Download
Open a web browser and visit

```
ftp://ftp.gnu.org/pub/gnu/emacs/windows/
```

Select and download the newest emacs-*-bin-i386.zip. Currently, the newest version is

```
ftp://ftp.gnu.org/pub/gnu/emacs/windows/emacs-22.3-bin-i386.zip
```

If the download is slow, select a mirror that's geographically close to you:

```
http://www.gnu.org/prep/ftp.html
```

Navigate to emacs/windows and download the newest version.

Unzip
Unzip and move the folder to the desired location. I recommend c:/gnu and renaming the folder so that the main program is at

c:/gnu/emacs/bin/runemacs.exe
Congratulations, you have successfully "installed" Emacs!

To make it easier to start Emacs, you probably want to create a shortcut icon to runemacs.exe on the desktop and/or start menu. Right-click the icon and define a shortcut key, e.g. Ctrl-Shift-m. The Emacs philosophy is to bind shortcut keys to all common actions. Also consider adding c:/gnu/emacs/bin to your PATH variable:

```
set PATH=%PATH%;c:/gnu/emacs/bin
```

Set this variable properly using c:/autoexec.bat or right-click My Computer - Properties - Advanced - Environment Variables.

To "uninstall" Emacs, simply delete the main folder, and undo any changes you made to your PATH variable. To "upgrade" Emacs, delete the main folder and replace it with a newer one.

2. Configure Emacs
2.1 Create .emacs
Your personal Emacs settings are stored in a file called ".emacs". The best place to store .emacs is in your "home" folder.

Linux
Open a shell and type

```
touch ~/.emacs
```

Windows
 To make things look similar in Windows and Linux, I recommend creating a folder called ~:

```
c:/~
```

To notify Emacs and other programs that this is your special "home" folder, you need to declare HOME:

```
set HOME=c:/~
```

Set this variable properly using c:/autoexec.bat or right-click My Computer - Properties - Advanced - Environment Variables.

Create an empty text file inside your home folder called ".emacs". Alas, Windows Explorer is not comfortable creating a file with this name, but it can be created using the Dos shell or a text editor, such as Emacs:

```
runemacs ~/.emacs
```

Insert one space and then type Ctrl-x Ctrl-s to save the file.

2.2 Edit .emacs
The .emacs file is written in a language called Emacs Lisp.

Here's an example:

```
;;==============================================================================
;;
;; 1  INTERFACE
;;
;;==============================================================================
;;-------------
;; 1.1  Visual
;;-------------
(setq frame-title-format "%b"                   ) ; window title
(setq inhibit-splash-screen t                   ) ; blank buffer
(setq initial-scratch-message nil               ) ; blank buffer, really
(setq inhibit-startup-echo-area-message "arnima") ; blank minibuffer
;;--------------
;; 1.2  Editing
;;--------------
(defalias 'yes-or-no-p 'y-or-n-p) ; ask y or n
(pc-selection-mode t)(message nil) ; shift select and f6
;;------------
;; 1.3  Faces
;;------------
(set-face-attribute 'font-lock-string-face nil :foreground "forestgreen")
;;==============================================================================
;;
;; 2  KEYBINDINGS
;;
;;==============================================================================
;;-----------------
;; 2.1  One stroke
;;-----------------
(global-set-key [M-f4]  'save-buffers-kill-emacs)
(global-set-key [?\C-k] 'kill-line-or-region    )
(global-set-key [?\C-z] 'undo                   )
(global-set-key [?\M-a] 'mark-whole-buffer      )
(global-set-key [?\M-c] 'copy-region-as-kill    )
(global-set-key [?\M-r] 'R                      )
(global-set-key [?\M-v] 'yank                   )
;;==============================================================================
;;
;; 3  FUNCTIONS
;;
;;==============================================================================
;;-----------
;; 3.1  Edit
;;-----------
(defun kill-line-or-region ()
   "Kill region if selected, otherwise kill line." (interactive)
   (if (and mark-active transient-mark-mode)
       (kill-region (point)(mark))(kill-line)))
```
I recommend defining single-stroke keybindings to global commands you use often (but leave Ctrl-x and Ctrl-c unchanged, because they're special), and two-stroke keybindings of the form Ctrl-c Ctrl-char for mode-specific commands. I also recommend redefining the background and text colors to something that provides comfort and contrast for the eyes. Emacs is powerful stuff, but the default keybindings and colors are in many cases silly.

See the [Configure](config.html) notes for more details on Emacs configuration.

3. Install admb-mode
Open a web browser and download

http://admb-project.org/community/editing-tools/emacs/admb.el

Move the file to a folder called 'admb'. The full path of the file could be

```
~/emacs/lisp/admb/admb.el
```

in Linux, or

```
c:/~/emacs/lisp/admb/admb.el
```

in Windows.

Finally, open admb.el and read the documentation within the file to finish installing and configuring admb-mode.
