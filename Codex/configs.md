## `.codex/AGENTS.md`

Note: remove outer code block before copying into `.codex/AGENTS.md`.

``````markdown
## Shell and Command Execution Policy

### Available and Prohibited Tooling

Use cmd.exe shell commands for file system operations. PowerShell/pwsh scripts, syntax, pipelines, Cmdlets, or command idioms are prohibited.

Git Bash and the Conda `m2-base` MSYS2 environment is available, and POSIX-style command-line tooling (such as, grep, sed, etc.) should be used for advanced operations. Git Bash and `m2-base` tools MUST always be executed outside the sandbox.

### Path Policies

Do not use platform-specific default paths, such as `C:/Program Files/Git/cmd/git.exe`. Prefer:

- PATH-based executable resolution,
- repository-relative paths,
- relative paths,
- tool-provided working directories.

### Prohibited

Do not invoke commands through intermediary shells:

- `bash -c '...'`
- `bash -lc '...'`
- `cmd /c ...`
- `cmd.exe /c ...`

### Preferred

Invoke target programs directly, for examples:

- `git status`
- `sed ...`
- `grep ...`

`mkdir` commands MUST use cmd.exe-compatible semantics, `mkdir "<path>"`, NOT POSIX semantics, `mkdir -p "<path>"`.
``````

## `.codex/rules/default.rules`

```text
prefix_rule(pattern=["cmd.exe", "/c"], decision="allow")
prefix_rule(pattern=["cmd",     "/c"], decision="allow")
```
