@echo off

if exist tasks/update.bat (goto run) else (goto exit)

:run

set v=
for /f "delims=" %%i in ('type tasks\btuversion.txt') do set v=%%i

set content=
for /f "delims=" %%i in ('type config\gitlocation.txt') do set content=%%i

@echo Checking for Updates...

powershell -command Invoke-WebRequest -Uri http://thegearmc.com/update/btversion.txt -OutFile tasks/btuversion2.txt

@echo Current Version
findstr /c:"%v%" /i tasks\btuversion.txt
set RESULT1=%ERRORLEVEL%
echo.
echo.
@echo Current Update Version.
findstr /c:"%v%" /i tasks\btuversion2.txt
set RESULT2=%ERRORLEVEL%
set v2=
for /f "delims=" %%i in ('type tasks\btuversion2.txt') do set v2=%%i
echo.
cls
if %RESULT1%==%RESULT2% (
    echo No Updates available.
    del /f tasks\btuversion2.txt
) else (
    echo Found an update. v.%v2%. Do you want to Update:
    echo Deleting old files and placing new ones in.
    echo Deleting Buildtools.bat
    del /f Buildtools.bat
    echo Deleting menu.bat
    del /f menu.bat
    echo Deleting plugin.bat
    del /f plugin.bat
    echo Deleting help.bat
    del /f help.bat
    echo Deleting tasks\delbt.bat
    del /f tasks\delbt.bat
    echo Deleting tasks\run.bat
    del /f tasks\run.bat
    echo Deleted old files.

    echo Generating new Files...
    @echo Buildtools.bat from v.%v2%
    powershell -command Invoke-WebRequest -Uri https://raw.githubusercontent.com/Legoman99573/Buildtools-Updater-Dev/master/Buildtools.bat -OutFile Buildtools.bat
    @echo menu.bat from v.%v2%
    powershell -command Invoke-WebRequest -Uri https://raw.githubusercontent.com/Legoman99573/Buildtools-Updater-Dev/master/menu.bat -OutFile menu.bat
    @echo plugin.bat from v.%v2%
    powershell -command Invoke-WebRequest -Uri https://raw.githubusercontent.com/Legoman99573/Buildtools-Updater-Dev/master/plugin.bat -OutFile plugin.bat
    @echo setup.bat from v.%v2%
    powershell -command Invoke-WebRequest -Uri https://raw.githubusercontent.com/Legoman99573/Buildtools-Updater-Dev/master/setup.bat -OutFile setup.bat
    @echo help.bat from v.%v2%
    powershell -command Invoke-WebRequest -Uri https://raw.githubusercontent.com/Legoman99573/Buildtools-Updater-Dev/master/help.bat -OutFile help.bat
    @echo tasks/delbt.bat from v.%v2%
    powershell -command Invoke-WebRequest -Uri https://raw.githubusercontent.com/Legoman99573/Buildtools-Updater-Dev/master/tasks/delbt.bat -OutFile tasks/delbt.bat
    @echo tasks/run.bat from v.%v2%
    powershell -command Invoke-WebRequest -Uri https://raw.githubusercontent.com/Legoman99573/Buildtools-Updater-Dev/master/help.bat -OutFile tasks/run.bat
    @echo Finished Updating to v.%v2%
    echo.
    @echo Making btuversion2.txt merge to btuversion.txt
    del /f tasks\btuversion.txt
    del /f tasks\btuversion2.txt
    cls
    @echo Finished Updating to v.%v2%
    powershell -command Invoke-WebRequest -Uri http://thegearmc.com/update/btversion.txt -OutFile tasks/btuversion.txt
)
:exit
@pause
exit
