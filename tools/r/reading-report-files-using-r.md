---
layout: default
title: Reading report files using R
---

Reading report files using R
----------------------------

I have written a useful R function that reads the contents of a report file (or any output file) and stores the contents in R in the form of a list object. This function is capable of reading single variables, vectors, and 2-D arrays (including ragged arrays). The R-code was inspired by some earlier code developed by George Watters.

The format of *.tpl code requires the object name be printed first then the value(s), e.g.:

```
report<<"Biomass"<<endl<<bt<<endl;
```

Once the above line has been read into R the bt vector will be available as A$Biomass, where A is the list object, and Biomass is the name of the bt vector.

To use this function, copy and past the R-code below and and save this file as "reptoRlist.R". Then source this file in R (or put it at the top of your R-script). The function requires a file name argument (e.g., fn="MyModel.rep"). To read the contents of a report file, simply use:

```
A=reptoRlist(fn)
```

Then all of the objects in your report file will be stored in the list object A.

S.Martell

**R-code**

```R
reptoRlist = function(fn)
{
ifile=scan(fn,what="character",flush=T,blank.lines.skip=F,quiet=T)
idx=sapply(as.double(ifile),is.na)
vnam=ifile[idx]	#list names
nv=length(vnam)	#number of objects
A=list()
ir=0
for(i in 1:nv)
{
ir=match(vnam[i],ifile)
if(i!=nv) irr=match(vnam[i+1],ifile) else irr=length(ifile)+1 #next row
dum=NA
if(irr-ir==2) dum=as.double(scan(fn,skip=ir,nlines=1,quiet=T,what=""))
if(irr-ir>2) dum=as.matrix(read.table(fn,skip=ir,nrow=irr-ir-1,fill=T))

if(is.numeric(dum))#Logical test to ensure dealing with numbers
{
A vnam[i[+] ]=dum
}
}
return(A)
}
}
```
