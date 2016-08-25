;;; admb.el --- major mode for editing AD Model Builder code

;; Author:     Arni Magnusson
;; Created:    26 Aug 2003
;; Version:    1.4
;; Keywords:   ad model builder, admb, languages

;;; Commentary:

;; Major mode for editing AD Model Builder (ADMB) code. Provides syntax highlighting and a customizable admb-mode-hook.
;; The syntax groups for highlighting are:
;;
;; Face                          Example
;; font-lock-comment-face        //
;; font-lock-doc-face            DATA_SECTION
;; font-lock-warning-face        LOCAL_CALCS
;; font-lock-type-face           int
;; font-lock-keyword-face        abs
;; font-lock-builtin-face        objective_function_value
;; font-lock-function-name-face  [FUNCTION] myfunction
;;
;; Known bugs: // inside a string causes rest of line to be rendered in font-lock-comment-face
;;             /* and */ are not recognized as comment delimiters

;;; History:

;; 26 Aug 2003  0.9  Implemented syntax highlighting and defined admb-mode-hook
;; 25 Sep 2007  1.0  Moved 'admb-mode' from .emacs to a separate admb.el file
;; 23 Jul 2008  1.1  Added 'admb-outline'
;; 28 Nov 2008  1.2  Added 'LOC_CALCS', 'random_effects_vector', and 'random_effects_matrix'
;; 11 Dec 2008  1.3  Added 'SEPERABLE_FUNCTION'
;; 28 Jan 2009  1.4  Added 'close', changed category names, and released to admb-project.org

;;; Code:

