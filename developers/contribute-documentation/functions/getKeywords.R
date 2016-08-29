getKeywords <- function(outfile, admb.el="http://admb-project.org/community/editing-tools/emacs/admb.el")
########################################################################################################################
###                                                                                                                    #
### Function: getKeywords                                                                                              #
###                                                                                                                    #
### Purpose:  Get ADMB keywords from admb.el and write them to plain text file                                         #
###                                                                                                                    #
### Args:     outfile is the output filename                                                                           #
###           admb.el is the path to admb.el                                                                           #
###                                                                                                                    #
### History:  30 Nov 2010 Arni Magnusson improved grep matching                                                        #
###           20 Apr 2010 Arni Magnusson released                                                                      #
###                                                                                                                    #
### Returns:  Null, but creates a plain text file containing keywords                                                  #
###                                                                                                                    #
########################################################################################################################
{
  if(missing(outfile))
    stop("Please pass output filename as 1st arg, e.g. getKeywords(\"keywords.txt\")")

  lisp <- readLines(admb.el)
  version.line <- lisp[grep("Version:",lisp)]
  version <- substring(version.line, regexpr("[0-9]",version.line))
  date.line <- lisp[grep("History:",lisp)[1] + 2]
  date <- sub("^ ", "", substring(date.line,4,14))
  beg <- grep("defvar admb-font-lock-keywords",lisp) + 2
  end <- grep("      \\(list",lisp) - 1
  words <- lisp[beg:end]

  words <- substring(words, 12)             # remove first 11 columns
  words <- gsub("'\\(", "  ", words)        # remove '(
  words <- gsub("\\^", "", words)           # remove ^
  words <- gsub("\"\\)*", "\"", words)      # remove )
  words <- gsub(" ;;", "", words)           # remove ;;
  words <- gsub("^  \"", "    ", words)     # remove leading quotes
  words <- gsub("\" +\"", "\n    ", words)  # replace intermediate quotes with newline
  words <- gsub("\"$", "", words)           # remove trailing quotes

  write(paste("ADMB keywords extracted from admb.el, version", version, "from", date), file=outfile)
  write("Keywords start in column 4, separated by labels", file=outfile, append=TRUE)
  write("Arni Magnusson collected these keywords by looking through various models", file=outfile, append=TRUE)
  write(paste(rep("-",80),collapse=""), file=outfile, append=TRUE)
  write(words, file=outfile, append=TRUE)
}
