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

### Tools Settings

`%APPDATA%/Code/User/settings.json`

```json
    "chat.tools.terminal.autoApprove": {
        "cd": true,
        "echo": true,
        "ls": true,
        "dir": true,
        "pwd": true,
        "cat": true,
        "head": true,
        "tail": true,
        "findstr": true,
        "wc": true,
        "tr": true,
        "cut": true,
        "cmp": true,
        "which": true,
        "basename": true,
        "dirname": true,
        "realpath": true,
        "readlink": true,
        "stat": true,
        "file": true,
        "od": true,
        "du": true,
        "df": true,
        "sleep": true,
        "nl": true,
        "grep": true,
        "gh": true,
        "git": true,
        "npm": true,
        "yarn": true,
        "pnpm": true,
        "column": true,
        "/^column\\b.*\\s-c\\s+[0-9]{4,}/": false,
        "date": true,
        "/^date\\b.*\\s(-s|--set)\\b/": false,
        "find": true,
        "/^find\\b.*\\s-(delete|exec|execdir|fprint|fprintf|fls|ok|okdir)\\b/": false,
        "rg": true,
        "/^rg\\b.*\\s(--pre|--hostname-bin)\\b/": false,
        "sed": true,
        "/^sed\\b.*\\s(-[a-zA-Z]*(e|f)[a-zA-Z]*|--expression|--file)\\b/": false,
        "/^sed\\b.*s\\/.*\\/.*\\/[ew]/": false,
        "/^sed\\b.*;W/": false,
        "sort": true,
        "/^sort\\b.*\\s-(o|S)\\b/": false,
        "tree": true,
        "/^tree\\b.*\\s-o\\b/": false,
        "/^xxd$/": true,
        "/^xxd\\b(\\s+-\\S+)*\\s+[^-\\s]\\S*$/": true,
        "rm": false,
        "rmdir": false,
        "del": false,
        "ri": false,
        "rd": false,
        "erase": false,
        "dd": false,
        "kill": false,
        "ps": false,
        "top": false,
        "spps": false,
        "taskkill": false,
        "chmod": false,
        "chown": false,
        "sp": false,
        "xargs": false,
        "eval": false
    },
```