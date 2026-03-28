# LLM CLI

Python-based setup of LLM CLIs.

- `Anaconda.bat` bootstraps and prepares Python environment
- `conda_far.bat` starts an activated shell / Far Manager
- `conda_far_wrapper.bat` wraps `conda_far.bat` and kills hanging `PowerShell.exe` process (`conda_far.bat` alternative)
- `llm-cli.bat` must be executed after Python environment is created and installs LLM CLIs into Python environment
- `llm-cli_wrapper.bat` wraps `llm-cli.bat` and kills hanging `PowerShell.exe` process (`llm-cli.bat` alternative)

Installed LLM CLIs are accessible from a Conda activated shell (`conda_far.bat`).

## LLM CLI Installers

- Gemini CLI (https://github.com/google-gemini/gemini-cli and https://geminicli.com)
- Codex CLI (https://developers.openai.com/codex/cli and https://github.com/openai/codex)
- Claude Code (https://code.claude.com/docs/en/overview)
