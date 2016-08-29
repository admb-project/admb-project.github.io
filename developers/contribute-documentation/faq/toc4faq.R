toc4faq <-
  function(htmlfile="c:/admb/FAQ/ADMB-FAQ.html",
           newfile='c:/admb/FAQ/ADMB-FAQ_new.html',
           replace=FALSE)

{
################################################################################
#
# toc4faq
#
# Purpose: To add a table of contents to the HTML file ADMB Frequently Asked Questions
# Written: Ian Taylor, NOAA NWFSC. Ian.Taylor-at-noaa.gov
# Returns: Writes file to newfile
#
################################################################################

  fullfaq <- readLines(htmlfile)
  faq <- fullfaq[grep('Start of FAQ',fullfaq):grep('End of FAQ',fullfaq)]

  # get heading lines from body of FAQ
  headings <- faq[sort(c(grep('<h1>',faq),grep('<h2>',faq)))]
  n <- length(headings)

  # make a data frame of key elements
  df <- data.frame(type=rep(NA,n),anchors=NA,titles=NA)
  df$type[grep("<h1>",headings)] <- "h1"
  df$type[grep("<h2>",headings)] <- "h2"
  for(i in 1:n){
    string <- headings[i]
    string <- strsplit(strsplit(string,'name=\"')[[1]][2],"</a>")[[1]][1]
    string <- strsplit(string,'\">')[[1]]
    df$anchors[i] <- string[1]
    df$titles[i] <- string[2]
  }

  # write a table of contents
  toc <- c("    <!-- Table of Contents -->","    <ul>")
  for(i in 1:n){
    newline <- paste('      <li><a href="#',df$anchors[i],'">',df$titles[i],'</a>',sep='')
    if(df$type[i]=="h2") newline <- paste("    ",newline,'</li>',sep="")
    toc <- c(toc,newline)
    if(i<n){
      if(df$type[i]=="h1" & df$type[i+1]=="h2") toc <- c(toc,"        <ol>")
      if(df$type[i]=="h2" & df$type[i+1]=="h1") toc <- c(toc,"        </ol>","      </li>")
    }
    if(i==n & df$type[i]=="h2") toc <- c(toc,"        </ol>","      </li>")
  }
  toc <- c(toc,"    </ul>","    <!-- end of Table of Contents -->")

  newfaq <- c('    <p>If you have ideas for additions or modifications, please send them to',
              '      <a href="mailto:Ian.Taylor@noaa.gov">Ian.Taylor@noaa.gov</a>.<br>',
              '      ADMB developers with editing privileges are welcome',
              '      to make changes, but should read the ',
              '      <a href="developers/faq/faqediting">Note on Editing the FAQ</a>',
              '      before doing so.</p>',
              '',
              '    <!-- ===================================================',
              '         Table of Contents in this file were created using',
              '         the custom toc4faq function in R',
              paste('         creation date:',as.character(Sys.time())),
              '         =================================================== -->',
              '',
              toc, # the new table of contents
              '',
              '    <hr />',
              faq, # the old guts
              '    <!-- ====================================================================',
              '    copyright, disclaimers, and whatnot should go down here',
              '',
              '    ==================================================================== -->')
  if(file.exists(newfile)){
    if(!replace){
      stop(paste("File exists:",newfile,"Set 'replace=TRUE' to overwrite"))
    }else{
      print(paste("Replacing file:",newfile),quote=FALSE)
      file.remove(newfile)
    }      
  }else{
    print(paste("Writing new html file:",newfile),quote=FALSE)
  }    
  writeLines(newfaq, newfile)
  return(invisible(newfaq))
}
