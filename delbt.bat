@echo off

set startdir=%~dp0

@echo Deleting old Buildtools.jar

del /f tasks\BuildTools.jar

if exist tasks\BuildTools.jar (@echo Failed to delete old version. Make sure you have Read, Write, and Execute allowed in your directory) else (@echo Deleted old BuildTools.jar Sucessfully)

@echo Updating Buildtools.jar ;)

exit
