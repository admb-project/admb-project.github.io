;;; admb.el --- major mode for creating statistical models with AD Model Builder

;; Copyright (C) 2003, 2007, 2008, 2009, 2010, 2011, 2012 Arni Magnusson

;; Author:   Arni Magnusson
;; Version:  6.7
;; Keywords: languages
;; URL:      http://admb-project.org/community/editing-tools/emacs/admb.el

(defconst admb-mode-version "6.7" "ADMB Mode version number.")

;; This admb.el file is provided under the general terms of the Simplified BSD License.
;; Redistribution and use in source and binary forms, with or without modification, are permitted provided that the
;; following conditions are met:
;; 1 Redistributions of source code must retain the above copyright notice, this list of conditions and the following
;;   disclaimer.
;; 2 Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following
;;   disclaimer in the documentation and/or other materials provided with the distribution.
;; THIS SOFTWARE IS PROVIDED BY THE AUTHOR "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
;; THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
;; AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
;; NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
;; HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
;; OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

;;; Commentary:
;;
;; Major mode for editing AD Model Builder (ADMB) code. Provides syntax highlighting, IDE compilation and file
;; manipulation, outline code navigation, templates, and smaller tools. The syntax groups for highlighting are:
;;
;; Face                          Example
;; admb-section-face             DATA_SECTION
;; font-lock-builtin-face        objective_function_value
;; font-lock-comment-face        //
;; font-lock-constant-face       PI
;; font-lock-function-name-face  [FUNCTION] myfunction
;; font-lock-keyword-face        log
;; font-lock-type-face           int
;;
;; Installation:
;;
;; 1. Copy this file (admb.el) to a directory in `load-path', or edit .emacs to add the directory to `load-path':
;;      (add-to-list 'load-path "mypath/admb")
;; 2. Byte-compile this file to admb.elc for faster startup:
;;      M-x byte-compile-file
;; 3. Edit .emacs so that `admb-mode' is autoloaded and assigned to *.tpl files:
;;      (autoload 'admb-mode "admb" "Edit ADMB code." t)
;;      (add-to-list 'auto-mode-alist '("\\.tpl$" . admb-mode))
;; 4. If you're running Emacs in MS Windows, add a line so *.tpl files are not treated as binary:
;;      (setq file-name-buffer-file-type-alist nil)
;; 5. You may want to assign a mode that recognizes #comments in *.dat files (perl-mode, conf-space-mode, or R-mode):
;;      (add-to-list 'auto-mode-alist '("\\.dat$" . conf-space-mode))
;;
;; Customization:
;;
;; See documentation of variable `admb-mode-hook' and function `admb-outline' for ideas.
;; See also ADMB-IDE (http://admb-project.org/community/editing-tools/admb-ide) for special use of `admb-mode'.
;;
;; Usage:
;;
;; See documentation of function `admb-mode'.
;;
;; References:
;;
;; Fournier, D. 2011. An introduction to AD Model Builder for use in nonlinear modeling and statistics. Version 10.0.
;;   Honolulu: ADMB Foundation. [http://admb-project.org/documentation/manuals/admb-user-manuals]
;; Fournier, D. 2011. AUTODIF: A C++ array language extension with automatic differentiation for use in nonlinear
;;   modeling and statistics. Version 10.0. Honolulu: ADMB Foundation.
;;   [http://admb-project.org/documentation/manuals/admb-user-manuals]
;; Magnusson, A. 2009. ADMB-IDE: Easy and efficient user interface. ADMB Foundation Newsletter 1(3):1-2.
;;   [http://admb-foundation.org/wp-content/uploads/Newsletter/ADMBNewsletterJuly2009.pdf]
;; Skaug, H. and D. Fournier. 2011. Random effects in AD Model Builder: ADMB-RE user guide. Version 10.0. Honolulu: ADMB
;;   Foundation. [http://admb-project.org/documentation/manuals/admb-user-manuals]
;;
;; Known issues:
;;
;; Indendation is not very smart
;; Cursor motion and deletions swallow entire underscore_separated_object_name, instead of pausing at each underscore
;; Does not work in XEmacs, reportedly

;;; History:
;;
;; 12 Jan 2012  6.7  Improved `admb-open'.
;;  1 Oct 2011  6.6  Added keywords "PI" and "sumsq". Made all keywords case-sensitive. Minor changes in `admb-template'
;;                   and `admb-template-mini'.
;; 31 Aug 2011  6.5  Improved documentation.
;;  1 Mar 2011  6.4  Added issue regarding XEmacs.
;; 19 Feb 2011  6.3  Added keywords "streampos" and "#undef".
;; 17 Feb 2011  6.2  Added internal function `admb-send', improving `admb-build', `admb-compile', `admb-link', and
;;                   `admb-run-makefile', and `admb-tpl2cpp'. Added keywords "prevariable_position",
;;                   "restore_prevariable_derivative", "restore_prevariable_position", "restore_prevariable_value",
;;                   "save_double_derivative", "save_prevariable_position", and "save_prevariable_value". Added GUI menu
;;                   item for admb-open".
;;  1 Dec 2010  6.1  Added keywords "allocate", "clock", "ctime", "difftime", "set_covariance_matrix", "strftime",
;;                   "time", "time_t", and "vcubic_spline_function".
;; 10 Oct 2010  6.0  Added user function `admb-toggle-flag'. Removed user function `admb-set-flags'. Rebound C-c C-- and
;;                   restructured GUI menu accordingly.
;;  1 Oct 2010  5.1  Improved documentation.
;; 20 Sep 2010  5.0  Added user function `admb-open'. Improved `admb-cor', `admb-cpp', `admb-par', `admb-pin', and
;;                   `admb-rep' so that files are opened in secondary window. Changed section highlighting to new
;;                   `admb-section-face'. Bound C-c C-o to `admb-open' and C-c C-r to `admb-rep'.
;; 14 Jul 2010  4.8  Added internal function `admb-split-window'.
;;  8 Jul 2010  4.7  Improved documentation.
;; 28 Jun 2010  4.6  Renamed `admb-version' to `admb-mode-version'. Unbound C-return and S-return.
;; 16 Jun 2010  4.5  Added keywords "diagonal", "dvar4_array", "dvar5_array", "dvar6_array", "dvar7_array", "d4_array",
;;                   "d5_array", "d6_array", "d7_array", "factln", "first_difference", "gamma_density",
;;                   "log_gamma_density", and "sgamma". Improved highlighting of comments.
;; 20 May 2010  4.4  Improved user functions `admb-build', `admb-compile', `admb-link', `admb-par', `admb-pin',
;;                   `admb-rep', `admb-run', `admb-run-args', `admb-run-makefile', and `admb-tpl2cpp'. Added keybinding
;;                   and GUI menu item for `admb-version'.
;; 23 Apr 2010  4.3  Improved `admb-run-args' and `admb-template'. Added constant `admb-version'. Added user function
;;                   `admb-version'. Added keyword "cube". Added Emacs Lisp ;;;###autoload cookie.
;; 19 Mar 2010  4.2  Changed user function `admb-rep' so .rep file is opened with Emacs rather than external browser.
;;                   Renamed old function `admb-rep-browser'.
;; 16 Mar 2010  4.1  Improved `admb-run-args' so it suggests same args as user passed last time. Improved documentation.
;; 14 Mar 2010  4.0  Added user functions `admb-par' and `admb-pin'. Added keywords "#define", "adstring_array",
;;                   "c_str", "change_datafile_name", "change_pinfile_name", "empty", "erase", "find", "find_first_of",
;;                   "find_last_of", "global_datafile", "insert", "length", "line_adstring", "nvarcalc", "replace",
;;                   "rfind", "set_ARRAY_MEMBLOCK_SIZE", "set_CMPDIF_BUFFER_SIZE", "set_GRADSTACK_BUFFER_SIZE",
;;                   "set_MAX_DLINKS", "set_MAX_NVAR_OFFSET", "set_NUM_DEPENDENT_VARIABLES", "set_NUM_RETURN_ARRAYS",
;;                   "set_RETURN_ARRAYS_SIZE", "showpoint", "strchr", "strcmp", "strcspn", "string", "strncat",
;;                   "strncmp", "strncpy", "strpbrk", "strrchr", "strspn", "strstr", "strtok", "substr", and "using".
;;                   Removed keywords "ad_comm", "argc", "argv", "gradient_structure", "ios", and "report". Added
;;                   highlighting of libraries and namespaces. Improved highlighting of function names. Improved
;;                   `admb-template'.
;; 26 Oct 2009  3.8  Rolled back to version 3.6, due to syntax highlighting problems. Added issue regarding underscores.
;; 23 Oct 2009  3.7  Improved cursor motion inside underscore_separated_words.
;; 30 Sep 2009  3.6  Improved syntax highlighting of function names.
;; 14 Sep 2009  3.5  Added user function `admb-toggle-section'. Improved syntax highlighting of function names. Added
;;                   issue regarding indentation.
;;  7 Jul 2009  3.4  Improved user functions `admb-run' and `admb-run-args' so Emacs doesn't hang up while model runs
;;                   and optimization progress is reported live. Shuffled GUI menu order.
;;  3 Jun 2009  3.3  Added current directory to local PATH in Linux.
;;  1 Jun 2009  3.2  Improved filename handling of `admb-cpp', `admb-cor', `admb-run', and `admb-run-args'.
;; 27 May 2009  3.1  Improved documentation.
;; 24 May 2009  3.0  Added user variables `admb-init' and `admb-run-makefile-command'. Renamed user variable
;;                   `admb-make-command' to `admb-build-command'. Redefined user variable `admb-tpl2cpp-command' as
;;                   internal variable. Added user functions `admb-cor', `admb-help', `admb-new-buffer',
;;                   `admb-run-makefile', `admb-set-flags', and `admb-toggle-window'. Renamed user function `admb-make'
;;                   to `admb-build'. Improved user function `admb-rep' so it checks if report file exists. Improved
;;                   user function `admb-tpl2cpp' to support `admb-init' and `admb-tpl2cpp-flags'. Improved user
;;                   functions `admb-build', `admb-compile', and `admb-link' to support `admb-init' and `admb-flags'.
;;                   Improved screen output from `admb-run' and `admb-run-args'. Added internal variables `admb-flags',
;;                   `admb-menu', `admb-tool-bar-map', and `admb-tpl2cpp-flags'. Added local variable `tool-bar-map'.
;;                   Added keywords "#elif", "#else", "#endif", "#if", "#ifdef", "#ifndef" "defined" "dll_3darray",
;;                   "dll_adstring", "dll_imatrix", "dll_init_3darray", "dll_init_bounded_number",
;;                   "dll_init_bounded_vector", "dll_init_imatrix", "dll_init_int", "dll_init_matrix",
;;                   "dll_init_number", "dll_init_vector", "dll_int", "dll_matrix", "dll_number", "dll_vector",
;;                   "init_number_vector", and "log_negbinomial_density". Added GUI menu and toolbar icons. Adopted
;;                   Simplified BSD License.
;;  8 Apr 2009  2.5  Improved documentation strings of user variables and user functions.
;; 31 Mar 2009  2.4  Improved screen output from user functions `admb-run' and `admb-run-args'. Improved indendation.
;; 27 Mar 2009  2.3  Improved screen output from user functions `admb-run' and `admb-run-args'.
;; 22 Mar 2009  2.2  Improved screen output from user functions `admb-run' and `admb-run-args'.
;; 20 Mar 2009  2.1  Added user variable `admb-window-right'. Improved screen output from user functions `admb-compile',
;;                   `admb-link', `admb-make', `admb-run', `admb-run-args', and `admb-tpl2cpp'. Improved user function
;;                   `admb-make' so it saves buffer before calling `admb-make-command'. Added keyword "randnegbinomial".
;;  9 Mar 2009  2.0  Complete rewrite. Added user variables `admb-comp-command', `admb-link-command',
;;                   `admb-make-command', and `admb-tpl2cpp-command'. Added user functions `admb-clean', `admb-compile',
;;                   `admb-cpp', `admb-endl', `admb-for', `admb-link',  `admb-make', `admb-rep', `admb-run',
;;                   `admb-run-args', and `admb-tpl2cpp'. Added internal variables `admb-font-lock-keywords',
;;                   `admb-mode-abbrev-table', `admb-mode-map', and `admb-mode-syntax-table'. Added local variables
;;                   `comment-start', `imenu-generic-expression', `indent-line-function', and `outline-regexp'. Added
;;                   keywords "4darray", "5darray", "6darray", "7darray", "bool", "init_4darray", "init_5darray",
;;                   "init_6darray", "init_7darray", "normal_prior", "NORMAL_PRIOR_FUNCTION",
;;                   "random_effects_bounded_matrix", "random_effects_bounded_vector", and "sizeof". Added commentary on
;;                   installation, customization, and usage.
;; 28 Jan 2009  1.4  Added keyword "close", changed  face names, and released to ADMB Project.
;; 11 Dec 2008  1.3  Added keyword "SEPERABLE_FUNCTION".
;; 28 Nov 2008  1.2  Added keywords "LOC_CALCS", "random_effects_vector", and "random_effects_matrix".
;; 23 Jul 2008  1.1  Added user function `admb-outline'.
;; 25 Sep 2007  1.0  Added user functions `admb-template' and `admb-template-mini'.
;; 26 Aug 2003  0.9  Created main function `admb-mode', user variable `admb-mode-hook', and local variable
;;                   `font-lock-defaults'.

;;; Code:

;; 1  Preamble

(require 'outline)
(require 'which-func)(add-to-list 'which-func-modes 'admb-mode)
(defgroup admb nil "Major mode for editing AD Model Builder code." :tag "ADMB" :group 'languages)
(if (not (string-match "windows" (prin1-to-string system-type)))(setenv "PATH" (concat ".:" (getenv "PATH"))))

;; 2  User variables

(defcustom admb-build-command "admb"
  "Shell command to build executable from TPL, using `admb-build'."
  :tag   "Build"
  :type  'string
  :group 'admb)
(defcustom admb-comp-command "adcomp"
  "Shell command to compile C++ to object code, using `admb-compile'."
  :tag   "Compile"
  :type  'string
  :group 'admb)
(defcustom admb-link-command "adlink"
  "Shell command to link object code to executable, using `admb-link'."
  :tag   "Link"
  :type  'string
  :group 'admb)
(defcustom admb-init ""
  "String to prepend before ADMB compilation commands.\n
Pasted without space before `admb-build-command', `admb-tpl2cpp-command',
`admb-comp-command', and `admb-link-command', e.g. a shell script followed by a
command separator."
  :tag   "Init"
  :type  'string
  :group 'admb)
(defcustom admb-run-makefile-command "make"
  "Shell command to run makefile, using `admb-run-makefile'."
  :tag   "Makefile"
  :type  'string
  :group 'admb)
(defcustom admb-window-right t
  "Non-nil places secondary window on the right, nil places it below.\n
The secondary window shows compilation and model runs, among other things."
  :tag "Window right"
  :type 'boolean
  :group 'admb)
(defcustom admb-mode-hook nil
  "Hook for `admb-mode'.\n
If you want to set compilation commands, syntax colors, or keybindings, here is
an example that does that:\n
\(defun my-admb-hook ()
  (setq admb-build-command \"myadmb\")
  (setq admb-comp-command \"myadcomp\")
  (setq admb-link-command \"myadlink\")
  (set-face-attribute 'font-lock-function-name-face nil
                      :foreground \"brown\" :weight 'bold)
  (local-set-key [f9] 'admb-build)
  (local-set-key [down-mouse-3] 'imenu))
\(add-hook 'admb-mode-hook 'my-admb-hook)"
  :tag   "Hook"
  :type  'hook
  :group 'admb)
(defface admb-section-face '((t :weight bold)) "Font Lock mode face used to highlight ADMB sections." :group 'admb)
(defvar admb-section-face 'admb-section-face "Face name to use for ADMB sections.") ; byte-compile warns without this

;; 3  Internal variables

(defvar admb-flags ""
  "Compilation flags for `admb-build', `admb-compile', and `admb-link'.\n
Any combination of space-separated -d, -r, and -s, specifying that the build
target should be a DLL, ADMB-RE model, and/or in safe mode.\n
Use `admb-toggle-flag' to set `admb-flags', `admb-tpl2cpp-command', and
`admb-tpl2cpp-flags' simultaneously.")
(defvar admb-tpl2cpp-command "tpl2cpp"
  "Shell command to translate TPL to C++, using `admb-tpl2cpp'.\n
Use `admb-toggle-flag' to set `admb-flags', `admb-tpl2cpp-command', and
`admb-tpl2cpp-flags' simultaneously.")
(defvar admb-tpl2cpp-flags ""
  "Translation flags for `admb-tpl2cpp'.\n
Any combination of space-separated -bound and -dll, specifying that the build
target should be a DLL and/or in safe mode.\n
Use `admb-toggle-flag' to set `admb-flags', `admb-tpl2cpp-command', and
`admb-tpl2cpp-flags' simultaneously.")
(defvar admb-font-lock-keywords
  (eval-when-compile
    (let ((SECTIONS
           '("^DATA_SECTION"                       "^INITIALIZATION_SECTION"             "^PARAMETER_SECTION"
             "^PRELIMINARY_CALCS_SECTION"          "^PROCEDURE_SECTION"                  "^FUNCTION"
             "^SEPARABLE_FUNCTION"                 "^REPORT_SECTION"                     "^RUNTIME_SECTION"
             "^TOP_OF_MAIN_SECTION"                "^GLOBALS_SECTION"                    "^BETWEEN_PHASES_SECTION"
             "^NORMAL_PRIOR_FUNCTION"              "^FINAL_SECTION"))
          (CONSTANTS
           '("LOC_CALCS"                           "LOCAL_CALCS"                         "END_CALCS"
             "PI"                                  "USER_CODE"))
          (DATATYPES
           '(;; C
             "time_t"
             ;; C++
             "bool"                                "char"                                "double"
             "int"                                 "long"                                "signed"
             "streampos"                           "string"                              "unsigned"
             "void"
             ;; AUTODIF
             "_CONST"                              "CLASS"                               "dvariable"
             "dvar_vector"                         "dvar_matrix"                         "dvar3_array"
             "dvar4_array"                         "dvar5_array"                         "dvar6_array"
             "dvar7_array"                         "dvector"                             "dmatrix"
             "d3_array"                            "d4_array"                            "d5_array"
             "d6_array"                            "d7_array"
             ;; Plain variables
             "adstring"                            "adstring_array"                      "line_adstring"
             "ivector"                             "imatrix"                             "number"
             "vector"                              "matrix"                              "3darray"
             "4darray"                             "5darray"                             "6darray"
             "7darray"                             "dev_vector"
             ;; Input data and parameters
             "init_int"                            "init_ivector"                        "init_imatrix"
             "init_number"                         "init_vector"                         "init_number_vector"
             "init_matrix"                         "init_bounded_number"                 "init_bounded_vector"
             "init_bounded_matrix"                 "init_vector_vector"                  "init_matrix_vector"
             "init_bounded_number_vector"          "init_bounded_vector_vector"          "init_bounded_matrix_vector"
             "init_bounded_dev_vector"             "init_3darray"                        "init_4darray"
             "init_5darray"                        "init_6darray"                        "init_7darray"
             "init_adstring"
             ;; Random effects
             "normal_prior"                        "random_effects_vector"               "random_effects_bounded_vector"
             "random_effects_matrix"               "random_effects_bounded_matrix"
             ;; DLL variables
             "dll_int"                             "dll_imatrix"                         "dll_number"
             "dll_vector"                          "dll_matrix"                          "dll_3darray"
             "dll_adstring"
             ;; DLL data and parameters
             "dll_init_int"                        "dll_init_imatrix"                    "dll_init_number"
             "dll_init_vector"                     "dll_init_matrix"                     "dll_init_bounded_number"
             "dll_init_bounded_vector"             "dll_init_3darray"
             ;; Special objects
             "banded_lower_triangular_dvar_matrix" "banded_symmetric_dvar_matrix"        "constant_model_parameters"
             "dvar_vector_position"                "dvar_matrix_position"                "extern"
             "fmm"                                 "funnel_dvariable"                    "independent_variables"
             "model_data"                          "model_parameters"                    "prevariable"
             "prevariable_position"                "likeprof_number"                     "random_number_generator"
             "sdreport_number"                     "sdreport_vector"                     "sdreport_matrix"
             "variable_model_parameters"           "vcubic_spline_function"))
          (FUNCTIONS
           '(;; C++
             "break"                               "case"                                "const"
             "default"                             "define"                              "if"
             "else"                                "for"                                 "goto"
             "return"                              "sizeof"                              "switch"
             "using"                               "while"
             ;; C++ I/O
             "cerr"                                "cin"                                 "cout"
             "endl"                                "setf"                                "setfixed"
             "setprecision"                        "setscientific"                       "setw"
             "showpoint"
             ;; C strings
             "atof"                                "atoi"                                "printf"
             "sprintf"                             "strcat"                              "strchr"
             "strcmp"                              "strcpy"                              "strcspn"
             "strlen"                              "strncat"                             "strncmp"
             "strncpy"                             "strpbrk"                             "strrchr"
             "strspn"                              "strstr"                              "strtok"
             ;; C++ strings
             "c_str"                               "empty"                               "erase"
             "find"                                "find_first_of"                       "find_last_of"
             "insert"                              "length"                              "replace"
             "rfind"                               "substr"
             ;; C time
             "clock"                               "ctime"                               "difftime"
             "strftime"                            "time"
             ;; AUTODIF
             "allocated"                           "nvarcalc"                            "set_covariance_matrix"
             ;; Basic math
             "abs"                                 "ceil"                                "cube"
             "exp"                                 "fabs"                                "factln"
             "first_difference"                    "floor"                               "gammln"
             "log"                                 "log10"                               "log_comb"
             "mfexp"                               "modf"                                "posfun"
             "pow"                                 "sfabs"                               "square"
             "sqrt"
             ;; Trigonometry
             "acos"                                "asin"                                "atan"
             "cos"                                 "cosh"                                "sin"
             "sinh"                                "tan"                                 "tanh"
             ;; Random variates and density
             "betai"                               "cumd_cauchy"                         "cumd_norm"
             "gamma_density"                       "inv_cumd_cauchy"                     "inv_cumd_norm"
             "log_gamma_density"                   "log_negbinomial_density"             "randn"
             "randnegbinomial"                     "randpoisson"                         "randu"
             "sgamma"
             ;; Vectors and matrices, basics
             "colsum"                              "column"                              "elem_div"
             "elem_prod"                           "extract_column"                      "extract_row"
             "max"                                 "mean"                                "min"
             "row"                                 "rowsum"                              "size_count"
             "sort"                                "std_dev"                             "sum"
             "trans"
             ;; Vectors and matrices, linear algebra
             "choleski_decomp"                     "det"                                 "diagonal"
             "eigenvalues"                         "eigenvectors"                        "empirical_covariance"
             "extract_diagonal"                    "identity_matrix"                     "inv"
             "ln_det"                              "norm"                                "norm2"
             "outer_prod"                          "regression"                          "robust_regression"
             "solve"                               "sumsq"
             ;; Dot methods
             "allocate"                            "fill"                                "fill_multinomial"
             "fill_seqadd"                         "fill_randbi"                         "fill_randn"
             "fill_randn_ni"                       "fill_randpoisson"                    "fill_randu"
             "fill_randu_ni"                       "indexmax"                            "indexmin"
             "initialize"
             ;; Dot methods, col*, row*, and slice*
             "colfill"                             "colfill_randn"                       "colfill_randu"
             "colfill_seqadd"                      "colmax"                              "colmin"
             "colshift"                            "colsize"                             "rowfill"
             "rowfill_randn"                       "rowfill_randu"                       "rowfill_seqadd"
             "rowmax"                              "rowmin"                              "rowshift"
             "rowsize"                             "slicemax"                            "slicemin"
             "sliceshift"                          "slicesize"
             ;; Phases
             "active"                              "current_phase"                       "initial_params"
             "last_phase"                          "mceval_phase"                        "sd_phase"
             ;; Adjoint code
             "AD_SET_DERIVATIVES"                  "AD_SET_DERIVATIVES2"                 "AD_SET_DERIVATIVES4"
             "ADJOINT_CODE"                        "elem"                                "elem_value"
             "restore_dvar_vector_position"        "restore_dvar_vector_value"           "restore_dvar_matrix_position"
             "restore_dvar_matrix_value"           "restore_prevariable_derivative"      "restore_prevariable_position"
             "restore_prevariable_value"           "save_double_derivative"              "save_dvar_vector_position"
             "save_dvar_vector_value"              "save_dvector_derivatives"            "save_dmatrix_derivatives"
             "save_dvar_matrix_position"           "save_identifier_string"              "save_prevariable_position"
             "save_prevariable_value"              "set_value"                           "size"
             "sub"                                 "value"                               "verify_identifier_string"
             ;; Special functions
             "ad_printf"                           "ad_begin_funnel"                     "ad_exit"
             "adromb"                              "boundp"                              "boundpin"
             "gradcalc"                            "histogram"                           "mf_upper_bound"
             "option_match"                        "set_stepnumber"                      "set_stepsize"
             "shift"))
          (IMPORTANT
           '(;; Shell
             "exit"                                "system"
             ;; File input/output
             "adprogram_name"                      "change_datafile_name"                "change_pinfile_name"
             "close"                               "global_datafile"                     "ifstream"
             "ofstream"                            "open"                                "uistream"
             "uostream"
             ;; Allocations (TOP_OF_MAIN_SECTION)
             "arrmblsize"                          "set_ARRAY_MEMBLOCK_SIZE"             "set_CMPDIF_BUFFER_SIZE"
             "set_GRADSTACK_BUFFER_SIZE"           "set_MAX_DLINKS"                      "set_MAX_NVAR_OFFSET"
             "set_NUM_DEPENDENT_VARIABLES"         "set_NUM_RETURN_ARRAYS"               "set_RETURN_ARRAYS_SIZE"
             ;; Minimization settings
             "convergence_criteria"                "objective_function_value"            "maximum_function_evaluations"
             ;; Adjoint code and preprocessing (GLOBALS_SECTION)
             "defined"                             "#define"                             "#elif"
             "#else"                               "#endif"                              "#if"
             "#ifdef"                              "#ifndef"                             "#include"
             "RETURN_ARRAYS_DECREMENT"             "RETURN_ARRAYS_INCREMENT"             "#undef")))
      (list
       '("\\([A-Za-z_]*\\)::" (1 font-lock-constant-face))
       '("<\\([A-Za-z_]*\\)>" (1 font-lock-constant-face))
       '("^[A-Z_]*\\(FUNCTION\\| *#define\\)[^(\n]+?\\([a-zA-Z0-9_]+\\)[(\n]"
         (2 font-lock-function-name-face)) ; skip type
       (cons (concat "\\<\\(" (mapconcat 'eval SECTIONS "\\|") "\\)\\>") 'admb-section-face)
       (cons (regexp-opt CONSTANTS 'words) font-lock-constant-face)
       (cons (regexp-opt DATATYPES 'words) font-lock-type-face)
       (cons (regexp-opt FUNCTIONS 'words) font-lock-keyword-face)
       (cons (regexp-opt IMPORTANT 'words) font-lock-builtin-face)))))
(defvar admb-menu
  '("ADMB"
    ["Translate"            admb-tpl2cpp       ] ; :help "Translate TPL to C++"
    ["Compile"              admb-compile       ] ; :help "Compile C++ to object code"
    ["Link"                 admb-link          ] ; :help "Link object code to exe"
    ["Build"                admb-build         ] ; :help "Build executable from TPL"
    "--"
    ["Run"                  admb-run           ] ; :help "Run executable"
    ["Run with Args"        admb-run-args      ] ; :help "Run executable with args"
    ["Run Makefile"         admb-run-makefile  ] ; :help "Run Makefile in current dir"
    "--"
    ["View Report"          admb-rep           ] ; :help "Open .rep file"
    ["View Estimates"       admb-cor           ] ; :help "Open .cor file"
    ["View Point Estimates" admb-par           ] ; :help "Open .par file"
    ["View Initial Values"  admb-pin           ] ; :help "Open .pin file"
    ["View C++"             admb-cpp           ] ; :help "Open C++ file"
    ["View Any"             admb-open          ] ; :help "Open model file"
    ["Clean Directory"      admb-clean         ] ; :help "Remove temporary files"
    "--"
    ["Outline"              admb-outline       ] ; :help "Navigate with outline"
    ["Imenu"                imenu              ] ; :help "Navigate with imenu"
    ["Template"             admb-template      ] ; :help "Insert template"
    ["Mini Template"        admb-template-mini ] ; :help "Insert minimal template"
    ["Toggle Section"       admb-toggle-section] ; :help "Toggle section indicator"
    ["Toggle Window"        admb-toggle-window ] ; :help "Toggle secondary window"
    "--"
    ["Target"               admb-toggle-flag   ] ; :help "Toggle compilation option"
    ["-d: DLL"             (admb-toggle-flag "d") :style toggle :selected (string-match ".*d.*" admb-flags)]
    ["-g: Debug"           (admb-toggle-flag "g") :style toggle :selected (string-match ".*g.*" admb-flags)]
    ["-r: Random Effects"  (admb-toggle-flag "r") :style toggle :selected (string-match ".*r.*" admb-flags)]
    ["-s: Safe"            (admb-toggle-flag "s") :style toggle :selected (string-match ".*s.*" admb-flags)]
    "--"
    ["Help"                 admb-help         ]   ; :help "Show help page"
    ["ADMB Mode Version"    admb-mode-version ])) ; :help "Show ADMB Mode version"
(defvar admb-mode-abbrev-table nil)(define-abbrev-table 'admb-mode-abbrev-table ())
(defvar admb-mode-map
  ;; Don't use C-c C-                        x
  ;; Special   C-c C-        h
  ;; Custom    C-c C- a cdef   jklm o  rs  vw
  ;; Available C-c C-  b    g i    n pq  tu   yz
  (let ((map (make-sparse-keymap)))
    (easy-menu-define nil map nil admb-menu)
    (define-key map [f11]               'admb-outline       )
    (define-key map [S-f11]             'imenu              )
    (define-key map [f12]               'admb-template      )
    (define-key map [S-f12]             'admb-template-mini )
    (define-key map [tab]               'indent-relative    )
    (define-key map [M-return]          'admb-endl          )
    (define-key map [?\C-c C-backspace] 'admb-clean         )
    (define-key map [?\C-c ?\C--]       'admb-toggle-flag   )
    (define-key map [?\C-c ?\C-.]       'admb-mode-version  )
    (define-key map [?\C-c ?\C-/]       'admb-help          )
    (define-key map [?\C-c ?\C-a]       'admb-run-args      )
    (define-key map [?\C-c ?\C-c]       'admb-build         )
    (define-key map [?\C-c ?\C-d]       'admb-cpp           )
    (define-key map [?\C-c ?\C-e]       'admb-cor           )
    (define-key map [?\C-c ?\C-f]       'admb-for           )
    (define-key map [?\C-c ?\C-i]       'admb-pin           )
    (define-key map [?\C-c ?\C-j]       'admb-tpl2cpp       )
    (define-key map [?\C-c ?\C-k]       'admb-compile       )
    (define-key map [?\C-c ?\C-l]       'admb-link          )
    (define-key map [?\C-c ?\C-m]       'admb-run-makefile  )
    (define-key map [?\C-c ?\C-o]       'admb-open          )
    (define-key map [?\C-c ?\C-p]       'admb-par           )
    (define-key map [?\C-c ?\C-r]       'admb-rep           )
    (define-key map [?\C-c ?\C-s]       'admb-toggle-section)
    (define-key map [?\C-c ?\C-v]       'admb-run           )
    (define-key map [?\C-c ?\C-w]       'admb-toggle-window )
    map))
(defvar admb-tool-bar-map
  (let ((tool-bar-map (make-sparse-keymap))
        (undo-form '(and (not buffer-read-only)(not (eq t buffer-undo-list)) ; from menu-bar.el
                         (if (eq last-command 'undo)(listp pending-undo-list)(consp buffer-undo-list)))))
    (tool-bar-add-item "new"        'admb-new-buffer     'admb-new-buffer     :help "New"                              )
    (tool-bar-add-item "open"       'find-file           'find-file           :help "Open"                             )
    (tool-bar-add-item "save"       'save-buffer         'save-buffer         :help "Save" :enable '(buffer-modified-p))
    (tool-bar-add-item "cut"        'kill-region         'kill-region         :help "Cut"                              )
    (tool-bar-add-item "copy"       'copy-region-as-kill 'copy-region-as-kill :help "Copy"                             )
    (tool-bar-add-item "paste"      'yank                'yank                :help "Paste"                            )
    (tool-bar-add-item "undo"       'undo                'undo                :help "Undo" :enable undo-form           )
    (tool-bar-add-item "close"      'kill-this-buffer    'kill-this-buffer    :help "Close"                            )
    (tool-bar-add-item "separator"  'ignore              'ignore              :help "" :enable nil                     )
    (tool-bar-add-item "disconnect" 'admb-tpl2cpp        'admb-tpl2cpp        :help "Translate"                        )
    (tool-bar-add-item "connect"    'admb-build          'admb-build          :help "Build"                            )
    (tool-bar-add-item "jump-to"    'admb-run            'admb-run            :help "Run"                              )
    (tool-bar-add-item "describe"   'admb-rep            'admb-rep            :help "View report"                      )
    tool-bar-map))
(defvar admb-mode-syntax-table
  (let ((table (make-syntax-table)))
    (modify-syntax-entry ?# "w" table)      ; highlight preprocessor directives like #include
    (modify-syntax-entry ?_ "w" table)      ; ignore keywords inside underscore like_int_this (affects cursor motion)
    (modify-syntax-entry ?/ ". 124b" table) ; C++ comment delimiters (from Emacs Lisp manual)
    (modify-syntax-entry ?* ". 23" table)   ; C++ comment delimiters (from Emacs Lisp manual)
    (modify-syntax-entry ?\n "> b" table)   ; C++ comment delimiters (from Emacs Lisp manual)
    table))

;; 4  User functions

(defun admb-build () "Build executable from TPL.\n
This command combines `admb-init', `admb-build-command' and `admb-flags'."
  (interactive)(save-buffer)(admb-split-window)
  (admb-send (concat admb-init admb-build-command " " admb-flags " " (file-name-sans-extension (buffer-name))))
  (with-current-buffer "*compilation*" (setq show-trailing-whitespace nil)))
(defun admb-clean () "Remove temporary files." (interactive)
  (let* ((model (file-name-sans-extension (buffer-name))) ; fmin.log only in Linux
         (pattern (concat "admodel\\..*"          "\\|" "classcode\\.tmp" "\\|" "eigv\\..*"       "\\|" "fmin.log"
                          "\\|" "hessian.bin"     "\\|" "sims"            "\\|" "variance"        "\\|" model "\\.b0.*"
                          "\\|" model "\\.bar"    "\\|" "\\.bgs"          "\\|" model "\\.cpp"    "\\|" model "\\.ecm"
                          "\\|" model "\\.eva"    "\\|" model "\\.exp"    "\\|" model "\\.hes"    "\\|" model "\\.hst"
                          "\\|" model "\\.htp"    "\\|" model "\\.lib"    "\\|" model "\\.log"    "\\|" model "\\.luu"
                          "\\|" model "\\.mc2"    "\\|" model "\\.mcm"    "\\|" model "\\.o"      "\\|" model "\\.obj"
                          "\\|" model "\\.p0.*"   "\\|" model "\\.r0.*"   "\\|" model "\\.std"    "\\|" model "\\.tds"))
         (files (directory-files "." nil pattern t)))
    (dolist (x files)(delete-file x)))(message "Removed ADMB temporary files."))
(defun admb-compile () "Compile C++ to object code.\n
This command combines `admb-init', `admb-comp-command', and `admb-flags'."
  (interactive)(admb-split-window)
  (admb-send (concat admb-init admb-comp-command " " admb-flags " " (file-name-sans-extension (buffer-name))))
  (with-current-buffer "*compilation*" (setq show-trailing-whitespace nil)))
(defun admb-cor () "Open ADMB estimates (.cor) file." (interactive)(admb-open "cor"))
(defun admb-cpp () "Open C++ file translated from TPL file." (interactive)(admb-open "cpp"))
(defun admb-endl () "Insert << endl; (or just endl;) and newline." (interactive)
  (delete-horizontal-space)(if (string-equal (char-to-string (preceding-char)) "<")(insert " endl;")
                             (insert " << endl;")))
(defun admb-for () "Insert for(i=1; i<=; i++)." (interactive)(insert "for(i=1; i<=; i++)")(search-backward ";"))
(defun admb-help () "Show help page for `admb-mode'." (interactive)
  (describe-function 'admb-mode)(switch-to-buffer "*Help*")(delete-other-windows)(message nil))
(defun admb-link () "Link object code to executable.\n
This command combines `admb-init', `admb-link-command', and `admb-flags'."
  (interactive)(admb-split-window)
  (admb-send (concat admb-init admb-link-command " " admb-flags " " (file-name-sans-extension (buffer-name))))
  (with-current-buffer "*compilation*" (setq show-trailing-whitespace nil)))
(defun admb-mode-version () "Show ADMB Mode version number." (interactive)
  (message (concat "ADMB Mode version " admb-mode-version)))
(defun admb-new-buffer () "Create new buffer." (interactive)
  (switch-to-buffer (generate-new-buffer "Untitled"))(eval (list (default-value 'major-mode))))
(defun admb-open (ext) "Open file with extension EXT in secondary window." (interactive "sExtension: ")
  (let ((file (concat (file-name-sans-extension (buffer-name)) "." ext))(tpl-window (selected-window)))
    (if (not (file-regular-p file))(error "File %s not found" file)(admb-split-window)(find-file-noselect file)
        (set-window-buffer (next-window) file)(select-window tpl-window))))
(defun admb-outline () "Navigate within ADMB file using `outline-mode'.\n
If you haven't already configured an `outline-mode-hook', here is an example
that makes it easy to return to `admb-mode':\n
\(defun my-outline-hook ()
  (local-set-key [mouse-1] 'outline-mouse-select)
  (local-set-key [return]  'admb-mode           )
  (defun outline-mouse-select ()
    \"Select position and return to `admb-mode'.\" (interactive)
    (admb-mode)(beginning-of-line)))
\(add-hook 'outline-mode-hook 'my-outline-hook)"
  (interactive)(let ((outreg outline-regexp))(outline-mode)(setq outline-regexp outreg))(outline-mode)(hide-body))
(defun admb-par () "Open ADMB point estimates (.par) file." (interactive)(admb-open "par"))
(defun admb-pin () "Open ADMB initial values (.pin) file." (interactive)(admb-open "pin"))
(defun admb-rep () "Open ADMB report (.rep) file." (interactive)(admb-open "rep"))
(defun admb-rep-browser () "Open ADMB report (.rep) file with `browse-url'.\n
The idea is to show the report file in an external  browser, but the actual
behavior of `browse-url' varies between machines. In Windows, the .rep file
ending may need to be associated with the desired browser program."
  (interactive)
  (let ((rep-file (concat (file-name-sans-extension buffer-file-name) ".rep")))
    (if (file-regular-p rep-file)(progn (browse-url rep-file)(message nil))
      (message "Report file %s not found" rep-file))))
(defun admb-run () "Run ADMB program." (interactive)
  (let ((cmd (file-name-sans-extension (buffer-name)))(resize-mini-windows nil)) ; split, prepare, show, run
    (admb-split-window)(get-buffer-create "*ADMB Output*")
    (with-current-buffer "*ADMB Output*" (kill-region (point-min)(point-max))(setq show-trailing-whitespace nil))
    (set-window-buffer (next-window) "*ADMB Output*")(start-process-shell-command cmd "*ADMB Output*" cmd)))
(defun admb-run-args (args) "Run ADMB program with ARGS."
  (interactive ; can replace `read-from-minibuffer' with `read-shell-command' in Emacs 23, and remove the nil nil
   (list (read-from-minibuffer "Args: " (car shell-command-history) nil nil (cons 'shell-command-history 1))))
  (let ((cmd (concat (file-name-sans-extension (buffer-name)) " " args))(resize-mini-windows nil))
    (admb-split-window)(get-buffer-create "*ADMB Output*")
    (with-current-buffer "*ADMB Output*" (kill-region (point-min)(point-max))(setq show-trailing-whitespace nil))
    (set-window-buffer (next-window) "*ADMB Output*")(start-process-shell-command cmd "*ADMB Output*" cmd)))
(defun admb-run-makefile () "Run Makefile in current directory, using `admb-run-makefile-command'."
  (interactive)(save-buffer)(admb-split-window)(admb-send admb-run-makefile-command)
  (with-current-buffer "*compilation*" (setq show-trailing-whitespace nil)))
(defun admb-send (cmd) "Send shell compilation command, after cleaning up spaces."
  (compile (replace-regexp-in-string "  +" " " cmd)))
(defun admb-split-window () "Split window if it is the only window, otherwise do nothing.\n
The orientation of the split depends on the value of `admb-window-right'."
  (if (one-window-p)(if admb-window-right (split-window-horizontally)(split-window-vertically))))
(defun admb-template () "Insert AD Model Builder template." (interactive)
  (goto-char (point-min))(insert "
//----------------------------------------------------------------------------------------------------------------------
// File:
// Model:
// Parameters:
// Fitted data:
// Likelihood:
// Notes:
// Warning:
// History:
//----------------------------------------------------------------------------------------------------------------------

GLOBALS_SECTION
  #include \"admodel.h\"
  ofstream mcmc_report(\"mcmc.csv\");
  const double pi = 3.141592654;

DATA_SECTION
  init_int n
  init_vector x(1,n)
  init_vector y(1,n)
  number halfnlog2pi
  int mcmc_lines

PARAMETER_SECTION
  init_number b0
  init_number b1
  init_number logsigma
  sdreport_number sigma
  vector yfit(1,n)
  matrix summary(1,n,1,3)  // | x | y | yfit |
  objective_function_value neglogL

PRELIMINARY_CALCS_SECTION
  halfnlog2pi = 0.5*n*log(2*pi);
  mcmc_lines = 0;

PROCEDURE_SECTION
  yfit = b0 + b1*x;
  sigma = mfexp(logsigma);
  neglogL = halfnlog2pi + n*logsigma + norm2(y-yfit)/(2*sigma*sigma);
  if(mceval_phase())
    write_mcmc();

REPORT_SECTION
  get_summary();
  report<<\"# b0\"     <<endl<<b0           <<endl
        <<\"# b1\"     <<endl<<b1           <<endl
        <<\"# RSS\"    <<endl<<norm2(y-yfit)<<endl
        <<\"# sigma\"  <<endl<<sigma        <<endl
        <<\"# neglogL\"<<endl<<neglogL<<endl<<endl;
  report<<\"# Model summary\"<<endl
        <<\" x y yfit\"<<endl
        <<summary<<endl;

FUNCTION get_summary
  summary.colfill(1,x);
  summary.colfill(2,y);
  summary.colfill(3,yfit);

FUNCTION write_mcmc
  if(mcmc_lines == 0)
    mcmc_report<<\"neglogL,b0,b1,sigma\"<<endl;
  mcmc_report<<neglogL<<\",\"<<b0<<\",\"<<b1<<\",\"<<sigma<<endl;
  mcmc_lines++;
")(goto-char (point-min))(delete-char 1))
(defun admb-template-mini () "Insert minimal AD Model Builder template." (interactive)
  (goto-char (point-min))(insert "
DATA_SECTION
  init_int n
  init_vector x(1,n)
  init_vector y(1,n)

PARAMETER_SECTION
  init_number b0
  init_number b1
  vector yfit(1,n)
  objective_function_value RSS

PROCEDURE_SECTION
  yfit = b0 + b1*x;
  RSS = norm2(y-yfit);
")(goto-char (point-min))(delete-char 1))
(defun admb-toggle-flag (flag) "Toggle compilation option.\n
FLAG is a string: \"d\" (dll), \"g\" (debug), \"r\" (random effects), or \"s\" (safe).\n
This command sets `admb-tpl2cpp-command', `admb-tpl2cpp-flags', and `admb-flags'
simultaneously."
  (interactive "sToggle compilation option: ")
  (let ((SS nil)) ; string splits, a list
    (cond ((string-match "-?d" flag)
           (setq SS (split-string admb-tpl2cpp-flags)) ; tpl2cpp flags
           (if (member "-dll" SS)(setq SS (remove "-dll" SS))(setq SS (sort (cons "-dll" SS) 'string-lessp)))
           (setq admb-tpl2cpp-flags (mapconcat 'eval SS " "))
           (setq SS (split-string admb-flags)) ; admb flags
           (if (member "-d" SS)(setq SS (remove "-d" SS))(setq SS (sort (cons "-d" SS) 'string-lessp)))
           (setq admb-flags (mapconcat 'eval SS " ")))
          ((string-match "-?g" flag)
           (setq SS (split-string admb-flags)) ; admb flags
           (if (member "-g" SS)(setq SS (remove "-g" SS))(setq SS (sort (cons "-g" SS) 'string-lessp)))
           (setq admb-flags (mapconcat 'eval SS " ")))
          ((string-match "-?r" flag)
           (setq admb-tpl2cpp-command (if (string-equal admb-tpl2cpp-command "tpl2rem") "tpl2cpp" "tpl2rem")) ; tpl2cpp
           (setq SS (split-string admb-flags)) ; admb flags
           (if (member "-r" SS)(setq SS (remove "-r" SS))(setq SS (sort (cons "-r" SS) 'string-lessp)))
           (setq admb-flags (mapconcat 'eval SS " ")))
          ((string-match "-?s" flag)
           (setq SS (split-string admb-tpl2cpp-flags)) ; tpl2cpp flags
           (if (member "-bounds" SS)(setq SS (remove "-bounds" SS))(setq SS (sort (cons "-bounds" SS) 'string-lessp)))
           (setq admb-tpl2cpp-flags (mapconcat 'eval SS " "))
           (setq SS (split-string admb-flags)) ; admb flags
           (if (member "-s" SS)(setq SS (remove "-s" SS))(setq SS (sort (cons "-s" SS) 'string-lessp)))
           (setq admb-flags (mapconcat 'eval SS " "))))
    (message (if (= (length admb-tpl2cpp-flags) 0) "Compilation options: %s %s   (%s%s)"
               "Compilation options: %s %s   (%s %s)") admb-build-command admb-flags admb-tpl2cpp-command
               admb-tpl2cpp-flags)))
(defun admb-toggle-section () "Toggle whether the current section is indicated in the mode line." (interactive)
  (which-function-mode (if which-function-mode 0 1))
  (message "Section indicator %s" (if which-function-mode "ON" "OFF")))
(defun admb-toggle-window () "Toggle whether secondary window is on the right or below." (interactive)
  (delete-other-windows)(setq admb-window-right (not admb-window-right))
  (message "Secondary window %s" (if admb-window-right "RIGHT" "BELOW")))
(defun admb-tpl2cpp () "Translate TPL to C++.\n
This command combines `admb-init', `admb-tpl2cpp-command', and `admb-tpl2cpp-flags'."
  (interactive)(save-buffer)(admb-split-window)
  (admb-send
   (concat admb-init admb-tpl2cpp-command " " admb-tpl2cpp-flags " " (file-name-sans-extension (buffer-name))))
  (with-current-buffer "*compilation*" (setq show-trailing-whitespace nil)))

;; 5  Main function

;;;###autoload
(defun admb-mode () "Major mode for creating statistical models with AD Model Builder.\n
The `admb-help' command shows this page.\n
Start a new model from `admb-template' or `admb-template-mini'. Navigate between
sections using `admb-outline', `imenu', or `outline-minor-mode'. Indicate the
current section in the mode line with `admb-toggle-section', and use
`admb-endl', `admb-for', and `dabbrev-expand' to save keystrokes.\n
Compile using `admb-build', or `admb-tpl2cpp', `admb-compile', and `admb-link'.
Configure these compilation commands with `admb-toggle-flag' and by setting the
variables `admb-init', `admb-build-command', `admb-comp-command', and
`admb-link-command'.\n
Use `admb-toggle-window' to set `admb-window-right' to your viewing preference.
After compiling, use `admb-cpp' to debug, `admb-clean' to remove temporary
files, and `admb-pin' to set initial parameter values. Run model with `admb-run'
or `admb-run-args', and view model output with `admb-cor', `admb-par',
`admb-rep', and `admb-rep-browser'.\n
The `admb-run-makefile' command can be used to link multiple files into an
application.\n
\\{admb-mode-map}"
  (interactive)(kill-all-local-variables)(setq major-mode 'admb-mode)(setq mode-name "ADMB")
  (set (make-local-variable 'comment-start) "//")
  (set (make-local-variable 'font-lock-defaults) '(admb-font-lock-keywords nil nil)) ; case-sensitive keywords
  (set (make-local-variable 'imenu-generic-expression) '((nil "^[A-Z].*" 0)))
  (set (make-local-variable 'indent-line-function) 'indent-relative)
  (set (make-local-variable 'outline-regexp) "[A-Z]")
  (set (make-local-variable 'tab-stop-list) '(2)) ; first line in section
  (set (make-local-variable 'tool-bar-map) admb-tool-bar-map)
  (set-syntax-table admb-mode-syntax-table)
  (setq local-abbrev-table admb-mode-abbrev-table)
  (use-local-map admb-mode-map)
  (run-mode-hooks 'admb-mode-hook))

(provide 'admb)

;;; admb.el ends here
