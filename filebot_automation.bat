@echo off
setlocal enableextensions enabledelayedexpansion
REM Set color of terminal text to light green and clear the screen.
cls
color 0A 

echo -----------------------------------------------------------------------------------
echo This is the script that will run in Staging Area using FileBot.
echo It will rename all the TV Shows using TheTVDB and grab subtitles from OpenSubtitles.
echo ------------------------------------------------------------------------------------
echo.
echo Switching active directory to "%USERPROFILE%\Desktop\Staging Area"
cd "%USERPROFILE%\Desktop\Staging Area"
REM echo %CD%
echo.
echo ---------------------------
echo Files discovered in folder.
echo ---------------------------
echo.
REM Find all media and subtitles files, and move files to the root of Stagin Area
call :treeProcess

echo.
REM Download all the subtitles
echo -------------------------
echo Downloading subtitles 
echo -------------------------
echo.
REM Get filebot version
filebot -version > tmpFile
set /p filebot_version= < tmpFile
del tmpFile
echo Running %filebot_version%
filebot -get-subtitles . --output srt -non-strict --conflict auto --format
echo.

REM Rename all the files 

REM Pause the script at the end of the run
echo.
pause

REM Reset the terminal color back to default.
color
endlocal
exit /b

:treeProcess
REM The single Ampersand continues onto the next command even if the previous command fails:
call :findPattern *.mkv & call :findPattern *.mp4 & call :findPattern *.sub & call :findPattern *.srt & call :findPattern *.avi

for /D %%d in (*) do (
    cd %%d
    REM echo %%d
    REM echo.
    if %%d neq "" (
        REM echo %%d
        REM echo.
        cd ..
        del /s /q %%d
        rmdir /s /q %%d
    ) else cd ..
)

:findPattern
REM Recursively run through directories and sub-directories to find pattern.
for %%f in (%1) do ( 
    echo %%f
    move /-y %%f "%USERPROFILE%\Desktop\Staging Area">NUL
)
