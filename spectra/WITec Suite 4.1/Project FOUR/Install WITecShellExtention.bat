@echo off

:-------------------------------------
: BatchGotAdmin
:-------------------------------------

REM  --> Check for admin permissions
Net Session >nul 2>&1
If %errorLevel% == 0 (
   goto gotAdmin
) else (
   echo Requesting administrative privileges...
   goto UACPrompt
)

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"

:--------------------------------------
: Ab hier administrator Rechte
:--------------------------------------


IF EXIST %SYSTEMROOT%\system32\WITecShellExtension.dll (
  regsvr32 WITecShellExtension.dll
  if errorlevel 1 (
     echo Failed to register WITecShellExtension.dll
     goto :end
  )
  echo WITecShellExtension.dll was registered successfully.
  goto :end
)
echo WITecShellExtension.dll is not existing - skipping
:next
IF EXIST %SYSTEMROOT%\system32\WITecShellExtensionNew.dll (
  regsvr32 WITecShellExtensionNew.dll
  if errorlevel 1 (
     echo Failed to register WITecShellExtensionNew.dll
     goto :end
  )
  echo WITecShellExtensionNew.dll was registered successfully.
  goto :end
)
echo WITecShellExtensionNew.dll is not existing - skipping
:next2
IF EXIST %SYSTEMROOT%\system32\WITecShellExtensionVS.dll (
  regsvr32 WITecShellExtensionVS.dll
  if errorlevel 1 (
     echo Failed to register WITecShellExtensionVS.dll
     goto :end
  )
  echo WITecShellExtensionVS.dll was registered successfully.
  goto :end
)
echo WITecShellExtensionVS.dll is not existing - skipping
echo No WITec Shell Extension dll is existing. Did you install WITec Project correctly from the Setup File ?
:end
pause