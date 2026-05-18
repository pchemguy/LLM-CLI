# Configuring VS Code and Spec Kit for Bash Usage on Windows

## Environment Assumptions

These instructions assume:

* VS Code is launched from an environment where Bash is available on `PATH`
* Example: Conda environment with:
    * `m2-base`
    * `git`

---

## Claude CLI Compatibility

Some tooling (e.g., Claude CLI for Windows) does **not detect Bash via `PATH`**.

To compensate, define:

```bat
set "CLAUDE_CODE_GIT_BASH_PATH=%CONDA_PREFIX%\Library\bin\bash.exe"
```

This explicitly points to the Bash executable.

---

## VS Code Configuration

### code.bat

```Batch
:: Make sure the stupid PS is not visible to VS Code
set "Path=%Path:C:\Windows\System32\WindowsPowerShell\v1.0;=%"

start "" "%~dpn0.exe"
```

### Terminal Profiles

`%APPDATA%/Code/User/settings.json`

```json
{
    "terminal.integrated.profiles.windows": {
        "Command Prompt": {
            "path": [
                "${env:windir}\\Sysnative\\cmd.exe",
                "${env:windir}\\System32\\cmd.exe"
            ],
            "args": [],
            "icon": "terminal-cmd"
        },
        "Git Bash": {
            "path": "${env:CLAUDE_CODE_GIT_BASH_PATH}", 
            "args": ["--login", "-i"]
        },
        "PowerShell": null 
    },
    "terminal.integrated.defaultProfile.windows": "Git Bash",
    "terminal.integrated.agentHostProfile.windows": "Git Bash",
    "terminal.integrated.automationProfile.windows": "Git Bash",
}
```

### Telemetry

`%APPDATA%/Code/User/settings.json`

```json
{
    "telemetry.telemetryLevel": "off",
    "telemetry.feedback.enabled": false,
    "telemetry.editStats.enabled": false,
}
```
