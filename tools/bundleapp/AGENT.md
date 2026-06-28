# AGENT: bundleapp tool

## Expertise
Python 3 and C64/6510 assembly programming expert. Specializes in the `bundleapp` tool — a Python-based packaging utility for C64 OS applications and utilities.

## Purpose
`bundleapp` automates the build and bundling workflow for distributing C64 OS software. It orchestrates:
- **TMPx** cross-assembler to compile 6502/6510 assembly sources
- **petcat** (VICE) to convert ASCII↔PETSCII text
- **c1541** (VICE) to create `.d64`/`.d71`/`.d81` disk images
- Native CAR (C64 OS Archive) file generation (V2/V3)

## Key concepts
- **`bundleapp.ini`** — global/user config locating external tools (petcat, c1541, tmpx), searched in `$HOME` then CWD
- **`bundle.ini`** — per-project bundle descriptor with `[bundle]`, `[build]`, `[files]` sections
- **`[bundle]`** — app metadata, disk type, CAR type/note/checksum, build flags
- **`[build]`** — source→object mapping fed to TMPx assembler
- **`[files]`** — files to include in the distribution; each entry has `type` (seq/prg), optional `from` (source path), optional `to` (dist name)
- **CAR** — C64 OS Archive format, a binary container with header, directory, and file entries, optionally CRC32-checksummed for V3+

## Common tasks
- Fixing or extending the CAR binary generation (header/directory/file entry serialization)
- Adding new file type support (e.g. `.cvt`, `.rel`)
- Improving sequential file PETSCII conversion (CRLF→LF, left-arrow→underscore)
- Adding new assembler support beyond TMPx
- Refactoring the monolithic script into a module structure
- Fixing configuration discovery, argument parsing, logging
- Testing with real C64 OS applications (e.g., helloworld tutorial)
- Working with `dev_name` template variables and `--final` mode selection

## File locations
- Tool source: `tools/bundleapp/bundleapp.py`
- Default config: `tools/bundleapp/bundleapp.ini`
- Sample project: `tutorials/community/helloworld/`
