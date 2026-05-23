Note: remove outer code block before copying into `.codex/AGENTS.md`.

``````markdown
PowerShell MUST NOT be used. shell_command, if reports PowerShell, cannot be used.

Git Bash and `m2-base` (Conda/MSYS2 environment) are available and SHOULD be preferred when shell command execution is available. The environment provides POSIX-style shell semantics, MSYS2 runtime compatibility, and standard Unix command-line utilities. These programs are on the PATH. You are prohibited from using default absolute paths. `m2-base` commands must always be executed outside sandbox.

YOU ARE NOT ALLOWED to start a command string with a shell call (e.g., `cmd /c` or `bash -c`) or include explicit shell calls inside command string. When calling any shell commands, call them directly, strating command string with the desired command, such as `cd`, `mkdir`, `grep`, `sed`, etc.

Command string examples, when calling shell commands:

- **ALLOWED**:
    - sed -n ...
    - mkdir ...
    - git status
- **PROHIBITED**
    - bash -c 'sed -n ...'
    - bash -c 'git status'
    - bash -lc 'grep ...'
    - cmd /c mkdir ...
    - cmd.exe /c cd ...

When calling `mkdir`, you must use cmd.exe-style semantics: do NOT include the POSIX-style `-p` flag. Windows shell creates intermidiate dirs without the `-p` flag, not supported by cmd.exe.
``````
