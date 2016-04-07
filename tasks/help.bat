@echo off
echo.
call:echo_green "@echo ================ {Command List} ================"
echo.
call:echo_darkyellow "@echo update: Updates Buildtools to latest version"
echo.
call:echo_green "@echo ------------------------------------------------"
echo.
call:echo_darkyellow "@echo help: Just added it if you want to spam it lol"
echo.
call:echo_green "@echo ------------------------------------------------"
echo.
call:echo_darkyellow "@echo run: Runs Buildtools and saves APIs"
echo.
call:echo_green "@echo ------------------------------------------------"
echo.
call:echo_darkyellow "@echo bungee: Updates BungeeCord and its modules"
echo.
call:echo_green "@echo ------------------------------------------------"
echo.
call:echo_darkyellow "@echo clean: Deletes Buildtools files"
echo.
call:echo_green "@echo ------------------------------------------------"
echo.
call:echo_darkyellow "@echo plugin: Runs Plugin-Fixer"
echo.
call:echo_green "@echo ------------------------------------------------"
echo.
call:echo_darkyellow "@echo btupdate: Updates this script"
echo.
call:echo_green "@echo ------------------------------------------------"
echo.
call:echo_darkyellow "@echo exit: Shuts Down Program"
echo.
call:echo_green "@echo ================ {Command List} ================"
echo.
exit

:echo_darkyellow
%Windir%\System32\WindowsPowerShell\v1.0\Powershell.exe write-host -foregroundcolor DarkYellow %1
goto:eof

:echo_green
%Windir%\System32\WindowsPowerShell\v1.0\Powershell.exe write-host -foregroundcolor green %1
goto:eof
