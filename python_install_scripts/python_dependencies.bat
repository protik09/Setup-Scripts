@echo OFF

REM Add the Python 2 libs
echo. & echo Installing Python 2 Libraries & echo.
python -m pip install --upgrade -r python_requirements.txt

REM Add the python 3 version for
echo. & echo Installing Python 3 Libraries & echo.
python3 -m pip install --upgrade -r python_requirements.txt
echo.
pause