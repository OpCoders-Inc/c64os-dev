
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

for source in w_raw_path.rglob(SUFFIX):
    subpath = source.relative_to(w_raw_path)
    destination = w_temp_path.joinpath(subpath)
    destination.parent.mkdir(parents=True, exist_ok=True)
    shutil.copy2(source, destination)


#
# iterate thru all files and convery them from
# petscii to ascii using the petcat utility
# from the vice emulator distribution
#

filepaths = w_temp_path.glob(r'**/*')
exts = {'.seq'}

petcat = pathlib.Path(PETCAT_PATH).absolute()

for filepath in filepaths:

    # only cleanup convered files

    logging.debug(filepath.absolute())

    if filepath.suffix in exts:

        file = filepath.absolute()
        new_file = os.path.splitext(filepath.absolute())[0]

        logging.debug(file)
        logging.debug(new_file)

        subprocess.run([petcat, "-text", "-o", new_file, "--", file], shell=True, check=False)


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
