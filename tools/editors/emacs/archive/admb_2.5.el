;;; admb.el --- major mode for editing AD Model Builder code

;; Copyright (C) 2003, 2007, 2008, 2009 Arni Magnusson

;; Author:   Arni Magnusson
;; Version:  2.5
;; Keywords: languages

;;; Commentary:
;;
;; Major mode for editing AD Model Builder (ADMB) code. Provides syntax highlighting, IDE compilation and file
;; manipulation, outline code navigation, templates, and smaller tools. The syntax groups for highlighting are:
;;
;; Face                          Example
;; font-lock-comment-face        //
;; font-lock-doc-face            DATA_SECTION
;; font-lock-constant-face       LOCAL_CALCS
;; font-lock-type-face           int
;; font-lock-keyword-face        log
;; font-lock-builtin-face        objective_function_value
;; font-lock-function-name-face  [FUNCTION] myfunction
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
;;      (add-to-list 'auto-mode-alist '("\\.dat$" . R-mode))
;;
;; Customization:
;;
;; See documentation of variable `admb-mode-hook' and function `admb-outline' for ideas.
;;
;; Usage:
;;
;; See documentation of function `admb-mode'.
;;
;; Known bugs:
;;
;; // inside a string causes rest of line to be highlighted as comments
;; /* comments */ are not highlighted as comments

;;; History:
;;
;; 26 Aug 2003  0.9  Created main function `admb-mode', user variable `admb-mode-hook', and local variable
;;                   `font-lock-defaults'.
;; 25 Sep 2007  1.0  Added user functions `admb-template' and `admb-template-mini'.
;; 23 Jul 2008  1.1  Added user function `admb-outline'.
;; 28 Nov 2008  1.2  Added keywords "LOC_CALCS", "random_effects_vector", and "random_effects_matrix".
;; 11 Dec 2008  1.3  Added keyword "SEPERABLE_FUNCTION".
;; 28 Jan 2009  1.4  Added keyword "close", changed  face names, and released to ADMB Project.
;;  9 Mar 2009  2.0  Complete rewrite. Added user variables `admb-comp-command', `admb-link-command', `admb-make-command',
;;                   and `admb-tpl2cpp-command'. Added user functions `admb-clean', `admb-compile', `admb-cpp',
;;                   `admb-endl', `admb-for', `admb-link',  `admb-make', `admb-rep', `admb-run', `admb-run-args', and
;;                   `admb-tpl2cpp'. Added internal variables `admb-font-lock-keywords', `admb-mode-abbrev-table',
;;                   `admb-mode-map', and `admb-mode-syntax-table'. Added local variables `comment-start',
;;                   `imenu-generic-expression', `indent-line-function', and `outline-regexp'. Added keywords "4darray",
;;                   "5darray", "6darray", "7darray", "bool", "init_4darray", "init_5darray", "init_6darray",
;;                   "init_7darray", "normal_prior", "NORMAL_PRIOR_FUNCTION", "random_effects_bounded_matrix",
;;                   "random_effects_bounded_vector", and "sizeof". Added commentary on installation, customization, and
;;                   usage.
;; 20 Mar 2009  2.1  Added user variable `admb-window-right'. Improved screen output from user functions `admb-compile',
;;                   `admb-link', `admb-make', `admb-run', `admb-run-args', and `admb-tpl2cpp'. User function `admb-make'
;;                   saves buffer before calling `admb-make-command'. Added keyword "randnegbinomial". Bound
;;                   [C-c C-backspace] to `admb-clean', [C-c C-c] to `admb-make', [C-c C-j] to `admb-tpl2cpp', [C-c C-k] to
;;                   `admb-compile', and [C-c C-l] to `admb-link'.
;; 22 Mar 2009  2.2  Improved screen output from user functions `admb-run' and `admb-run-args'.
;; 27 Mar 2009  2.3  Improved screen output from user functions `admb-run' and `admb-run-args'.
;; 31 Mar 2009  2.4  Improved screen output from user functions `admb-run' and `admb-run-args'. Improved indendation.
;;  8 Apr 2009  2.5  Improved documentation strings of user variables and user functions.

