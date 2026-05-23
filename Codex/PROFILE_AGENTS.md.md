Note: remove outer code block before copying into `.codex/AGENTS.md`.

``````markdown
## Shell and Command Execution Policy

### Available and Prohibited Tooling

PowerShell (`powershell`, `pwsh`) must not be invoked at all. Do not generate PowerShell scripts, syntax, pipelines, or command idioms.

Git Bash and the Conda `m2-base` MSYS2 environment are available and should be preferred for POSIX-style shell operations and Unix command-line tooling when shell execution is required. These tools must always be called outside the sandbox environment.

Windows cmd.exe commands can also be used, but must be called directly, not via `cmd /c ...` syntax.

### Path Policies

Do not use platform-specific default paths, such as `C:/Program Files/Git/cmd/git.exe`. Prefer:

- PATH-based executable resolution,
- repository-relative paths,
- relative paths,
- tool-provided working directories.

Prefer POSIX-style forward slashes as path separators.

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

`mkdir` is a special case. Even when POSIX-style tools are otherwise preferred, `mkdir` commands MUST use cmd.exe-compatible semantics. Do not use `mkdir -p`. `mkdir` must not use any flags. Use plain `mkdir "<path>"`.
``````


PowerShell (`powershell`, `pwsh`) invocation is strictly prohibited. 
