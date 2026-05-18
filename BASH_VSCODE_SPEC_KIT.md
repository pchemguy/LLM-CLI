# Configuring VS Code and Spec Kit for Bash Usage on Windows

## Problem Context

Spec Kit allows selecting a preferred shell (Bash vs. PowerShell) during installation. However:

* The `git` extension **does not enforce shell selection**
* Its prompts expose **both Bash and PowerShell variants**
* The agent is expected to choose

In practice, agents (e.g., Copilot + GPT-5.x) tend to:

* default to **PowerShell on Windows**
* **ignore project-level Bash preference**, even when Bash is available

This creates inconsistency between:

* project intent (Bash-first)
* agent execution behavior (PowerShell fallback)

---

## Solution Strategy

Instead of relying on prompt phrasing, enforce shell selection via a **root-level invariant in `AGENTS.md`**.

### Required Instruction

```markdown
### Shell Selection (Windows)

- If `bash` is on `PATH` (i.e., `bash --version` succeeds) → MUST use Bash
- Otherwise → use PowerShell
- Mixing shells is forbidden
```

### Key Property

This converts shell selection into a:

* **runtime-detectable condition**
* **binary decision**
* **non-optional constraint**

No heuristic interpretation is left to the agent.

---

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

### Optional Hardening

To reduce ambiguity:

* Remove or disable PowerShell profiles
* Ensure no other terminal becomes default implicitly

---

## Resulting Behavior

With this setup:

* Bash is:
    * **discoverable via `PATH`**
    * **explicitly configured in tooling**
* Agents are:
    * **forced by `AGENTS.md` to select Bash**
* PowerShell becomes:
    * **strict fallback only**

---

## Key Insight

The critical control point is **not VS Code configuration**, but:

> enforcing a *deterministic selection rule* in `AGENTS.md`

Everything else (Conda, env vars, VS Code profiles) exists to ensure that:

* `bash --version` succeeds
* therefore the rule deterministically resolves to Bash
