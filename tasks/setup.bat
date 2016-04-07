@echo off

if exist config/ (@echo Found config folder) else (md config)

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
if exist api/ (@echo tasks exists. This can be ignored) else (md api)

if exist logs/ (@echo /logs exists. This can be ignored) else (md logs)

if exist tasks/Buildtools_Files/ (@echo Folder exists. This can be ignored) else (md tasks/Buildtools_Files)

@echo finished Generating all folders.

If exist tasks/apache-maven-3.2.5/ (move tasks\apache-maven-3.2.5 tasks\Buildtools_Files\)

If exist tasks/BuildData/ (move tasks\BuildData tasks\Buildtools_Files\)

If exist tasks/Bukkit/ (move tasks\Bukkit tasks\Buildtools_Files\)

If exist tasks/CraftBukkit/ (move tasks\CraftBukkit tasks\Buildtools_Files\)

If exist tasks/Spigot/ (move tasks\Spigot tasks\Buildtools_Files\)

If exist tasks/work/ (move tasks\work tasks\Buildtools_Files\)

@echo Updating update.bat
del /f update.bat
powershell -command Invoke-WebRequest -Uri https://raw.githubusercontent.com/Legoman99573/Buildtools-Updater-Dev/master/update.bat -OutFile update.bat

exit
