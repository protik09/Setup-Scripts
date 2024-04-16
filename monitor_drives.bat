@echo off

:: Function to check if pnputil is available
:check_pnputil
where pnputil >nul 2>&1
if %errorlevel% neq 0 (
  echo PnPUtil is not available. Please ensure it is installed.
  pause
  exit /b
)
else(
  echo PnPUtil is available. Continuing... \r\n
)

:: Function to check if a drive is a USB drive
:is_usb_drive
set drive=%~1
fsutil fsinfo drivetype %drive%: | findstr /i "removable" >nul 2>&1
if %errorlevel% equ 0 (
  exit /b 0
) else (
  exit /b 1
)

:: Function to check for admin rights and elevate if needed
:check_admin
net session >nul 2>&1
if %errorlevel% neq 0 (
  echo Elevating to administrator privileges...
  powershell -Command "Start-Process -FilePath '%0' -Verb RunAs"
  exit /b
)

:: Get drives to check from arguments (or default to F, H, J)
set drives=%*
if "%drives%"=="" set drives=F H J

:: Set log file path
set logfile=usb_drive_monitor.log

:monitor_loop
echo. >> %logfile%
echo %date% %time% - Monitoring drives... >> %logfile%

:: Iterate through each drive
for %%a in (%drives%) do (
  echo Checking drive %%a: >> %logfile%
  
  :: Check if drive is accessible and a USB drive
  vol %%a: >nul 2>&1
  if %errorlevel% neq 0 (
    echo Drive %%a: is offline. Attempting to reset... >> %logfile%
    
    call :is_usb_drive %%a
    if %errorlevel% equ 0 (
      :: Get the device instance ID
      for /f "tokens=*" %%b in ('fsutil fsinfo drivetype %%a:') do (
        set device_path=%%b
        for /f "tokens=2 delims==" %%c in ('pnputil /enum-devices /instanceid %%b ^| findstr "Instance ID"') do (
          set device_id=%%c
        )
      )

      :: Disable and enable the device
      pnputil /disable-device "%device_id%" >nul 2>&1
      timeout /t 2 >nul
      pnputil /enable-device "%device_id%" >nul 2>&1
      if %errorlevel% neq 0 (
        echo Failed to reset drive %%a:. Error: %errorlevel% >> %logfile%
      ) else (
        echo Drive %%a: reset successfully. >> %logfile%
      )
    ) else (
      echo Drive %%a: is not a USB drive. Skipping... >> %logfile%
    )
  ) else (
    echo Drive %%a: is online. >> %logfile%
  )
)

:: Wait for 5 minutes before next check
timeout /t 300 /nobreak >nul
goto :monitor_loop

exit /b

:: Check for admin rights on startup
call :check_admin
