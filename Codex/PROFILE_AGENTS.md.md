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

Do not duplicate the same command wrapper. The forbidden pattern is repeating the same wrapper back-to-back.

Allowed:

```bash
cmd.exe /c git status
bash -c 'git status'
```

Forbidden:

```bash
cmd.exe /c "cmd.exe /c git status"
cmd /c "cmd /c git status"
bash -c "bash -c 'git status'"
```

Prefer Git Bash directly when POSIX shell execution is needed:

```bash
bash -c 'git status'
```

PowerShell is also prohibited. If a tool reports that it is running PowerShell, stop and do not use that shell.

All Git Bash and `m2-base` commands must run outside the sandbox when command execution is available.
``````