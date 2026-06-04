@echo off


for /d %%D in ("USERPROFILE\*") do (
    set "SRC=%%~D"
    set "DST=!SRC:USERPROFILE=%USERPROFILE%!"

    if exist "!DST!" rmdir /S /Q "!DST!"
    mklink /j "!DST!" "!SRC!"
)

for /d %%D in ("APPDATA\*") do (
    set "SRC=%%~D"
    set "DST=!SRC:APPDATA=%APPDATA%!"

    if exist "!DST!" rmdir /S /Q "!DST!"
    mklink /j "!DST!" "!SRC!"
)
