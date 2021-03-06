@echo off

set startdir=%~dp0

set content=
for /f "delims=" %%i in ('type config\gitlocation.txt') do set content=%%i

set v=
for /f "delims=" %%i in ('type tasks\btuversion.txt') do set v=%%i

if exist %content% (goto boot) else (goto error1)
:boot
@echo Welcome to Buildtools Updater v.%v%
:start
cls
start "Buildtools Updater v.%v% | Buildtools Help" /b /wait help.bat
:commanderror
Set /P "_1=>" || Set _1=NothingChosen
If "%_1%"=="NothingChosen" goto :commandnotfound
If /i "%_1%"=="update" goto update
If /i "%_1%"=="run" goto run
If /i "%_1%"=="help" goto start
If /i "%_1%"=="clean" goto clean
If /i "%_1%"=="plugin" goto plugin
If /i "%_1%"=="bungee" goto bungee
If /i "%_1%"=="exit" goto exit

:commandnotfound
@echo Command not found. Try help for help menu
goto commanderror

:update
cls
start "Buildtools Updater v.%v% | Delete Buildtools.jar" /b /wait %startdir%tasks\delbt.bat
%content% --login -i -c "curl -o tasks/BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastBuild/artifact/target/BuildTools.jar"
if exist %startdir%tasks\BuildTools.jar (@echo Updated BuildTools) else (@echo An error has occured. Make sure folder has write access)
goto start

:run
cls
@echo Warning: exiting while this is running may cause something to break, and not move buildtools files at the right time leaving a mess until you run this command again.
@pause
@echo getting Buildtools Ready
if exist %startdir%tasks\Buildtools_Files\apache-maven-3.2.5 (move %startdir%tasks\Buildtools_Files\apache-maven-3.2.5 %startdir%) else (echo Folder "apache-maven-3.2.5" doesnt exist may be ignored)
if exist %startdir%tasks\Buildtools_Files\BuildData (move %startdir%tasks\Buildtools_Files\BuildData %startdir%) else (echo Folder "BuildData" doesnt exist may be ignored)
if exist %startdir%tasks\Buildtools_Files\Bukkit (move %startdir%tasks\Buildtools_Files\Bukkit %startdir%) else (echo Folder "Bukkit" doesnt exist may be ignored)
if exist %startdir%tasks\Buildtools_Files\CraftBukkit (move %startdir%tasks\Buildtools_Files\CraftBukkit %startdir%) else (echo "Folder" CraftBukkit doesnt exist may be ignored)
if exist %startdir%tasks\Buildtools_Files\Spigot (move %startdir%tasks\Buildtools_Files\Spigot %startdir%) else (echo Folder "Spigot" doesnt exist may be ignored)
if exist %startdir%tasks\Buildtools_Files\work (move %startdir%tasks\Buildtools_Files\work %startdir%) else (echo Folder "work" doesnt exist may be ignored)

if exist tasks\BuildTools.jar (@echo Running BuildTools.jar) else (@echo Buildtools.jar is missing
echo.
@echo Grabbing BuildTools.jar from hub.spigotmc.org
%content% --login -i -c "curl -o tasks/BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastBuild/artifact/target/BuildTools.jar"
@echo Grabbed, and will attempt to run BuildTools.jar
)

start "Buildtools Updater v.%v% | Running Buildtools.jar" /b /wait tasks\run.bat

@echo Moving Buildtools Folder back to its original spot
move %startdir%apache-maven-3.2.5 %startdir%tasks\Buildtools_Files\
move %startdir%BuildData %startdir%tasks\Buildtools_Files\
move %startdir%Bukkit %startdir%tasks\Buildtools_Files\
move %startdir%CraftBukkit %startdir%tasks\Buildtools_Files\
move %startdir%Spigot %startdir%tasks\Buildtools_Files\
move %startdir%work %startdir%tasks\Buildtools_Files\

set datetime=
for /f %%a in ('powershell -Command "Get-Date -format yyyy_MM_dd__HH_mm_ss"') do set datetime=%%a

if exist BuildTools.log.txt (rename BuildTools.log.txt Buildtools.log.%datetime%.txt
move BuildTools.log.*.txt %startdir%logs)

@echo Moving Server jars into folder /serverjars/
echo.
@echo Moving Spigot
if exist spigot-*.jar (move spigot-*.jar %startdir%serverjars
if exist spigot-*.jar (@echo Failed to move Spigot) else (@echo Moved Spigot service Successfully)
) else (@echo File doesnt exist)
echo.

