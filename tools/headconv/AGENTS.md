# AGENTS.md

## Expertise
Expert Python 3 programmer maintaining `headconv.py` — a dependency-free (stdlib-only) utility that converts raw PETSCII include headers from C64 OS into ASCII form usable for cross-platform development with TMPx.

## Purpose
`headconv` transforms C64 OS's raw sequential header files (stored in C64 PETSCII with a 26-byte file header) into plain ASCII files suitable for assembling with TMPx on the host machine. Raw files are read from the `--source` directory, transformed in a temporary directory, and written to `--dest`.

## Key concepts
- **Pipeline** — the whole conversion runs as a series of top-level steps inside `main()` (entry point is `if __name__ == "__main__": main()`):
  1. Parse CLI arguments via `parse_args()`.
  2. Copy every file from `--source` into a temp dir, preserving the directory tree (`rglob('*.*')` + `shutil.copy2`).
  3. Rename all files and directories to lowercase, deepest-first (`lowercase_rename()`).
  4. For every `*.s00` file, strip the first 26 bytes, then run the VICE `petcat` utility with `-text -skip 26 -nh` to convert PETSCII → ASCII, writing to a `*.s` (or `.h`/`.t`) file.
  5. For every `.h`, `.s`, `.t` file, apply string replacements, warn about leftover `{CBM...}` sequences, and write the result under `--dest`.
- **String replacements** — `{CBM-@}` → `_`, `//os` → `os`, `/:@` → `/@`. Special case: `modules.h` also replaces `.macro` → `.segment`.
- **`petcat` dependency** — `petcat.exe` comes from the VICE emulator distribution and is NOT bundled for licensing reasons; its path is given with `--petcat` or resolved from PATH via `find_petcat()` (`shutil.which("petcat")`). Missing petcat is a fatal error (`sys.exit(1)`). `subprocess.run(..., shell=False, check=False)` is used so conversion failures don't halt the run.
- **CLI** — `argparse` in `parse_args()`: `--source`/`-s` (default `./os_raw`), `--dest`/`-d` (default `./os`), `--petcat` (default: PATH search). Missing `--source` directory is a fatal error. No configuration file is read.
- **Unconverted characters** — any output line still containing `{CBM` is logged as a warning, flagging PETSCII chars that lack a conversion.

## Common tasks
- Adding or changing PETSCII→ASCII string replacements (the `.replace()` chain in the `.h`/`.s`/`.t` pass).
- Adjusting the byte-header skip offset (currently 26, `SKIP_BYTES`) or which raw suffix is converted (`CONVERT_EXTS = {'.s00'}`).
- Changing which output suffixes are copied to `--dest` (`OUTPUT_EXTS = {'.h', '.s', '.t'}`).
- Changing CLI options or defaults (in `parse_args()`).
- Improving error handling (currently `check=False` on petcat and a bare `open`/`os.rename`).

## Code conventions
- **No third-party dependencies** — stdlib only (`os`, `pathlib`, `logging`, `sys`, `subprocess`, `argparse`, `tempfile`, `shutil`). Do not add packages without confirming.
- **No comments** in code unless explicitly requested; preserve the existing module docstring style if restructuring.
- Match existing patterns: `pathlib.Path` for paths, `shutil` for copies, chunked reads (`iter(lambda: in_file.read(16384), b'')`) to limit memory usage.
- Keep the single-file structure: `headconv.py`; all config is via CLI arguments in `parse_args()`.

## Verification
- Run against a small synthetic raw tree and confirm output lands under `--dest` with the replacements applied:
  `python3 tools/headconv/headconv.py --source <raw> --dest <out>` (requires `petcat` on PATH or `--petcat <path>`).
- Run from a directory containing `os_raw`/`os` with no arguments to confirm the defaults.
- Simulate the per-file transformation manually on a fixture: strip 26 bytes, run `petcat -text -skip 26 -nh`, then verify the `.replace()` results and that no `{CBM` warnings remain on clean input.
- There is no automated test suite; verify by building a tiny `os_raw` tree (a `.s00` file with a 26-byte prefix and known PETSCII bytes) and inspecting the converted `.s`/`.h`/`.t` output.
- Requires the external `petcat` binary; if it is missing the script exits with a fatal error, so only the `--petcat`/PATH detection can be exercised.

## File locations
- Tool source: `tools/headconv/headconv.py`
- README: `tools/headconv/README.md`
- Raw C64 OS headers: `--source` (default `os_raw`); converted headers written to `--dest` (default `os`)
