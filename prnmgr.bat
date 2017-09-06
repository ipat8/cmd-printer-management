@echo off
echo YOU DID NOT EDIT THE SCRIPT. YOU MUST REMOVE THIS BEFORE THIS SCRIPT WILL WORK.
echo Exiting.
wait 10
exit

chcp 65001
: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )
:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "cmd.exe", "/C """"%~f0""""", , "runas", 1 >> "%temp%\getadmin.vbs"
    cscript "%temp%\getadmin.vbs"
    exit /B
:gotAdmin
    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
    pushd "%CD%"
    CD /D "%~dp0"

rem --- ADMIN RIGHTS REQUIRED FOR BELOW CONFIGURATION ---
Echo WE ARE NOW STARTING PRINTER CONFIGURATION. PLEASE STAND BY.
Echo ===============================Deleting Existing Printers
cscript C:\Windows\System32\Printing_Admin_Scripts\en-US\prnmngr.vbs -x
cscript C:\Windows\System32\Printing_Admin_Scripts\en-US\prnmngr.vbs -xc

Echo ===============================Deleting Existing Ports
cscript C:\Windows\System32\Printing_Admin_Scripts\en-US\prnport.vbs -d -s \\%computername% -r <if you know your existing port> | cscript C:\Windows\System32\Printing_Admin_Scripts\en-US\prnport.vbs -d -s \\%computername% -r WSD*

Echo ===============================Deleting Existing Drivers
cscript C:\Windows\System32\Printing_Admin_Scripts\en-US\prndrvr.vbs -x

Echo ===============================Adding new Printer
powershell.exe -ExecutionPolicy Bypass -Command "echo <The Name You Want Your Users To See> | Add-Printer -DeviceURL <Add Device URL>"

echo ===============================Setting new Printer as Default
cscript C:\Windows\System32\Printing_Admin_Scripts\en-US\prnmngr.vbs -s \\%computername% -t -p <The Name You Want Your Users To See>

Echo ===============================Rebooting and removing script
echo WE ARE NOW REBOOTING. PLEASE STAND BY.
shutdown.exe /r /t 10
del "%~f0"
rem --- END OF BATCH ----
