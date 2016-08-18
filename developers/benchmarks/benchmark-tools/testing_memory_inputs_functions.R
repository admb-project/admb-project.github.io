# A set of functions by Ian Taylor and Allan Hicks
# for testing memory use of ADMB executables
# last modified: 8/16/2010

### example use
# > mytest = runtest(folder='c:/SS/SSv3.10b/simple/',executable="SS3.exe")  # run test in the chosen directory
# > mymatrices = createMatrices.fn(mytest)             # make matrices from results of runtest
# > makeMemTestplots.fn(mymatrices)                    # make plots from matrices

# > graphics.off() #to close all graphics windows

runCmd.fn <- function(command,exec,sampTime) {
    # this is the function that runs the executable and monitors the memory use and temporary file sizes
  
    memsize <- cmpdiff <- gradfil1 <- gradfil2 <- NA  #if the executable fails
    # the following group of commands are specific to Windows operating systems
    if(Sys.info()["sysname"] == "Windows") {
        system(command,wait=F)
        Sys.sleep(sampTime)
        cmdTask <- paste('tasklist /fi "imagename eq',exec,'"')
        x <- system(cmdTask,intern=T) #don't pipe this to memwin because need output. Plus system doesn't like piping
        if(length(x)>4){
            stop(paste("it appears that more than one process is going simultaneously: \n",paste(x,collapse="\n"),"\n"))
        }else{
            x <- x[4]
        }
        
        y <- strsplit(x,' ')[[1]]
        if(!is.na(y) && tolower(y[1]) == tolower(exec)) {
            z <- strsplit(y[length(y)-1],",")
            memsize <- as.numeric(paste(z[[1]],collapse=""))
            file.access(c('cmpdiff.tmp','gradfil1.tmp','gradfil1.tmp'))  #use file access to make sure that Windows refreshes the files and correctly determines their size. Realy wierd behavior and uncertain without this.
            cmpdiff <- file.info('cmpdiff.tmp')$size/1024
            gradfil1 <- file.info('gradfil1.tmp')$size/1024
            gradfil2 <- file.info('gradfil2.tmp')$size/1024
        }
        while(!is.na(y) && tolower(y[1]) == tolower(exec)) {
            Sys.sleep(sampTime)
            x <- system(cmdTask,intern=T) #don't pipe this to memwin because need output. Plus system doesn't like piping
            if(length(x)>4){
            stop(paste("it appears that more than one process is going simultaneously: \n",paste(x,collapse="\n"),"\n"))
            }else{
                x <- x[4]
            }
            y <- strsplit(x,' ')[[1]]
            if(!is.na(y) && tolower(y[1]) == tolower(exec)) {
                z <- strsplit(y[length(y)-1],",")
                memsize <- c(memsize,as.numeric(paste(z[[1]],collapse="")))
                file.access(c('cmpdiff.tmp','gradfil1.tmp','gradfil1.tmp'))  #use file access to make sure that Windows refreshes the files and correctly determines their size. Realy wierd behavior and uncertain without this.
                cmpdiff <- c(cmpdiff,file.info('cmpdiff.tmp')$size/1024)
                gradfil1 <- c(gradfil1,file.info('gradfil1.tmp')$size/1024)
                gradfil2 <- c(gradfil2,file.info('gradfil2.tmp')$size/1024)
            }
        }
    }
    # the following group of commands are specific to Linux operating systems
    if(Sys.info()["sysname"] == "Linux") {
        system(paste("./",command,sep=""),wait=F)
        Sys.sleep(sampTime)
        cmdTask <- paste('ps -C',exec,'-o rss')
        x <- system(cmdTask,intern=T)  #don't pipe this to memwin because need output. Plus system doesn't like piping
        if(length(x) > 2){
            stop(paste("it appears that more than one process is going simultaneously: \n",paste(x,collapse="\n"),"\n"))
        }else{
            x <- as.numeric(x[2])
        }
        if(!is.na(x)) {
            memsize <- x
            cmpdiff <- file.info('cmpdiff.tmp')$size/1024
            gradfil1 <- file.info('gradfil1.tmp')$size/1024
            gradfil2 <- file.info('gradfil2.tmp')$size/1024
        }
        while(!is.na(x)) {
            Sys.sleep(sampTime)
            x <- system(cmdTask,intern=T)   #don't pipe this to memwin because need output. Plus system doesn't like piping
            if(length(x) > 2){
                stop(paste("it appears that more than one process is going simultaneously: \n",paste(x,collapse="\n"),"\n"))
            }else{
                x <- as.numeric(x[2])
            }
            if(!is.na(x)) {
                memsize <- c(memsize,x)
                cmpdiff <- c(cmpdiff,file.info('cmpdiff.tmp')$size/1024)
                gradfil1 <- c(gradfil1,file.info('gradfil1.tmp')$size/1024)
                gradfil2 <- c(gradfil2,file.info('gradfil2.tmp')$size/1024)
            }
        }
    }
    return(data.frame(memsize=memsize,cmpdiff=cmpdiff,gradfil1=gradfil1,gradfil2=gradfil2))
}