(defun admb-mode () "Major mode for editing ADMB code." (interactive)
  (kill-all-local-variables)(setq major-mode 'admb-mode)(setq mode-name "ADMB")
  (set (make-local-variable 'font-lock-defaults) '(admb-font-lock-keywords nil t nil))
  (modify-syntax-entry ?# "w") ; interpret # as a word character when highlighting syntax
  (modify-syntax-entry ?_ "w") ; interpret _ as a word character when highlighting syntax
  (defvar admb-font-lock-keywords
    (eval-when-compile
      (list
       '("//.*" (0 font-lock-comment-face t))
       (cons (concat ; SECTIONS
              "\\<\\(" "^DATA_SECTION"              "\\|" "^INITIALIZATION_SECTION"    "\\|" "^PARAMETER_SECTION"
              "\\|"    "^PRELIMINARY_CALCS_SECTION" "\\|" "^PROCEDURE_SECTION"         "\\|" "^FUNCTION"
              "\\|"    "^SEPARABLE_FUNCTION"        "\\|" "^REPORT_SECTION"            "\\|" "^RUNTIME_SECTION"
              "\\|"    "^TOP_OF_MAIN_SECTION"       "\\|" "^GLOBALS_SECTION"           "\\|" "^BETWEEN_PHASES_SECTION"
              "\\|"    "^FINAL_SECTION"
              "\\)\\>") 'font-lock-doc-face)
       (cons (concat ; LOCAL CALCS
              "\\<\\(" "LOC_CALCS"                  "\\|" "LOCAL_CALCS"                "\\|" "END_CALCS"
              "\\|"    "USER_CODE"
              "\\)\\>") 'font-lock-constant-face)
       (cons (concat ; DATA TYPES
              ;; C++ and Autodif
              "\\<\\(" "_CONST"                     "\\|" "adstring"                   "\\|" "argc"
              "\\|"    "argv"                       "\\|" "char"                       "\\|" "CLASS"
              "\\|"    "const"                      "\\|" "double"                     "\\|" "dvariable"
              "\\|"    "dvar_vector"                "\\|" "dvar_matrix"                "\\|" "dvar3_array"
              "\\|"    "dvector"                    "\\|" "dmatrix"                    "\\|" "d3_array"
              "\\|"    "ios"                        "\\|" "long"                       "\\|" "signed"
              "\\|"    "unsigned"                   "\\|" "void"
              ;; Input data
              "\\|"    "init_int"                   "\\|" "init_ivector"               "\\|" "init_imatrix"
              "\\|"    "init_number"                "\\|" "init_vector"                "\\|" "init_matrix"
              "\\|"    "init_bounded_number"        "\\|" "init_bounded_vector"        "\\|" "init_bounded_matrix"
              "\\|"    "init_vector_vector"         "\\|" "init_matrix_vector"         "\\|" "init_bounded_number_vector"
              "\\|"    "init_bounded_vector_vector" "\\|" "init_bounded_matrix_vector" "\\|" "init_adstring"
              "\\|"    "init_bounded_dev_vector"    "\\|" "init_3darray"
              ;; Plain variables
              "\\|"    "int"                        "\\|" "ivector"                    "\\|" "imatrix"
              "\\|"    "number"                     "\\|" "vector"                     "\\|" "matrix"
              "\\|"    "3darray"                    "\\|" "dev_vector"
              ;; Random effects
              "\\|"    "random_effects_vector"      "\\|" "random_effects_matrix"
              ;; Special objects
              "\\|"    "banded_lower_triangular_dvar_matrix"                           "\\|" "banded_symmetric_dvar_matrix"
              "\\|"    "constant_model_parameters"  "\\|" "dvar_vector_position"       "\\|" "dvar_matrix_position"
              "\\|"    "extern"                     "\\|" "fmm"                        "\\|" "funnel_dvariable"
              "\\|"    "independent_variables"      "\\|" "model_data"                 "\\|" "model_parameters"
              "\\|"    "prevariable"                "\\|" "likeprof_number"            "\\|" "random_number_generator"
              "\\|"    "sdreport_number"            "\\|" "sdreport_vector"            "\\|" "sdreport_matrix"
              "\\|"    "variable_model_parameters"
              "\\)\\>") 'font-lock-type-face)
       (cons (concat ; FUNCTIONS
              ;; C++
              "\\<\\(" "allocated"                  "\\|" "atof"                       "\\|" "atoi"
              "\\|"    "break"                      "\\|" "case"                       "\\|" "cerr"
              "\\|"    "cin"                        "\\|" "cout"                       "\\|" "default"
              "\\|"    "define"                     "\\|" "if"                         "\\|" "else"
              "\\|"    "endif"                      "\\|" "endl"                       "\\|" "for"
              "\\|"    "goto"                       "\\|" "open"                       "\\|" "printf"
              "\\|"    "return"                     "\\|" "setf"                       "\\|" "setfixed"
              "\\|"    "setprecision"               "\\|" "setw"                       "\\|" "setscientific"
              "\\|"    "sprintf"                    "\\|" "strcat"                     "\\|" "strcpy"
              "\\|"    "strlen"                     "\\|" "switch"                     "\\|" "undef"
              "\\|"    "while"
              ;; Basic math
              "\\|"    "abs"                        "\\|" "ceil"                       "\\|" "exp"
              "\\|"    "fabs"                       "\\|" "floor"                      "\\|" "gammln"
              "\\|"    "log"                        "\\|" "log10"                      "\\|" "log_comb"
              "\\|"    "mfexp"                      "\\|" "modf"                       "\\|" "posfun"
              "\\|"    "pow"                        "\\|" "sfabs"                      "\\|" "square"
              "\\|"    "sqrt"
              ;; Trigonometry
              "\\|"    "acos"                       "\\|" "asin"                       "\\|" "atan"
              "\\|"    "cos"                        "\\|" "cosh"                       "\\|" "sin"
              "\\|"    "sinh"                       "\\|" "tan"                        "\\|" "tanh"
              ;; Random variates and density
              "\\|"    "betai"                      "\\|" "cumd_cauchy"                "\\|" "cumd_norm"
              "\\|"    "inv_cumd_cauchy"            "\\|" "inv_cumd_norm"              "\\|" "randn"
              "\\|"    "randpoisson"                "\\|" "randu"
              ;; Vectors and matrices, basics
              "\\|"    "colsum"                     "\\|" "column"                     "\\|" "elem_div"
              "\\|"    "elem_prod"                  "\\|" "extract_column"             "\\|" "extract_row"
              "\\|"    "max"                        "\\|" "mean"                       "\\|" "min"
              "\\|"    "row"                        "\\|" "rowsum"                     "\\|" "size_count"
              "\\|"    "sort"                       "\\|" "std_dev"                    "\\|" "sum"
              "\\|"    "trans"
              ;; Vectors and matrices, linear algebra
              "\\|"    "choleski_decomp"            "\\|" "det"                        "\\|" "eigenvalues"
              "\\|"    "eigenvectors"               "\\|" "empirical_covariance"       "\\|" "extract_diagonal"
              "\\|"    "identity_matrix"            "\\|" "inv"                        "\\|" "ln_det"
              "\\|"    "norm"                       "\\|" "norm2"                      "\\|" "outer_prod"
              "\\|"    "regression"                 "\\|" "robust_regression"          "\\|" "solve"
              ;; Dot methods
              "\\|"    "fill"                       "\\|" "fill_multinomial"           "\\|" "fill_seqadd"
              "\\|"    "fill_randbi"                "\\|" "fill_randn"                 "\\|" "fill_randn_ni"
              "\\|"    "fill_randpoisson"           "\\|" "fill_randu"                 "\\|" "fill_randu_ni"
              "\\|"    "indexmax"                   "\\|" "indexmin"                   "\\|" "initialize"
              ;; Dot methods, col*, row*, and slice*
              "\\|"    "colfill"                    "\\|" "colfill_randn"              "\\|" "colfill_randu"
              "\\|"    "colfill_seqadd"             "\\|" "colmax"                     "\\|" "colmin"
              "\\|"    "colshift"                   "\\|" "colsize"                    "\\|" "rowfill"
              "\\|"    "rowfill_randn"              "\\|" "rowfill_randu"              "\\|" "rowfill_seqadd"
              "\\|"    "rowmax"                     "\\|" "rowmin"                     "\\|" "rowshift"
              "\\|"    "rowsize"                    "\\|" "slicemax"                   "\\|" "slicemin"
              "\\|"    "sliceshift"                 "\\|" "slicesize"
              ;; Phases
              "\\|"    "active"                     "\\|" "current_phase"              "\\|" "initial_params"
              "\\|"    "last_phase"                 "\\|" "mceval_phase"               "\\|" "sd_phase"
              ;; Adjoint code
              "\\|"    "AD_SET_DERIVATIVES"         "\\|" "AD_SET_DERIVATIVES2"        "\\|" "AD_SET_DERIVATIVES4"
              "\\|"    "ADJOINT_CODE"               "\\|" "elem"                       "\\|" "elem_value"
              "\\|"    "restore_dvar_vector_position"                                  "\\|" "restore_dvar_vector_value"
              "\\|"    "restore_dvar_matrix_position"                                  "\\|" "restore_dvar_matrix_value"
              "\\|"    "save_dvar_vector_position"  "\\|" "save_dvar_vector_value"     "\\|" "save_dvector_derivatives"
              "\\|"    "save_dmatrix_derivatives"   "\\|" "save_dvar_matrix_position"  "\\|" "save_identifier_string"
              "\\|"    "set_value"                  "\\|" "size"                       "\\|" "sub"
              "\\|"    "value"                      "\\|" "verify_identifier_string"
              ;; Special functions
              "\\|"    "*ad_printf"                 "\\|" "ad_begin_funnel"            "\\|" "ad_exit"
              "\\|"    "adromb"                     "\\|" "boundp"                     "\\|" "boundpin"
              "\\|"    "gradcalc"                   "\\|" "histogram"                  "\\|" "mf_upper_bound"
              "\\|"    "open"                       "\\|" "option_match"               "\\|" "set_stepnumber"
              "\\|"    "set_stepsize"               "\\|" "shift"
              "\\)\\>") 'font-lock-keyword-face)
       (cons (concat ; VARIOUS KEYWORDS TO HIGHLIGHT
              ;; Shell
              "\\<\\(" "exit"                       "\\|" "system"
              ;; File input/output
              "\\|"    "ad_comm"                    "\\|" "adprogram_name"             "\\|" "close"
              "\\|"    "ifstream"                   "\\|" "ofstream"                   "\\|" "open"
              "\\|"    "report"                     "\\|" "uistream"                   "\\|" "uostream"
              ;; Allocations (TOP_OF_MAIN_SECTION)
              "\\|"    "arrmblsize"                 "\\|" "gradient_structure"
              ;; Minimization settings
              "\\|"    "convergence_criteria"       "\\|" "objective_function_value"   "\\|" "maximum_function_evaluations"
              ;; Adjoint code (GLOBALS_SECTION)
              "\\|"    "#include"                   "\\|" "RETURN_ARRAYS_DECREMENT"    "\\|" "RETURN_ARRAYS_INCREMENT"
              "\\)\\>") 'font-lock-builtin-face)
       '( "\\<FUNCTION\\>[ \t]*\\([a-zA-Z0-9_]+\\)" (1 font-lock-function-name-face)))))
  (defun admb-outline () "Navigate within ADMB file using outline-mode." (interactive)
    (outline-mode)(setq outline-regexp "[A-Z]")(outline-mode)(hide-body))
  (defun admb-template-mini () "Insert minimal AD Model Builder template." (interactive)
    (goto-char (point-min))(insert "
DATA_SECTION
  init_int n
  init_vector X(1,n)
  init_vector Y(1,n)\n
PARAMETER_SECTION
  init_number b0
  init_number b1
  vector Yfit(1,n)
  objective_function_value RSS\n
PROCEDURE_SECTION
  Yfit = b0 + b1*X;
  RSS = norm2(Y-Yfit);
")(goto-char (point-min))(delete-char 1))
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
  (run-hooks 'admb-mode-hook))
(defvar admb-mode-hook nil "Hook for admb-mode.")

(provide 'admb)

;;; admb.el ends here
