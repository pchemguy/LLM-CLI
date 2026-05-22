Note: remove outer code block before copying into `.codex/AGENTS.md`.

``````markdown
PowerShell MUST NOT be used. shell_command, if reports PowerShell, cannot be used.

Git Bash and `m2-base` (Conda/MSYS2 environment) are available and SHOULD be preferred when shell command execution is available. The environment provides POSIX-style shell semantics, MSYS2 runtime compatibility, and standard Unix command-line utilities. These programs are on the PATH. You are prohibited from using default absolute paths.

DO NOT EVER PUT

- cmd /c
- cmd.exe /c
- bash -c
- bash -lc

inside command string.

YOU ARE NOT ALLOWED TO CALL BASH, but YOU CAN CALL ANY COMMANDS, such as grep, sed, etc directly! When calling `sed` command string MUST BEGIN WITH `sed`:
ALLOWED: "sed -n..."
PROHIBITTED: "bash -c 'sed -n..."
``````