runtest <- function(gbs=10^seq(5,8,1),cbs=10^seq(5,8,1),folder="C:/myfolder/",executable="",addCmdOpt="",
                    repfile="Report.sso",memSampTime=3,maxfn=20,verbose=T,clean=F,extrasaves=T,
                    overwrite=F,minRunTime=3){
    # run the memory testing for given vectors of gbs and cbs inputs
    print(folder)
    setwd(folder)
    if(file.exists(repfile) & !overwrite) stop(paste(repfile,"exists and you have overwrite=FALSE"))
    if(!file.exists(executable)) stop(paste("The executable",executable,"is not present in the specified directory:",folder))
      
    runTimeWarning <- memSampWarning <- F
    # delete output file which contains run time
    if(file.exists(repfile)) file.remove(repfile)
    # if requested, delete any report files that match the pattern according to the function below
    if(clean) clean.fn()
    
    if(is.null(gbs) | is.null(cbs)) {
        stop("need to provide input values for both 'gbs' and 'cbs'")
    }else{
        runNum <- 0
        memsize <- cmpdiff <- gradfil1 <- gradfil2 <- vector(length(gbs)*length(cbs),mode="list")
        output <- vector(length(gbs)*length(cbs),mode="list")
        for(i in 1:length(gbs)) {
            for(j in 1:length(cbs)) {
                runNum <- runNum+1
                gbsVal <- format(gbs[i],scientific=F)
                cbsVal <- format(cbs[j],scientific=F)
                names(output)[runNum] <- paste("gbs",gbs[i],"cbs",cbs[j],sep="")
                cmd <- paste(executable,"-phase 99 -maxfn",maxfn,"-nohess -nox -gbs",gbsVal,"-cbs",cbsVal,addCmdOpt)
                startTime <- Sys.time()  #system time
                if(verbose) {cat("gbs=",gbs[i]," cbs=",cbs[j],sep="","\n");print(cmd)}
                output[[runNum]] <- runCmd.fn(cmd,executable,memSampTime)
                runTime <- as.numeric(difftime(file.info(paste(substring(executable,1,nchar(executable)-4),".par",sep=""))[,"mtime"],startTime,units="secs"))  #use file info because Sys.sleep may delay finish of above function
                if(runTime<minRunTime) {runTimeWarning <- T}
                if(nrow(output[[runNum]]) < 3) {memSampWarning <- T}
                if(file.exists(repfile)) {
                    r <- getRunTime.fn(runNum=runNum,exec=executable)
                } else {
                    r <- NA
                }
                output[[runNum]] <- list(output[[runNum]],runtime=runTime,reportruntime=r,call=cmd)
                if(verbose) cat("runTime =",output[[runNum]]$runtime,"\n")
            }
            if(extrasaves) save(output,file=paste("output_i",i,"_j",j,".Rdat",sep=""))
        }
    }
    save(output,file=paste("output_full.Rdat",sep=""))
    cat("\nOutput from runtest function saved to ",folder,"/output_full.Rdat\n",sep="")
    if(runTimeWarning) {cat("\nWARNING: At least one run time was less than",minRunTime,"seconds. You should increase maxfn for better comparisons\n")}
    if(memSampWarning) {cat("\nWARNING: At least one run was sampled fewer than 3 times. You should increase maxfn and/or decrease memSampTime to get better representation\n")}
        
    return(output)
}

clean.fn <- function(){
    # optional function called by runtest to clean out old files
    # depends on what might have been created by getRunTime.fn
    i <- 1
    while(file.exists(paste("Report",i,".sso",sep=""))) {
      file.remove(paste("Report",i,".sso",sep=""))
    }
}
  
