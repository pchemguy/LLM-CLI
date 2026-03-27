@echo off

call "%~dp0conda_far.bat" /batch

set "NPM_CACHE=%USERPROFILE%\Downloads\CACHE\Claude"
if not exist "%NPM_CACHE%" (mkdir "%NPM_CACHE%")

echo:
echo ===== Installing Gemini CLI =====
echo:
call npm install --cache "%NPM_CACHE%" -g @google/gemini-cli
echo:
echo ===== Installing Codex CLI =====
echo:
call npm install --cache "%NPM_CACHE%" -g @openai/codex

REM Claude has a quirk and fails to detect bash. This VAR must be set
REM before running the installer or CLI. Also added to condar_far.bat.
set "CLAUDE_CODE_GIT_BASH_PATH=%~dp0Anaconda\Library\bin\bash.exe"

REM The script downloaded from https://claude.ai/install.cmd downloads the latest binary,
REM which acts as CLI and can also be invoked as installer (see install_claude.cmd).
REM
REM The binary is downloaded into %USERPROFILE%\.claude\downloads\claude(...).exe and is
REM deleted by install_claude.cmd.
REM
REM The script installs "claude.exe in %USERPROFILE%\.local\bin\claude.exe (a copy of the
REM downloaded binary). The installation process does something else. Be aware that the
REM installation mode may have a horrible memory leakage problem, with memory usage in
REM excess of forty GB RAM has been observed.

REM VPN with acceptable geolocation must be active or curl... may fail.

echo:
echo ===== Installing Claude CLI =====
echo:
set "CLAUDE=%USERPROFILE%\.local\bin\claude.exe"
if not exist "%CLAUDE%" (
    echo Installing Claude...
    call curl -fsSL https://claude.ai/install.cmd -o install_claude.cmd && call install_claude.cmd
) else (
    echo Using existing Claude copy.
    echo To reinstall, manually delete "%CLAUDE%".
)

copy /Y "%CLAUDE%" "%~dp0Anaconda\claude.exe"


echo:
echo ===== Installing Spec Kit Specify =====
echo:
set "SPECIFY=%USERPROFILE%\.local\bin\specify.exe"
if not exist "%SPECIFY%" (
    echo Installing Spec Kit Specify...
    call uv tool install specify-cli --from git+https://github.com/github/spec-kit.git
) else (
    echo Using existing Spec Kit Specify copy.
    echo To reinstall, manually delete "%SPECIFY%".
)

copy /Y "%SPECIFY%" "%~dp0Anaconda\specify.exe"

pause
