@echo off

if exist config/version.txt (@echo version.txt exists. This can be ignored) else (@echo Generating config/version.txt
powershell -command Invoke-WebRequest -Uri http://thegearmc.com/update/version.txt -OutFile config/version.txt
)

if exist config/gitlocation.txt (@echo version.txt exists. This can be ignored) else (@echo Generating config/gitlocation.txt
powershell -command Invoke-WebRequest -Uri http://thegearmc.com/update/gitlocation.txt -OutFile config/gitlocation.txt
)

if exist config/plugin.txt (@echo version.txt exists. This can be ignored) else (@echo Generating config/plugin.txt
powershell -command Invoke-WebRequest -Uri http://thegearmc.com/update/plugin.txt -OutFile config/plugin.txt
)

@echo Finished Generating config Folder

@echo Generating necessary folders
@echo Generating folder /plugin-pending
if exist plugin-pending/ (@echo /plugin-pending exists. This can be ignored) else (md plugin-pending)

@echo Generating folder /plugin-fixed
if exist plugin-fixed/ (@echo /plugin-pending exists. This can be ignored) else (md plugin-fixed)

@echo Generating folder /serverjars
if exist serverjars/ (@echo /serverjars exists. This can be ignored) else (md serverjars)

@echo Generating folder /bungee
if exist bungee/ (@echo /bungee exists. This can be ignored) else (md bungee)
if exist bungee/modules/ (@echo /bungee/modules exists. This can be ignored) else (md bungee/modules)

@echo Generating folder /api
if exist api/ (@echo /bungee exists. This can be ignored) else (md api)

@echo finished Generating all folders

@echo Updating update.bat
del /f update.bat
powershell -command Invoke-WebRequest -Uri https://raw.githubusercontent.com/Legoman99573/Buildtools-Updater-Dev/master/update.bat -OutFile update.bat

exit
