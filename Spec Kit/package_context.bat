:: -----------------------------------------------------------------------------
:: SPEC_KIT_CONTEXT Generator
:: -----------------------------------------------------------------------------
::
:: Purpose
:: -------
:: Recursively traverses a given directory subtree and generates a single
:: Markdown file (`SPEC_KIT_CONTEXT.md`) that contains:
::
::   1. A header line for each file representing its normalized relative path
::   2. The full contents of that file wrapped in code fences
::
:: The output is intended to serve as a consolidated context artifact
:: (e.g., for LLM ingestion, documentation bundling, or audit snapshots).
::
::
:: Usage
:: -----
::   script.cmd <subtree_root>
::
:: Arguments
:: ---------
::   <subtree_root>   Path to the directory to traverse recursively.
::
:: Behavior
:: --------
:: - Validates that <subtree_root> is provided and exists.
:: - Deletes any existing `SPEC_KIT_CONTEXT.md` in the script directory.
:: - Recursively enumerates all files under <subtree_root>.
:: - For each file:
::
::     a) Computes a normalized relative path:
::        - Converts '\' to '/'
::        - Removes drive letter (e.g., 'C:\' to '@/')
::        - Rewrites root prefix into '@/' namespace
::
::     b) Emits a Markdown section:
::
::        # <normalized_relative_path>
::
::        ~~~~~
::        <file contents>
::        ~~~~~
::
:: - Appends all output to a single file:
::     %~dp0SPEC_KIT_CONTEXT.md
::
::
:: Path Normalization Model
:: ------------------------
:: - Absolute Windows paths are transformed into a pseudo-rooted namespace:
::
::     C:\repo\subdir\file.txt
::       to @/repo/subdir/file.txt
::
:: - The provided subtree root becomes the logical base; all emitted paths
::   are relative to that base after normalization.
::
::
:: Requirements / Assumptions
:: -------------------------
:: - Assumes files are text-readable via `type`.
:: - Assumes no need to filter binary or large files.
::
::
:: Limitations
:: -----------
:: - Binary files will be included verbatim and may corrupt the output.
:: - Very large trees may produce extremely large output files.
:: - No filtering by extension, size, or encoding is performed.
:: - No error handling for unreadable files.
::
::
:: Exit Conditions
:: ---------------
:: - Exits with code 1 if:
::     - No argument is provided
::     - The provided path does not exist
::
:: -----------------------------------------------------------------------------

@echo off


echo(

if "%~1"=="" (
    echo [ERROR]: Subtree root is not provided. Aborting...
    exit /b 1
)

if not exist "%~1" (
    echo [ERROR]: Subtree root is not found. Aborting...
    exit /b 1
)

set "SPEC_KIT_CONTEXT=%~dp0SPEC_KIT_CONTEXT.md"
if exist "%SPEC_KIT_CONTEXT%" (del "%SPEC_KIT_CONTEXT%")

set "ROOT=%~1"
cd /d "%ROOT%"

set "PARENT=%CD%"
set "PARENT=%PARENT:\=/%"
set "PARENT=@%PARENT:~2%/"

for /r %%F in (*) do (
    set "PREFIX=%%~dpF"
    set "PREFIX=@!PREFIX:~2!"
    set "PREFIX=!PREFIX:\=/!"
    set "PREFIX=!PREFIX:%PARENT%=!"
    set "NAME=%%~nxF"

    echo # !PREFIX!!NAME!
    echo(
    echo ~~~~~
    type "%%F"
    echo ~~~~~
    echo(
) >> "%SPEC_KIT_CONTEXT%"
