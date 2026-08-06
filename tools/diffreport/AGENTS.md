# AGENTS.md

## Expertise
Expert Python 3 programmer maintaining `diffreport.py` — a dependency-free (stdlib-only) utility that compares two directories of C64OS include headers and generates detailed HTML + text change reports.

## Purpose
`diffreport` produces a human-readable "what changed between C64OS versions" report. It is typically run against two versions of the `include/` tree (e.g. `include/v1.04` vs `include/v1.05`) and writes its output into the target version's `diffs/` directory. Output is a static report with no server requirements:
- `index.html` — main Bootstrap report: summary counts, detailed statistics, and 4-column accordion file lists (all collapsed by default)
- `files.html` — all-files table with toggleable status filter buttons (states persisted in `localStorage`, defaults to Modified-only)
- `files/diff_*.html` — one page per file (two-column side-by-side diff; new file on left, old on right)
- `changes.txt` — plain-text summary plus `difflib.unified_diff` per modified file

## Key concepts
- **Comparison methodology** — files are classified as Added / Removed / Modified / Unchanged. Blank lines are filtered out before deciding Modified status, but are kept for display in the HTML diff. Binary or unreadable files fall back to a size comparison (`except (UnicodeDecodeError, IOError)` blocks).
- **Change counting** — `difflib.SequenceMatcher.get_opcodes()` on non-blank lines; a replace counts as `max(i2-i1, j2-j1)`, delete counts removed lines, insert counts added lines. Counts feed the all-files table and statistics.
- **Word-level highlighting** — within changed lines, `SequenceMatcher` again diffs the two lines and wraps differing spans in `diff_text_add` / `diff_text_sub` spans. All content is HTML-escaped via `html.escape()`.
- **Styling** — Bootstrap 5.3.0 loaded from the jsdelivr CDN (requires network in the browser to render). Layout/coloring CSS lives in the `common_css` string (line ~172); the main report uses its own inline `<style>` block (~line 744).
- **CLI** — positional `dir1_path` (old) and `dir2_path` (new); `--output-dir` (default `report`), `--title`, `--sub-title`, `--version`. Invoked via `compare_directories()`.
- **Safe filenames** — per-file pages are named `diff_<relative_path>` with `/` and spaces replaced by `_` (line ~336). Generated file names can collide after this substitution for paths differing only in those chars.

## Common tasks
- Changing comparison rules (blank-line handling, binary detection, diff algorithm)
- Adjusting HTML/CSS/JS presentation (accordion state, filter buttons, colors, legend)
- Fixing or extending statistics (lines added/removed)
- Adding new report outputs or metadata columns
- Addressing the `DEBUG:` `print`/`console.log` statements scattered throughout the code and generated pages
- Refactoring the monolithic single-file script into modules
- Verifying correctness of HTML escaping / XSS safety for unusual header content

## Code conventions
- **No third-party dependencies** — stdlib only (`os`, `difflib`, `datetime`, `html`, `argparse`). Do not add packages without confirming.
- **No comments** in code unless explicitly requested; keep the existing docstring style if adding a function.
- Match existing patterns: f-strings for HTML generation, `html.escape()` on all user/path-supplied content, `errors='ignore'` + `utf-8` for file reads, `os.path.join` / `os.sep` for paths.
- Every report artifact is generated in one pass of `compare_directories()`; new outputs should follow the same "build string, write file, print confirmation" pattern.
- Preserve backward compatibility of the output layout — reports are linked to each other by fixed relative paths (`../index.html`, `../files.html`, `files/diff_*.html`).

## Verification
- Run against real header trees and sanity-check the generated HTML:
  `python3 tools/diffreport/diffreport.py include/v1.05 include/v1.06 --output-dir /tmp/diffreport-test --title "C64OS API Changes" --sub-title "Changes v1.05 to v1.06"`
- Confirm output files (`index.html`, `files.html`, `changes.txt`, `files/`) are created and that opening `index.html` in a browser renders without errors.
- There is no automated test suite; verify by regenerating a report over a small synthetic tree of text files (added/removed/modified/unchanged/binary) and inspecting counts and highlighting.

## File locations
- Tool source: `tools/diffreport/diffreport.py`
- Report output examples: `include/v1.05/diffs/` (contains `changes.txt`, `files/`, `files.html`, `index.html`)
- Input trees being compared: `include/v1.0X/{os,os_raw}/` under the c64os-dev repo root
