
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
    included in this repository. Use the configuration
    file to specify the path to the location of that
    program on your computer.

    Meta
    ----
    Author:     paul@spocker.net
    Github:     https://github.com/OpCoders-Inc/c64os-dev
    Date:         2024-02-20

"""

import pathlib
import os
import logging
import sys
import subprocess
import configparser
import tempfile
import shutil

def lowercase_rename(folder):
    print(folder)
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



logging.basicConfig(level=logging.DEBUG)

HOME_PATH = pathlib.Path.home()
logging.debug(HOME_PATH)

config_filename = os.path.join(HOME_PATH, "headconv.ini")
logging.info("checking for configuration file %s", config_filename)

if not os.path.exists(config_filename):
    config_filename = os.path.join(pathlib.Path(os.getcwd()).absolute(), "headconv.ini")
    logging.info("checking for configuration file %s", config_filename)

    if not os.path.exists(config_filename):
        logging.error("configuration file not found -- consult README.md and try again.")
        sys.exit(1)

logging.info("opening configuration file %s", config_filename)
config = configparser.ConfigParser()
config.read(config_filename)

logging.debug(config.sections)
# the final destination for converted files
OS_PATH = config.get("general", "os_path")
# the location of the raw files from c64os
OS_RAW_PATH = config.get("general", "os_raw_path")
# the location of the petcat utility from vice
PETCAT_PATH = config.get("general", "petcat_path")

TEMP_PATH = tempfile.TemporaryDirectory()

logging.info("CONFIGURATION SETTINGS")
logging.info("======================")
logging.info("OS_PATH:      %s", OS_PATH)
logging.info("OS_RAW_PATH:  %s", OS_RAW_PATH)
logging.info("PATCAT_PATH:  %s", PETCAT_PATH)
logging.info("TEMP_PATH:    %s", TEMP_PATH.name)

#
# copy raw file to a temp location for transforming
#

SUFFIX = "*.*"

w_raw_path = pathlib.Path(OS_RAW_PATH)
w_temp_path = pathlib.Path(TEMP_PATH.name)

logging.debug(w_raw_path)
logging.debug(w_raw_path.rglob(SUFFIX))

for source in w_raw_path.rglob(SUFFIX):
    subpath = source.relative_to(w_raw_path)
    destination = w_temp_path.joinpath(subpath)
    destination.parent.mkdir(parents=True, exist_ok=True)
    shutil.copy2(source, destination)

# convert all files to lowercase

lowercase_rename(w_temp_path)

# folder = w_temp_path
# for path in pathlib.Path(folder).glob("*.*"):
#     path2 = path.parent.joinpath(str(path.name).lower())
#     shutil.move(path, path2)   

# for file in os.listdir(w_temp_path):
#     os.rename(os.path.join(w_temp_path, file), os.path.join(w_temp_path, file.lower()))


#
# iterate thru all files and convery them from
# petscii to ascii using the petcat utility
# from the vice emulator distribution
#

filepaths = w_temp_path.glob(r'**/*')
exts = {'.s00'}

petcat = pathlib.Path(PETCAT_PATH).absolute()

for filepath in filepaths:

    # only cleanup convered files
    logging.debug(filepath.absolute())

    if filepath.suffix in exts:

        cleanfile = filepath.with_suffix(".z")
        print(cleanfile)

        # copy file to temp skipping first 26 bytes

        with open(filepath, 'rb') as in_file:

            in_file.seek(26)  # Skip the first 26 bytes

            with open(cleanfile, 'wb') as out_file:
                # Copy the rest of the file in chunks to avoid high memory usage
                for chunk in iter(lambda: in_file.read(16384), b''):
                    out_file.write(chunk)   

        file = cleanfile.absolute()
        new_file = os.path.splitext(filepath.absolute())[0]

        logging.debug(file)
        logging.debug(new_file)

        opts = [petcat, "-text", "-skip", "26", "-nh", "-o", new_file, "--", file]
        print(opts)
        subprocess.run(opts, shell=False, check=False)


#
# iterate thru all the transformed files and
# put them in the final destination path
# specified in the configuration file
#

filepaths = w_temp_path.glob(r'**/*')
exts = {'.h', '.s', '.t'}

for filepath in filepaths:

    # only cleanup converted files

    if filepath.suffix in exts:

        logging.debug(filepath.absolute())
        file = open(filepath.absolute(), 'r', encoding='utf-8')
        file_contents = file.read()
        file_contents = file_contents.rstrip()
        file.close()

        # replace strings needed for cross platform development

        new_file_contents = file_contents.replace('{CBM-@}', '_')
        new_file_contents = new_file_contents.replace('//os', 'os')
        new_file_contents = new_file_contents.replace('/:@', '/@')

        # in the modules.h file we need to use .segment instead of .macro
        # :todo why??

        logging.debug(filepath.name)
        if filepath.name == 'modules.h':
            new_file_contents = new_file_contents.replace('.macro', '.segment')

        new_file_lines = new_file_contents.splitlines()

        # search for any new special characters we have
        # not yet converted (usually start with {CBM})

        for line in new_file_lines:
            if line.find('{CBM') > 0:
                logging.warning(line)

        new_filepath = str(filepath)[len(TEMP_PATH.name):]
        new_filename = pathlib.Path(OS_PATH + new_filepath)

        os.makedirs(os.path.dirname(new_filename),exist_ok=True)

        new_file = open(new_filename, 'w', encoding='utf-8')
        new_file.write(new_file_contents)
        new_file.close()


sys.exit(0)
