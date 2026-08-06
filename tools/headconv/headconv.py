
"""
    headconv - C64OS Headers Conversion
    ==================================
    
    Summary
    -------
    This python script can be used to convert the raw
    sequential header files from C64OS into a format
    usable when doing cross platform development using
    TMPx.

    See the README.md for more information on how to
    configure and run the program.

    Note
    ----
    For licensing reasons, the utility petcat.exe is not
    included in this repository. Specify its location with
    the --petcat option, or make sure it is on your PATH.

    Meta
    ----
    Author:     paul@spocker.net
    Github:     https://github.com/OpCoders-Inc/c64os-dev
    Date:         2024-02-20

"""

import argparse
import logging
import os
import pathlib
import shutil
import subprocess
import sys
import tempfile

SUFFIX = "*.*"
SKIP_BYTES = 26
CONVERT_EXTS = {'.s00'}
OUTPUT_EXTS = {'.h', '.s', '.t'}

def lowercase_rename(folder):
    logging.debug(folder)
    # Rename all subdirectories and files, starting from the bottom
    for root, dirs, files in os.walk(folder, topdown=False):
        # Rename directories
        for dr in dirs:
            old_path = os.path.join(root, dr)
            new_path = os.path.join(root, dr.lower())
            if old_path != new_path:
                os.rename(old_path, new_path)
        # Rename files
        for f in files:
            old_path = os.path.join(root, f)
            new_path = os.path.join(root, f.lower())
            if old_path != new_path:
                os.rename(old_path, new_path)

def parse_args():
    parser = argparse.ArgumentParser(
        description="Convert raw C64 OS headers into ASCII form for cross-platform development with TMPx"
    )
    parser.add_argument("-s", "--source", default="os_raw",
                        help="directory containing the raw C64 OS headers (default: ./os_raw)")
    parser.add_argument("-d", "--dest", default="os",
                        help="destination directory for the converted headers (default: ./os)")
    parser.add_argument("--petcat", default=None,
                        help="path to the petcat utility; if omitted it is searched on PATH")
    return parser.parse_args()

def find_petcat(petcat_path):
    if petcat_path:
        petcat = pathlib.Path(petcat_path).absolute()
    else:
        found = shutil.which("petcat")
        petcat = pathlib.Path(found) if found else None
    if not petcat or not os.path.exists(petcat):
        logging.error("petcat not found -- specify its location with --petcat or add it to PATH.")
        sys.exit(1)
    return petcat

def main():
    logging.basicConfig(level=logging.DEBUG)

    args = parse_args()

    source_path = pathlib.Path(args.source)
    dest_path = pathlib.Path(args.dest)

    if not source_path.exists() or not source_path.is_dir():
        logging.error("source directory not found: %s", source_path)
        sys.exit(1)

    petcat = find_petcat(args.petcat)

    temp_path = tempfile.TemporaryDirectory()

    logging.info("SETTINGS")
    logging.info("========")
    logging.info("SOURCE_PATH:  %s", source_path)
    logging.info("DEST_PATH:    %s", dest_path)
    logging.info("PETCAT_PATH:  %s", petcat)
    logging.info("TEMP_PATH:    %s", temp_path.name)

    #
    # copy raw file to a temp location for transforming
    #

    w_raw_path = source_path
    w_temp_path = pathlib.Path(temp_path.name)

    logging.debug(w_raw_path)
    logging.debug(w_raw_path.rglob(SUFFIX))

    for source in w_raw_path.rglob(SUFFIX):
        subpath = source.relative_to(w_raw_path)
        destination = w_temp_path.joinpath(subpath)
        destination.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(source, destination)

    # convert all files to lowercase

    lowercase_rename(w_temp_path)

    #
    # iterate thru all files and convery them from
    # petscii to ascii using the petcat utility
    # from the vice emulator distribution
    #

    for filepath in w_temp_path.glob(r'**/*'):

        # only cleanup convered files
        logging.debug(filepath.absolute())

        if filepath.suffix in CONVERT_EXTS:

            cleanfile = filepath.with_suffix(".z")
            logging.debug(cleanfile)

            # copy file to temp skipping first 26 bytes

            with open(filepath, 'rb') as in_file:

                in_file.seek(SKIP_BYTES)  # Skip the first 26 bytes

                with open(cleanfile, 'wb') as out_file:
                    # Copy the rest of the file in chunks to avoid high memory usage
                    for chunk in iter(lambda: in_file.read(16384), b''):
                        out_file.write(chunk)

            file = cleanfile.absolute()
            new_file = os.path.splitext(filepath.absolute())[0]

            logging.debug(file)
            logging.debug(new_file)

            opts = [petcat, "-text", "-skip", "26", "-nh", "-o", new_file, "--", file]
            logging.debug(opts)
            subprocess.run(opts, shell=False, check=False)

    #
    # iterate thru all the transformed files and
    # put them in the final destination path
    # specified on the command line
    #

    for filepath in w_temp_path.glob(r'**/*'):

        # only cleanup converted files

        if filepath.suffix in OUTPUT_EXTS:

            logging.debug(filepath.absolute())
            with open(filepath.absolute(), 'r', encoding='utf-8') as file:
                file_contents = file.read().rstrip()

            # replace strings needed for cross platform development

            new_file_contents = file_contents.replace('{CBM-@}', '_')
            new_file_contents = new_file_contents.replace('//os', 'os')
            new_file_contents = new_file_contents.replace('/:@', '/@')

            # in the modules.h file we need to use .segment instead of .macro
            # TMPx: .macro implies .block/.bend (local label scope), while
            # .segment defines the macro without the implied block, keeping the
            # labels of .include'd module files global.
            # see https://turbo.style64.org/docs/turbo-macro-pro-tmpx-syntax

            logging.debug(filepath.name)
            if filepath.name == 'modules.h':
                new_file_contents = new_file_contents.replace('.macro', '.segment')

            new_file_lines = new_file_contents.splitlines()

            # search for any new special characters we have
            # not yet converted (usually start with {CBM})

            for line in new_file_lines:
                if line.find('{CBM') > 0:
                    logging.warning(line)

            new_filepath = str(filepath)[len(temp_path.name):]
            new_filename = pathlib.Path(str(dest_path) + new_filepath)

            os.makedirs(os.path.dirname(new_filename), exist_ok=True)

            with open(new_filename, 'w', encoding='utf-8') as new_file:
                new_file.write(new_file_contents)

if __name__ == "__main__":
    main()
