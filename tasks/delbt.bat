@echo off

set startdir=%~dp0

@echo Deleting old Buildtools.jar

if exist tasks\BuildTools.jar (del /f tasks\BuildTools.jar) else (@echo Buildtools.jar isnt located in tasks folder. Skipping this step and Downloading Buildtools.jar
goto exit)

if exist tasks\BuildTools.jar (@echo Failed to delete old version. Make sure you have Read, Write, and Execute allowed in your directory) else (@echo Deleted old BuildTools.jar Sucessfully)

@echo Updating Buildtools.jar ;)

:exit
exit
