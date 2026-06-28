# TECHNICAL: bundleapp

## Overview
A Python 3 procedural script that bundles C64 OS applications for distribution. It acts as a build orchestrator and packaging tool, producing disk images (`.d64`) and/or C64 OS Archive files (`.car`).

## Architecture
Monolithic single-file Python script with no external dependencies beyond the standard library. Execution is linear with four phases:

### Phase 1 — Configuration Loading (lines 64–214)
1. Parse CLI args: `--debug`, `--info`, `--final`
2. Locate `bundleapp.ini` in `$HOME` then CWD — contains paths to external tools
3. Locate `bundle.ini` in CWD — the per-project bundle descriptor
4. Read all settings into module-level global variables
5. Resolve `DIST_NAME`: if `--final` → `app_name`; else substitute `{key}` placeholders in `dev_name` from `[bundle]` vars

### Phase 2 — Build Sources (lines 227–237)
Iterates `[build]` section of `bundle.ini`. For each `object=source` entry:
- Calls TMPx: `tmpx -i <src_path> -o <out_path>`

### Phase 3 — Disk Image Creation (lines 242–251)
If `disk_build > 0`:
- Calls c1541 to format a blank disk: `c1541 -format "<name>,a1" <disk_type> <filename>`
- Files are written to the disk later during Phase 4

### Phase 4 — File Processing & Output (lines 340–548)
Iterates `[files]` section. Each entry specifies a file with optional `type`, `from`, `to`:

**SEQ files** (lines 449–458):
1. Read source file, replace CRLF→LF
2. Call `petscii_bytes()` — native Python ASCII→PETSCII conversion (handles uppercase bit 7, lowercase bit 5 cleared, LF→CR, underscore→$A4)
3. Write to output file

**PRG files**: used as-is from the build output.

**Disk write** (line 467): `c1541 -attach <disk> -write <file_from> <file_to>`

**CAR archive** (lines 253–548): If `car_build > 0`, builds a binary archive in memory:

#### CAR Binary Format
The archive is built by assembling small assembly snippets with TMPx, then stripping the 2-byte load address prefix:

| Section | Assembly template | Bytes |
|---|---|---|
| **Header** (lines 262–289) | Magic "C64Archive", type byte, date (YY/MM/DD/HH/MI), 30-char note, null | ~41 |
| **Directory** (lines 297–321) | `"d\0"`, file count (16-bit LE), app name padded with `$a0` to 16 chars, null | variable |
| **File entries** (lines 486–510) | Type char, `\0`, data length (24-bit LE), filename padded to 16 with `$a0`, null, raw data | 20+name + data |

**V3 checksum** (lines 516–531):
- CRC32 of entire `CAR_DATA` appended as 4 bytes (little-endian byte order)
- Distribution checksum printed to stdout

## Key Data Flow
```
bundle.ini
  ├─ [build]  ──→ TMPx ──→ .o files in OUT_PATH
  ├─ [files]  ──→ petscii_bytes() (for seq) ──→ OUT_PATH
  └─ [bundle] ──→ c1541 ──→ .d64
                ──→ direct byte generation ──→ .car
```

## Configuration Reference

### `bundleapp.ini` (global tool config)
```ini
[general]
c1541_path=            ; path to VICE c1541.exe
tmpx_path=             ; path to TMPx cross-assembler
```

### `bundle.ini` (per-project)
```ini
[bundle]
app_name=              ; project name (used for disk/archive naming, and release builds)
dev_name=              ; template for test/dev builds, supports {key} substitution
disk_build=0|1         ; create disk image?
disk_type=d64          ; d64|d71|d81
car_build=0|1          ; create CAR archive?
car_type=2|3           ; archive format version
car_note=              ; 30-char installer note
car_checksum=0|1       ; V3+ internal CRC32?
src_path=              ; source directory prefix
out_path=out           ; output directory (default: "out")
; any extra keys in [bundle] can be used as {key} variables in dev_name

[build]
object.ext=source.ext  ; TMPx source → object mapping

[files]
filename=type[,from][,to]
; type: seq | prg
; from: source path (defaults to filename)
; to:   dist filename (defaults to filename)
; positional or key=value forms supported:
;   about.t=seq,about.txt          → positional (type=seq, from=about.txt)
;   main.o=from=main.o,type=prg   → keyword
```

#### Dynamic Package Name Resolution
- `--final` CLI flag → release build: `DIST_NAME = app_name`
- No flag → dev build: `dev_name` template is resolved by replacing `{key}` with values from `[bundle]` section
- If `dev_name` is not set, dev build falls back to `app_name`
- `DIST_NAME` controls: disk filename, CAR filename, disk volume title, CAR directory entry (C64 OS folder name)

## Known Issues & Technical Debt
1. **Monolithic design** — all logic is in a single script; no classes, no modularity, hard to unit test
2. **TMPx-only build** — hardcoded; no abstraction for alternative assemblers
3. **Error handling** — `subprocess.run` results are printed but return codes not checked; failures may go unnoticed (except via TMPx/c1541 stderr)
4. **File property parser** — mixes positional and keyword argument parsing with a fragile index-based approach
5. **No dry-run mode** — no way to preview what would be built

## Testing
The helloworld sample at `tutorials/community/helloworld/` serves as an integration test. Run from that directory with a configured `bundleapp.ini`.

## External Dependencies
- **TMPx** — 6502 cross-assembler (https://style64.org/release/tmpx-v1.1.0-style)
- **VICE** — `c1541` for disk image manipulation (https://vice-emu.sourceforge.io/)
