@echo off
echo Updating all git repositories in Team_Indus folder & echo.
cd "C:\Users\pbanerji\Desktop\Team_Indus"
bash -c "./Git_Update.sh"
cd LfswTest
echo. & echo Updating LfswTest with it's submodules & echo.
CALL git_update_all.bat
echo.
pause