;;; Code:

;; 1  Preamble

(require 'outline)
(defgroup admb nil "Major mode for editing AD Model Builder code." :tag "ADMB" :group 'languages)

;; 2  User variables

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
(defcustom admb-make-command "admake"
  "Shell command to build executable from TPL, using `admb-make'."
  :tag   "Make"
  :type  'string
  :group 'admb)
(defcustom admb-tpl2cpp-command "tpl2cpp"
  "Shell command to translate TPL to C++, using `admb-tpl2cpp'."
  :tag   "tpl2cpp"
  :type  'string
  :group 'admb)
(defcustom admb-window-right t
  "Non-nil means create secondary window (for compiling and running model) on the right, nil means below."
  :tag "Window right"
  :type 'boolean
  :group 'admb)
(defcustom admb-mode-hook nil
  "Hook for `admb-mode'.

If you want to set compilation commands, syntax colors, or keybindings, here is
an example that does that:

\(defun my-admb-hook ()
  (setq admb-comp-command \"myadcomp\")
  (setq admb-link-command \"myadlink\")
  (setq admb-make-command \"myadmake\")
  (setq admb-tpl2cpp-command \"mytpl2cpp\")
  (set-face-attribute 'font-lock-doc-face nil
                      :foreground \"black\" :weight 'bold)
  (set-face-attribute 'font-lock-function-name-face nil
                      :foreground \"brown\" :weight 'bold)
  (local-set-key [f9] 'admb-make)
  (local-set-key [down-mouse-3] 'imenu))
\(add-hook 'admb-mode-hook 'my-admb-hook)"
  :tag   "Hook"
  :type  'hook
  :group 'admb)

;; 3  User functions

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
(defun admb-compile () "Compile C++ to object code, using `admb-comp-command'." (interactive)
  (if (and admb-window-right (one-window-p))(split-window-horizontally))
  (compile (concat admb-comp-command " " (file-name-sans-extension (buffer-name))))(set-buffer "*compilation*")
  (setq show-trailing-whitespace nil))
(defun admb-cpp () "Open C++ file translated from TPL file." (interactive)
  (find-file (concat (file-name-sans-extension buffer-file-name) ".cpp")))
(defun admb-endl () "Insert << endl; (or just endl;) and newline." (interactive)
  (delete-horizontal-space)(if (string-equal (char-to-string (preceding-char)) "<")(insert " endl;")
                             (insert " << endl;")))
(defun admb-for () "Insert for(i=1; i<=; i++)." (interactive)(insert "for(i=1; i<=; i++)")(search-backward ";"))
(defun admb-link () "Link object code to executable, using `admb-link-command'." (interactive)
  (if (and admb-window-right (one-window-p))(split-window-horizontally))
  (compile (concat admb-link-command " " (file-name-sans-extension (buffer-name))))(set-buffer "*compilation*")
  (setq show-trailing-whitespace nil))
(defun admb-make () "Build executable from TPL, using `admb-make-comand'." (interactive)
  (save-buffer)(if (and admb-window-right (one-window-p))(split-window-horizontally))
  (compile (concat admb-make-command " " (file-name-sans-extension (buffer-name))))
  (set-buffer "*compilation*")(setq show-trailing-whitespace nil))
(defun admb-outline () "Navigate within ADMB file using `outline-mode'.

If you haven't already configured an `outline-mode-hook', here is an example
that makes it easy to return to `admb-mode':

\(defun my-outline-hook ()
  (local-set-key [mouse-1] 'outline-mouse-select)
  (local-set-key [return]  'admb-mode           )
  (defun outline-mouse-select ()
    \"Select position and return to `admb-mode'.\" (interactive)
    (admb-mode)(beginning-of-line)))
\(add-hook 'outline-mode-hook 'my-outline-hook)"
  (interactive)(let ((outreg outline-regexp))(outline-mode)(setq outline-regexp outreg))(outline-mode)(hide-body))
(defun admb-rep () "Open ADMB report file." (interactive)
  (browse-url (concat (file-name-sans-extension buffer-file-name) ".rep"))(message nil))
(defun admb-run () "Run ADMB program." (interactive)
  (let ((tpl-buffer (buffer-name))(resize-mini-windows nil))
    (if (and admb-window-right (one-window-p))(split-window-horizontally))
    (shell-command (file-name-sans-extension buffer-file-name))
    (select-window (get-buffer-window "*Shell Command Output*"))(setq show-trailing-whitespace nil)(goto-char (point-max))
    (recenter -3)(select-window (get-buffer-window tpl-buffer))))
(defun admb-run-args (args) "Run ADMB program with ARGS." (interactive "sArgs: ")
  (let ((tpl-buffer (buffer-name))(resize-mini-windows nil))
    (if (and admb-window-right (one-window-p))(split-window-horizontally))
    (shell-command (concat (file-name-sans-extension buffer-file-name) " " args))
    (select-window (get-buffer-window "*Shell Command Output*"))(setq show-trailing-whitespace nil)(goto-char (point-max))
    (recenter -3)(select-window (get-buffer-window tpl-buffer))))
(defun admb-template () "Insert AD Model Builder template." (interactive)
  (goto-char (point-min))(insert "
//-------------------------------------------------------------------------------------------------------------------------
// File:
// Model:
// Parameters:
// Fitted data:
// Likelihood:
// Notes:
// Warning:
// History:
//-------------------------------------------------------------------------------------------------------------------------

GLOBALS_SECTION
  #include <admodel.h>
  ofstream mcmc_report(\"mcmc.csv\");
  const double pi = 3.141592654;

DATA_SECTION
  init_int n
  init_vector X(1,n)
  init_vector Y(1,n)
  number halfnlog2pi
  int mcmc_report_lines

PARAMETER_SECTION
  init_number b0
  init_number b1
  init_number logsigmaMLE
  sdreport_number sigmaMLE
  vector Yfit(1,n)
  matrix summary(1,n,1,3)  // | X | Y | Yfit |
  objective_function_value neglogL

PRELIMINARY_CALCS_SECTION
  halfnlog2pi = 0.5*n*log(2*pi);
  mcmc_report_lines = 0;

PROCEDURE_SECTION
  Yfit = b0 + b1*X;
  sigmaMLE = mfexp(logsigmaMLE);
  neglogL = halfnlog2pi + n*log(sigmaMLE) + norm2(Y-Yfit)/(2*sigmaMLE*sigmaMLE);
  if(mceval_phase())
    write_mcmc();

FUNCTION write_mcmc
  if(mcmc_report_lines == 0)
    mcmc_report<<\"neglogL,b0,b1,sigmaMLE\"<<endl;
  mcmc_report<<neglogL<<\",\"<<b0<<\",\"<<b1<<\",\"<<sigmaMLE<<endl;
  mcmc_report_lines++;

FUNCTION get_summary
  summary.colfill(1,X);
  summary.colfill(2,Y);
  summary.colfill(3,Yfit);

REPORT_SECTION
  get_summary();
  report<<\"# b0\"      <<endl<<b0           <<endl
        <<\"# b1\"      <<endl<<b1           <<endl
        <<\"# RSS\"     <<endl<<norm2(Y-Yfit)<<endl
        <<\"# sigmaMLE\"<<endl<<sigmaMLE     <<endl
        <<\"# neglogL\" <<endl<<neglogL<<endl<<endl;
  report<<\"# Model summary\"<<endl
        <<\" X Y Yfit\"<<endl
        <<summary<<endl;
")(goto-char (point-min))(delete-char 1))
(defun admb-template-mini () "Insert minimal AD Model Builder template." (interactive)
  (goto-char (point-min))(insert "
DATA_SECTION
  init_int n
  init_vector X(1,n)
  init_vector Y(1,n)

PARAMETER_SECTION
  init_number b0
  init_number b1
  vector Yfit(1,n)
  objective_function_value RSS

PROCEDURE_SECTION
  Yfit = b0 + b1*X;
  RSS = norm2(Y-Yfit);
")(goto-char (point-min))(delete-char 1))
(defun admb-tpl2cpp () "Translate TPL to C++, using `admb-tpl2cpp-command'." (interactive)
  (save-buffer)(if (and admb-window-right (one-window-p))(split-window-horizontally))
  (compile (concat admb-tpl2cpp-command " " (file-name-sans-extension (buffer-name))))(set-buffer "*compilation*")
  (setq show-trailing-whitespace nil))

;; 4  Internal variables

(defvar admb-font-lock-keywords
  (eval-when-compile
    (let ((SECTIONS
           '("^DATA_SECTION"                      "^INITIALIZATION_SECTION"            "^PARAMETER_SECTION"
             "^PRELIMINARY_CALCS_SECTION"         "^PROCEDURE_SECTION"                 "^FUNCTION"
             "^SEPARABLE_FUNCTION"                "^REPORT_SECTION"                    "^RUNTIME_SECTION"
             "^TOP_OF_MAIN_SECTION"               "^GLOBALS_SECTION"                   "^BETWEEN_PHASES_SECTION"
             "^NORMAL_PRIOR_FUNCTION"             "^FINAL_SECTION"))
          (LOCAL
           '("LOC_CALCS"                          "LOCAL_CALCS"                        "END_CALCS"
             "USER_CODE"))
          (DATATYPES
           '( ;; C++ and Autodif
             "_CONST"                             "adstring"                           "argc"
             "argv"                               "bool"                               "char"
             "CLASS"                              "const"                              "double"
             "dvariable"                          "dvar_vector"                        "dvar_matrix"
             "dvar3_array"                        "dvector"                            "dmatrix"
             "d3_array"                           "ios"                                "long"
             "signed"                             "unsigned"                           "void"
             ;; Input data
             "init_int"                           "init_ivector"                       "init_imatrix"
             "init_number"                        "init_vector"                        "init_matrix"
             "init_bounded_number"                "init_bounded_vector"                "init_bounded_matrix"
             "init_vector_vector"                 "init_matrix_vector"                 "init_bounded_number_vector"
             "init_bounded_vector_vector"         "init_bounded_matrix_vector"         "init_adstring"
             "init_bounded_dev_vector"            "init_3darray"                       "init_4darray"
             "init_5darray"                       "init_6darray"                       "init_7darray"
             ;; Plain variables
             "int"                                "ivector"                            "imatrix"
             "number"                             "vector"                             "matrix"
             "3darray"                            "4darray"                            "5darray"
             "6darray"                            "7darray"                            "dev_vector"
             ;; Random effects
             "normal_prior"                       "random_effects_vector"              "random_effects_bounded_vector"
             "random_effects_matrix"              "random_effects_bounded_matrix"
             ;; Special objects
             "banded_lower_triangular_dvar_matrix" "banded_symmetric_dvar_matrix"      "constant_model_parameters"
             "dvar_vector_position"               "dvar_matrix_position"               "extern"
             "fmm"                                "funnel_dvariable"                   "independent_variables"
             "model_data"                         "model_parameters"                   "prevariable"
             "likeprof_number"                    "random_number_generator"            "sdreport_number"
             "sdreport_vector"                    "sdreport_matrix"                    "variable_model_parameters"))
          (FUNCTIONS
           '( ;; C++
             "allocated"                          "atof"                               "atoi"
             "break"                              "case"                               "cerr"
             "cin"                                "cout"                               "default"
             "define"                             "if"                                 "else"
             "endif"                              "endl"                               "for"
             "goto"                               "open"                               "printf"
             "return"                             "setf"                               "setfixed"
             "setprecision"                       "setw"                               "setscientific"
             "sizeof"                             "sprintf"                            "strcat"
             "strcpy"                             "strlen"                             "switch"
             "undef"                              "while"
             ;; Basic math
             "abs"                                "ceil"                               "exp"
             "fabs"                               "floor"                              "gammln"
             "log"                                "log10"                              "log_comb"
             "mfexp"                              "modf"                               "posfun"
             "pow"                                "sfabs"                              "square"
             "sqrt"
             ;; Trigonometry
             "acos"                               "asin"                               "atan"
             "cos"                                "cosh"                               "sin"
             "sinh"                               "tan"                                "tanh"
             ;; Random variates and density
             "betai"                              "cumd_cauchy"                        "cumd_norm"
             "inv_cumd_cauchy"                    "inv_cumd_norm"                      "randn"
             "randnegbinomial"                    "randpoisson"                        "randu"
             ;; Vectors and matrices, basics
             "colsum"                             "column"                             "elem_div"
             "elem_prod"                          "extract_column"                     "extract_row"
             "max"                                "mean"                               "min"
             "row"                                "rowsum"                             "size_count"
             "sort"                               "std_dev"                            "sum"
             "trans"
             ;; Vectors and matrices, linear algebra
             "choleski_decomp"                    "det"                                "eigenvalues"
             "eigenvectors"                       "empirical_covariance"               "extract_diagonal"
             "identity_matrix"                    "inv"                                "ln_det"
             "norm"                               "norm2"                              "outer_prod"
             "regression"                         "robust_regression"                  "solve"
             ;; Dot methods
             "fill"                               "fill_multinomial"                   "fill_seqadd"
             "fill_randbi"                        "fill_randn"                         "fill_randn_ni"
             "fill_randpoisson"                   "fill_randu"                         "fill_randu_ni"
             "indexmax"                           "indexmin"                           "initialize"
             ;; Dot methods, col*, row*, and slice*
             "colfill"                            "colfill_randn"                      "colfill_randu"
             "colfill_seqadd"                     "colmax"                             "colmin"
             "colshift"                           "colsize"                            "rowfill"
             "rowfill_randn"                      "rowfill_randu"                      "rowfill_seqadd"
             "rowmax"                             "rowmin"                             "rowshift"
             "rowsize"                            "slicemax"                           "slicemin"
             "sliceshift"                         "slicesize"
             ;; Phases
             "active"                             "current_phase"                      "initial_params"
             "last_phase"                         "mceval_phase"                       "sd_phase"
             ;; Adjoint code
             "AD_SET_DERIVATIVES"                 "AD_SET_DERIVATIVES2"                "AD_SET_DERIVATIVES4"
             "ADJOINT_CODE"                       "elem"                               "elem_value"
             "restore_dvar_vector_position"       "restore_dvar_vector_value"          "restore_dvar_matrix_position"
             "restore_dvar_matrix_value"          "save_dvar_vector_position"          "save_dvar_vector_value"
             "save_dvector_derivatives"           "save_dmatrix_derivatives"           "save_dvar_matrix_position"
             "save_identifier_string"             "set_value"                          "size"
             "sub"                                "value"                              "verify_identifier_string"
             ;; Special functions
             "ad_printf"                          "ad_begin_funnel"                    "ad_exit"
             "adromb"                             "boundp"                             "boundpin"
             "gradcalc"                           "histogram"                          "mf_upper_bound"
             "open"                               "option_match"                       "set_stepnumber"
             "set_stepsize"                       "shift"))
          (IMPORTANT
           '( ;; Shell
             "exit"                               "system"
             ;; File input/output
             "ad_comm"                            "adprogram_name"                     "close"
             "ifstream"                           "ofstream"                           "open"
             "report"                             "uistream"                           "uostream"
             ;; Allocations (TOP_OF_MAIN_SECTION)
             "arrmblsize"                         "gradient_structure"
             ;; Minimization settings
             "convergence_criteria"               "objective_function_value"           "maximum_function_evaluations"
             ;; Adjoint code (GLOBALS_SECTION)
             "#include"                           "RETURN_ARRAYS_DECREMENT"            "RETURN_ARRAYS_INCREMENT")))
      (list
       '("//.*" (0 font-lock-comment-face t))
       '("^FUNCTION[ \t]+\\([a-zA-Z0-9_]+\\)" (1 font-lock-function-name-face))
       (cons (concat "\\<\\(" (mapconcat 'eval SECTIONS "\\|") "\\)\\>") font-lock-doc-face)
       (cons (regexp-opt LOCAL     'words) font-lock-constant-face)
       (cons (regexp-opt DATATYPES 'words) font-lock-type-face)
       (cons (regexp-opt FUNCTIONS 'words) font-lock-keyword-face)
       (cons (regexp-opt IMPORTANT 'words) font-lock-builtin-face)))))
(defvar admb-mode-abbrev-table nil)(define-abbrev-table 'admb-mode-abbrev-table ())
(defvar admb-mode-map
  ;; Special   C-c C-        h
  ;; Custom    C-c C- a cd f   jkl  o      v
  ;; Available C-c C-  b  e g i   mn pqrstu wxyz
  (let ((map (make-sparse-keymap)))
    (define-key map [f11]               'admb-outline      )
    (define-key map [f12]               'admb-template     )
    (define-key map [S-f12]             'admb-template-mini)
    (define-key map [tab]               'indent-relative   )
    (define-key map [C-return]          'admb-endl         )
    (define-key map [M-return]          'admb-endl         )
    (define-key map [S-return]          'admb-endl         )
    (define-key map [?\C-c C-backspace] 'admb-clean        )
    (define-key map [?\C-c ?\C-a]       'admb-run-args     )
    (define-key map [?\C-c ?\C-c]       'admb-make         )
    (define-key map [?\C-c ?\C-d]       'admb-cpp          )
    (define-key map [?\C-c ?\C-f]       'admb-for          )
    (define-key map [?\C-c ?\C-j]       'admb-tpl2cpp      )
    (define-key map [?\C-c ?\C-k]       'admb-compile      )
    (define-key map [?\C-c ?\C-l]       'admb-link         )
    (define-key map [?\C-c ?\C-o]       'admb-rep          )
    (define-key map [?\C-c ?\C-v]       'admb-run          )
    map))
(defvar admb-mode-syntax-table
  (let ((table (make-syntax-table)))
    (modify-syntax-entry ?# "w" table)
    (modify-syntax-entry ?_ "w" table)
    table))

;; 5  Main function

(defun admb-mode () "Major mode for editing AD Model Builder code.

Start a new model from `admb-template' or `admb-template-mini'. Navigate between
sections using `admb-outline', `imenu', or `outline-minor-mode'. Use `admb-endl'
and `admb-for' to save keystrokes.

Compile using `admb-make', or `admb-tpl2cpp', `admb-compile', and `admb-link'.
To enable the random-effects or safe libraries, set the variables
`admb-comp-command',`admb-link-command',`admb-make-command', and
`admb-tpl2cpp-command' accordingly. Set `admb-window-right' to your viewing
preference. After compiling,use `admb-cpp' to debug, `admb-clean' to remove
temporary files,`admb-run' or `admb-run-args' to run, and `admb-rep' to view
model output.

\\{admb-mode-map}"
  (interactive)(kill-all-local-variables)(setq major-mode 'admb-mode)(setq mode-name "ADMB")
  (set (make-local-variable 'comment-start) "//")
  (set (make-local-variable 'font-lock-defaults) '(admb-font-lock-keywords nil t nil))
  (set (make-local-variable 'imenu-generic-expression) '((nil "^[A-Z].*" 0)))
  (set (make-local-variable 'indent-line-function) 'indent-relative)
  (set (make-local-variable 'outline-regexp) "[A-Z]")
  (set (make-local-variable 'tab-stop-list) '(2)) ; first line in section
  (set-syntax-table admb-mode-syntax-table)
  (setq local-abbrev-table admb-mode-abbrev-table)
  (use-local-map admb-mode-map)
  (run-mode-hooks 'admb-mode-hook))

(provide 'admb)

;;; admb.el ends here
