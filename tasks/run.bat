@echo off

set startdir=%~dp0

set content=
for /f "delims=" %%i in ('type config\gitlocation.txt') do set content=%%i

call:echo_gold "@echo Select version #"
:beginning
Set /P _1=(eg. 1.9) || Set _1=NothingChosen
If "%_1%"=="NothingChosen" goto :error
If /i "%_1%"=="latest" goto latest
If /i "%_1%"=="1.9.2" goto 1.9.2
If /i "%_1%"=="1.9" goto 1.9
If /i "%_1%"=="1.8.8" goto 1.8.8
If /i "%_1%"=="1.8.7" goto 1.8.7
If /i "%_1%"=="1.8.3" goto 1.8.3
If /i "%_1%"=="1.8" goto 1.8

:error
call:echo_red "@echo Must select a version number. If version number isnt implemented, use latest as a bypass ;)"
goto beginning

:latest
"%content%" --login -i -c "java -jar "tasks/BuildTools.jar"" -rev latest "
goto exit

:1.9.2
"%content%" --login -i -c "java -jar "tasks/BuildTools.jar"" -rev 1.9.2 "
goto exit

:1.9
"%content%" --login -i -c "java -jar "tasks/BuildTools.jar"" -rev 1.9 "
goto exit

:1.8.8
"%content%" --login -i -c "java -jar "tasks/BuildTools.jar"" -rev 1.8.8 "
goto exit

:1.8.7
"%content%" --login -i -c "java -jar "tasks/BuildTools.jar"" -rev 1.8.7 "
goto exit

:1.8.3
"%content%" --login -i -c "java -jar "tasks/BuildTools.jar"" -rev 1.8.3 "
goto exit

:1.8
"%content%" --login -i -c "java -jar "tasks/BuildTools.jar"" -rev 1.8 "
goto exit

:exit
exit

:echo_red
%Windir%\System32\WindowsPowerShell\v1.0\Powershell.exe write-host -foregroundcolor red %1
goto:eof

:echo_gold
%Windir%\System32\WindowsPowerShell\v1.0\Powershell.exe write-host -foregroundcolor DarkYellow %1
goto:eof
