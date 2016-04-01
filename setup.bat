@echo off

@echo Generating config/version.txt
powershell -command Invoke-WebRequest -Uri http://thegearmc.com/update/version.txt -OutFile config/version.txt

@echo Generating config/gitlocation.txt
powershell -command Invoke-WebRequest -Uri http://thegearmc.com/update/gitlocation.txt -OutFile config/gitlocation.txt

@echo Generating config/plugin.txt
powershell -command Invoke-WebRequest -Uri http://thegearmc.com/update/plugin.txt -OutFile config/plugin.txt

@echo Finished Generating config Folder

@echo Generating necessary folders
@echo Generating folder /plugin-pending
md plugin-pending

@echo Generating folder /plugin-fixed
md plugin-fixed

@echo Generating folder /bungee
md bungee
md bungee/modules

@echo Generating folder /api
md api

@echo finished Generating all folders

exit