getRunTime.fn <- function(runNum=NULL, copydelete=TRUE, exec=NULL){
    ## this function is specific to a given executable and how it records run times
    ## the following is specific to Stock Synthesis
    # get run time from current file
    r <- readLines("Report.sso",n=15)
    r <- r[grep("This run took",r)]
    rvec <- as.numeric(as.character(strsplit(r," ")[[1]][c(4,6,8)]))
    r <- rvec[1]*60^2 + rvec[2]*60 + rvec[3]
    # copy files to new names for future use if needed
    if(copydelete & !is.null(runNum)){
        file.copy(from="Report.sso",to=paste("Report",runNum,".sso",sep=""),overwrite=T)
        file.copy(from="ParmTrace.sso",to=paste("ParmTrace",runNum,".sso",sep=""),overwrite=T)
        if(!is.null(exec)) file.copy(from=paste(substring(exec,1,nchar(exec)-4),".log",sep=""),to=paste("fileSizes",runNum,".log",sep=""),overwrite=T)
    }
    return(r)
}

createMatrices.fn <- function(out,runTimeName="runtime") {
    # change output from runtest function into a list of matrices
    #runTimeName can also be "reportruntime" for SS3 or if you coded your own getRunTime.fn to extract run time from a report file

    designMatrix.fn <- function(out) {
        # a function used by createMatrices.fn to parse the output from runtest
        x <- strsplit(names(out),"cbs")
        cbs <- sort(as.numeric(unique(unlist(lapply(x,function(x){x[2]})))))
        x <- unlist(lapply(x,function(x){x[1]}))
        x <- strsplit(x,"gbs")
        gbs <- sort(as.numeric(unique(unlist(lapply(x,function(x){x[2]})))))
        return(matrix(NA,nrow=length(gbs),ncol=length(cbs),dimnames=list(gbs,cbs)))
    }

    # define empty matrices
    memory <- cmpdiff <- gradfil1 <- gradfil2 <- runTime <- designMatrix.fn(out)# <- niter
    x <- strsplit(names(out),'[c-g]bs')

    # get info from elements of out
    for(i in 1:length(out)) {
      if(!is.na(x[[i]][1])){
        gbs <- x[[i]][2]
        cbs <- x[[i]][3]

        memory[gbs,cbs] <- max(out[[i]][[1]]$memsize,na.rm=T)
        cmpdiff[gbs,cbs] <- max(out[[i]][[1]]$cmpdiff,na.rm=T)
        gradfil1[gbs,cbs] <- max(out[[i]][[1]]$gradfil1,na.rm=T)
        gradfil2[gbs,cbs] <- max(out[[i]][[1]]$gradfil2,na.rm=T)
        # niter[gbs,cbs] <- out[[i]]$niter
        runTime[gbs,cbs] <- out[[i]][[runTimeName]]
      }
    }
    memory[memory==-Inf] <- cmpdiff[cmpdiff==-Inf] <- gradfil1[gradfil1==-Inf] <- gradfil2[gradfil2==-Inf] <- NA
    list(memory=memory,cmpdiff=cmpdiff,gradfil1=gradfil1,gradfil2=gradfil2,runTime=runTime)#,niter=niter)
}

makeMemTestplots.fn <-
  function(matrixlist, direc=getwd(), extraTitle="", log10=TRUE,
           dopdf=FALSE, width=7, height=7, filename="memory_testing_results.pdf"){
  # make a collection of plots, either in separate windows or as a single PDF file

  if(dopdf){
    file <- paste(direc,filename,sep='/')
    pdf(file,width=width,height=height)
    cat('writing to PDF file:',file,'\n')
  }

  # general function to make contour plots
  contour.fn <- function(z,main=NULL,log10=TRUE){
    if(!dopdf) windows()
    zlim <- range(z, finite = TRUE)
    nlev <- length(pretty(zlim, 20))
    x <- as.numeric(dimnames(z)[[1]])
    y <- as.numeric(dimnames(z)[[2]])
    xlab <- "gbs"
    ylab <- "cbs"
    if(log10){
      x <- log10(x)
      y <- log10(y)
      xlab <- "log10(gbs)"
      ylab <- "log10(cbs)"
    }
    filled.contour(x, y, z, col=rainbow(nlev, start=.7, end=.1),
                   nlevels=nlev, xlab=xlab, ylab=ylab, main=main)
  }

  contour.fn(z=matrixlist$runTime, main=paste("Run time (sec)",extraTitle), log10=log10)
  contour.fn(z=matrixlist$memory/1024, main=paste("Memory (Mb)",extraTitle), log10=log10)
  contour.fn(z=matrixlist$cmpdiff/1024, main=paste("cmpdiff (Mb)",extraTitle), log10=log10)
  contour.fn(z=matrixlist$gradfil1/1024, main=paste("gradfil1 (Mb)",extraTitle), log10=log10)

  if(dopdf) dev.off()
}
