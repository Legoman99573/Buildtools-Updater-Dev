@echo off

set startdir=%~dp0

if exist tasks\btuversion.txt (goto setupcheck) else (powershell -command Invoke-WebRequest -Uri http://thegearmc.com/update/versions/1.2.txt -OutFile tasks/btuversion.txt
goto setupcheck)

:setupcheck
cls
if exist tasks/setup.bat (goto setup) else (goto boot)

:setup
start "Buildtools Updater v.%v% | First Run" /b /wait tasks\setup.bat
del /f setup.bat
cls
goto boot

:boot

set content=
for /f "delims=" %%i in ('type config\gitlocation.txt') do set content=%%i

set v=
for /f "delims=" %%i in ('type tasks\btuversion.txt') do set v=%%i

If exist %content% (goto boot2) else (@echo bash.exe was not found. Download, or configure gitlocation.txt
Goto error)
:boot2
@echo Always remeber to backup your files. Continue: 
Set /P _1=(Y, N) || Set _1=NothingChosen
If "%_1%"=="NothingChosen" goto :start
If /i "%_1%"=="Y" goto start
If /i "%_1%"=="y" goto start
If /i "%_1%"=="N" goto stop
If /i "%_1%"=="n" goto stop

:start
if Exist menu.bat (goto ready) else (goto error2)

:ready
start "Buildtools Updater v.%v%" /Max /i menu.bat
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
