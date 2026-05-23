Note: remove outer code block before copying into `.codex/AGENTS.md`.

``````markdown
## Shell and Command Execution Policy

### Available and Prohibited Tooling

The default terminal shell is `cmd.exe`, not `PowerShell.exe`/`pwsh.exe`. Do not generate PowerShell scripts, syntax, pipelines, or command idioms.

Git Bash and the Conda `m2-base` MSYS2 environment are available and should be preferred for POSIX-style shell operations and Unix command-line tooling when shell execution is required.

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

For compatibility reasons, `mkdir` MUST not use any flags, such as `-p` . `mkdir` commands MUST use cmd.exe-compatible semantics, `mkdir "<path>"`, NOT POSIX semantics, `mkdir -p "<path>"`.
``````
