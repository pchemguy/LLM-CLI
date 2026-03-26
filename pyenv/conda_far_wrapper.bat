@echo off

REM Use this wrapper to kill hanging powershell.exe

start "" cmd /c call "%~dp0conda_far.bat" %*
timeout.exe /T 2
taskkill /T /F /IM "powershell.exe"
