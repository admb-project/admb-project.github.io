@echo off
setlocal
if [%1]==[] goto HELP
if [%1]==[--help] goto HELP
REM ####################################################################################################################
REM                                                                                                                    #
REM Script:   benchmark cmd                                                                                            #
REM                                                                                                                    #
REM Purpose:  Time a simple command                                                                                    #
REM                                                                                                                    #
REM Args:     cmd is command to run                                                                                    #
REM                                                                                                                    #
REM Notes:    See also 'bench'                                                                                         #
REM                                                                                                                    #
REM Requires: R with gmt package                                                                                       #
REM                                                                                                                    #
REM Returns:  Shows elapsed seconds                                                                                    #
REM                                                                                                                    #
REM History:  2011-02-10 Arni Magnusson released                                                                       #
REM                                                                                                                    #
REM ####################################################################################################################

REM : = to remove initial whitespace
set before=%time: =%
call %*
set after=%time: =%
echo library(gmt); cat(3600*(deg2num("%after%")-deg2num("%before%"))) | R --slave --vanilla
echo s

goto EOF

:HELP
echo Usage: benchmark cmd
echo.

:EOF
