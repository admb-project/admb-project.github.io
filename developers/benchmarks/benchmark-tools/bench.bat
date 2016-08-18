@echo off
setlocal
if [%1]==[] goto HELP
if [%1]==[--help] goto HELP
REM ####################################################################################################################
REM                                                                                                                    #
REM Script:   bench cmd                                                                                                #
REM                                                                                                                    #
REM Purpose:  Time a simple command                                                                                    #
REM                                                                                                                    #
REM Args:     cmd is command to run                                                                                    #
REM                                                                                                                    #
REM Notes:    Simplified version of 'benchmark'                                                                        #
REM                                                                                                                    #
REM Returns:  Shows start and end time                                                                                 #
REM                                                                                                                    #
REM History:  2011-02-10 Arni Magnusson released                                                                       #
REM                                                                                                                    #
REM ####################################################################################################################

set before=%time%
call %*
set after=%time%

echo.
echo %before%
echo %after%

goto EOF

:HELP
echo Usage: bench cmd
echo.

:EOF
