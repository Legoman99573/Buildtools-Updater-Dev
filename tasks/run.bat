@echo off

set startdir=%~dp0

set content=
for /f "delims=" %%i in ('type config\gitlocation.txt') do set content=%%i

set version=
for /f "delims=" %%i in ('type config\version.txt') do set version=%%i

"%content%" --login -i -c "java -jar "tasks/BuildTools.jar"" -rev %version% "

pause
