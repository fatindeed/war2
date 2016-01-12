@echo off
SET PATH=%PATH%;.
SET SCRIPT_PATH=..\htdocs\Layout\
echo Checking lua scripts...
for /f %%a IN ('dir /b %SCRIPT_PATH%*.lua') do call luac -p %SCRIPT_PATH%%%a
echo Completed
pause