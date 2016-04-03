@echo off

set startdir=%~dp0

set content=
for /f "delims=" %%i in ('type config\gitlocation.txt') do set content=%%i

if exist setup.bat (goto setup) else (goto boot)

:setup
start "Buildtools Updater v.0.14-Beta | First Run" /b /wait setup.bat
del /f setup.bat
goto boot

:boot
If exist %content% (goto boot2) else (@echo bash.exe was not found. Download, or configure gitlocation.txt
Goto error)
:boot2
@echo This build is in beta and could break important files. Continue: 
Set /P _1=(Y, N) || Set _1=NothingChosen
If "%_1%"=="NothingChosen" goto :start
If /i "%_1%"=="Y" goto start
If /i "%_1%"=="y" goto start
If /i "%_1%"=="N" goto stop
If /i "%_1%"=="n" goto stop

:start
if Exist menu.bat (goto ready) else (goto error2)

:ready
start "Buildtools Updater v.0.14-Beta" /Max /i menu.bat
goto exit

:error
@echo Current invalid location set: %content%
@pause
exit

:error2
@echo Directory or file is missing. Redownload the script.
@pause
exit

:exit
exit
