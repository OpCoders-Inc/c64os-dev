# Extractor for CAR (C64 Archive) files

This Python script will list or extract files from archives in the ".car" format. These archives will be referred to as "CAR" files below.
A CAR file is a collection of files in the C64 Archive format for Commodore 64 computers.  This format specification was created for the C64 OS operating system.

The `uncar.py` script allows you to get a listing of files in the CAR file or extract the files.  Optionally you can specify the output directory and the C64 OS system directory for some CAR file types.  It also supports wrapping files with SD2IEC compatible headers & file extenions. (.P00 & .S00 being the most common)

It can extract version 2 (v2) or version 3 (v3) CAR files and when listing a v3 it will verify the CRC32 checksum.  The USAGE section below outlines the options.


# USAGE

This script requires Python 3.  Modern systmes often install Python 3 as `python` which is what the examples below will use.  If your system has Python 3 as `python3` adjust the commands accordingly.

On Linux or macOS you can typically make `uncar.py` executable (possibly copying it to `uncar` first) and run it directly.
On Windows you would usually need to run it by running Python and telling it to run `uncar.py` like this: `python uncar.py`

You can get help directly from `uncar.py` by running `python uncar.py -h`
You will get the help below:
```
usage: uncar.py [-h] [-b BASE] [-l] [--scratch] [-s SYSTEM] [-w] archive

positional arguments:
  archive               input archive

options:
  -h, --help            show this help message and exit
  -b BASE, --base BASE  Extraction base target directory.
  -l, --list            Generate a list of files & CRC32.
  --scratch             Delete files if requested by archive.
  -s SYSTEM, --system SYSTEM
                        System directory name, defaults to 'os'.
  -w, --wrap            Wrap files in P00/S00/U00/R00.
```

The script has one required argument which is the name of the CAR file to extract.  If you run `uncar.py` with a single argument of the CAR file name, it will extract it using the current directory as the base as `os` as the system directory name.  With the official `restore.car` file the system directory name (`os`) is embedded in the CAR file and cannot be overridden by the `--system` argument below.

There are optional arguments for `uncar.py`:
 - `--list` will show the contents of the CAR file and the results of the CRC32 calculation on v3. It will not extract the CAR file.
 - `--base` Provides the base or root directory to use for extraction.  Defaults to the current directory.  The system directory (`os` by default or with `restore.car`) is created in the base directory.
 - `--system` overrides the C64 OS System Directory.  Defaults to `os` and is *only* `os` with `restore.car` extraction.
 - `--wrap` Wrap each file as extracted with an SD2IEC compatible header and file extension.  This allows preserving file types like PRG or SEQ and PETSCII filenames.

# Advanced Usage

It is possible to use `uncar.py` to create a fully updated C64 OS SD card by extracting the CAR files in order starting with `restore.car` and using the `--wrap` flag.

This can create a fresh `os` system directory on an SD card in about 3 minutes. You should rename the existing `os` directory to something like `os.back` prior to extracting all of the CAR files.

NOTE: future C64 OS updates may depend on installing updates using the `Installer` Utility so this method should be used with caution.  Generally this method is useful for developers or testers that need a specific version or want to test something on a "clean" installation.

```bash
python uncar.py --wrap restore.car
python uncar.py --wrap 1.01.update.car
python uncar.py --wrap 1.02.update.car
python uncar.py --wrap 1.03.update.car
python uncar.py --wrap 1.04.upd1.03.car
python uncar.py --wrap 1.05.update.car
python uncar.py --wrap 1.06.update.car
python uncar.py --wrap 1.06.patch1.car
```

# Extra
[C64 Archive specification](https://raw.githubusercontent.com/OpCoders-Inc/c64os-dev/refs/heads/main/include/v1.06/os/s/c64archive.t)

