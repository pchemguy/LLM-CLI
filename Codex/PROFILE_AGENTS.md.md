Note: remove outer code block before copying into `.codex/AGENTS.md`.

``````markdown
PowerShell MUST NOT be used. shell_command, if reports PowerShell, cannot be used.

Git Bash and `m2-base` (Conda/MSYS2 environment) are available and SHOULD be preferred when shell command execution is available. The environment provides POSIX-style shell semantics, MSYS2 runtime compatibility, and standard Unix command-line utilities. These programs are on the PATH. You are prohibited from using default absolute paths.

You MUST use either (both are available)

- cmd.exe /c <command>
  cmd.exe /c git status
- bash -c '<command>'
  bash -c 'git status'

You MUST always run Git Bash and `m2-base` commands outside sandbox.

DO NOT EVER PUT "cmd /c" or "cmd.exe /c" inside command string.
``````