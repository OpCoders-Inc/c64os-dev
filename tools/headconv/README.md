# headconv
This tool can be used to convert the include headers for [C64OS](https://c64os.com/).

The tool is a python script that does not need any external libraries to run, so it should be relatively easy to setup and run.

Most people will never need to use this tool because it is for the developers who are doing cross system development for C64OS and need the headers for assembling.

## How To Run This Tool

`headconv` needs only a Python 3 interpreter and the `petcat` utility from the [VICE](https://vice-emu.sourceforge.io/) emulator distribution. `petcat` is not bundled for licensing reasons; either have it on your PATH or point to it with `--petcat`.

```
python3 tools/headconv/headconv.py --source <raw-dir> --dest <out-dir> [--petcat <path>]
```

Run without any options to convert `./os_raw` into `./os` in the current directory:

```
python3 tools/headconv/headconv.py
```

### Command Line Options

| Option | Description | Default |
| ------ | ----------- | ------- |
| `--source`, `-s` | Directory containing the raw C64 OS headers | `./os_raw` |
| `--dest`, `-d` | Destination directory for the converted headers | `./os` |
| `--petcat` | Path to the `petcat` utility | Searched on PATH |

The destination directory is created if it does not already exist. If `petcat` cannot be found, the script prints an error and exits.

## How It Works

1. Every file from `--source` is copied into a temporary directory, preserving the directory tree.
2. All files and directories are renamed to lowercase (so `H/flock.h.S00` becomes `h/flock.h.s00`).
3. Each `*.s00` file has its 26-byte `C64File` header stripped, then `petcat -text -skip 26 -nh` converts the PETSCII content to ASCII, producing `*.h`, `*.s`, and `*.t` files.
4. The converted files are post-processed for cross-platform assembly:
   - `{CBM-@}` is replaced with `_` (the C64 OS pointer glyph)
   - `//os` is replaced with `os` and `/:@` with `/@` (TMPx path handling)
   - in `modules.h`, `.macro` is replaced with `.segment`
   - any line still containing `{CBM` is logged as a warning, flagging PETSCII characters that lack a conversion
5. The results are written to `--dest`, preserving the directory structure.