@echo Moving Craftbukkit
if exist craftbukkit-*.jar (move craftbukkit-*.jar %startdir%serverjars
if exist craftbukkit-*.jar (@echo Failed to move Craftbukkit) else (@echo Moved Craftbukkit service Successfully)
) else (@echo File doesnt exist)
@echo.
@echo Copying Spigot API's to api folder
copy %startdir%tasks\Buildtools_Files\Spigot\Spigot-API\target\spigot-api-*.jar %startdir%api

@echo Finished running BuildTools
@pause

goto start

:help
cls
start "Buildtools Updater v.%v% | Buildtools Help" /b /wait help.bat
goto start

:clean
cls
@echo Are you sure you want to clear all of Buildtools Files
Set /P "_clear=(Y, N)" || Set _clear=NothingChosen
If "%_clear%"=="NothingChosen" goto start
If /i "%_clear%"=="Y" goto cleanrun
If /i "%_clear%"=="y" goto cleanrun
If /i "%_clear%"=="N" goto start
If /i "%_clear%"=="n" goto start
:cleanrun
@echo Deleting every folder in %startdir%Buildtools_Files\
rd /q tasks\Buildtools_Files
md tasks\Buildtools_Files
@echo All Buildtools Files were removed.
goto start

:plugin
cls
start "Buildtools Updater v.%v% | Buildtools Plugin-Fixer" /b /wait plugin.bat
goto start

:bungee
cls
@echo Updating BungeeCord and its modules.
If not exist %startdir%bungee (md bungee)
If not exist %startdir%bungee\modules (md bungee\modules)

If exist bungee\BungeeCord.jar (del /f bungee\BungeeCord.jar)
If exist bungee\modules\cmd_find.jar (del /f bungee\modules\cmd_find.jar)
If exist bungee\modules\cmd_server.jar (del /f bungee\modules\cmd_server.jar)
If exist bungee\modules\cmd_send.jar (del /f bungee\modules\cmd_send.jar)
If exist bungee\modules\cmd_list.jar (del /f bungee\modules\cmd_list.jar)
If exist bungee\modules\cmd_alert.jar (del /f bungee\modules\cmd_alert.jar)
If exist bungee\modules\reconnect_yaml.jar (del /f bungee\modules\reconnect_yaml.jar)
@echo Downloading BungeeCord.jar
%content% --login -i -c "curl -o bungee/BungeeCord.jar http://ci.md-5.net/job/BungeeCord/lastBuild/artifact/bootstrap/target/BungeeCord.jar"
@echo Downloading modules/cmd_alert.jar
%content% --login -i -c "curl -o bungee/modules/cmd_alert.jar http://ci.md-5.net/job/BungeeCord/lastBuild/artifact/module/cmd-alert/target/cmd_alert.jar"
@echo Downloading modules/cmd_find.jar
%content% --login -i -c "curl -o bungee/modules/cmd_find.jar http://ci.md-5.net/job/BungeeCord/lastBuild/artifact/module/cmd-alert/target/cmd_find.jar"
@echo Downloading modules/cmd_list.jar
%content% --login -i -c "curl -o bungee/modules/cmd_list.jar http://ci.md-5.net/job/BungeeCord/lastBuild/artifact/module/cmd-alert/target/cmd_list.jar"
@echo Downloading modules/cmd_server.jar
%content% --login -i -c "curl -o bungee/modules/cmd_server.jar http://ci.md-5.net/job/BungeeCord/lastBuild/artifact/module/cmd-alert/target/cmd_server.jar"
@echo Downloading modules/cmd_send.jar
%content% --login -i -c "curl -o bungee/modules/cmd_send.jar http://ci.md-5.net/job/BungeeCord/lastBuild/artifact/module/cmd-alert/target/cmd_send.jar"
@echo Downloading modules/reconnect_yaml.jar
%content% --login -i -c "curl -o bungee/modules/reconnect_yaml.jar http://ci.md-5.net/job/BungeeCord/lastBuild/artifact/module/cmd-alert/target/reconnect_yaml.jar"
@echo Updated BungeeCord and all its Modules
goto start

:error1
cls
@echo Error-1 has occured. Goto https://www.spigotmc.org/wiki/buildtools-updater/ to find this error
if exist %startdir%error (goto errorprint1) else (md error)
:errorprint1
echo Link to Git: https://github.com/git-for-windows/git/releases/download/v2.7.2.windows.1/Git-2.7.2-64-bit.exe>error\error-1.txt
cmd /c start https://github.com/git-for-windows/git/releases/download/v2.7.2.windows.1/Git-2.7.2-64-bit.exe

:exit
cls
@echo Thanks for using BuildTools Updater v.%v% by: Legoman99573
@pause
exit
