@echo off


for /d %%D in ("%~dp0USERPROFILE\*") do (
    set "SRC=%%~D"
    set "DST=!SRC:%~dp0USERPROFILE=%USERPROFILE%!"

    if exist "!DST!" rmdir "!DST!"
    mklink /j "!DST!" "!SRC!"
)

for /d %%D in ("%~dp0APPDATA\*") do (
    set "SRC=%%~D"
    set "DST=!SRC:%~dp0APPDATA=%APPDATA%!"

    if exist "!DST!" rmdir "!DST!"
    mklink /j "!DST!" "!SRC!"
)
