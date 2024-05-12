
"""
    bundlapp - C64OS Bundle Application Tool
    ========================================
    
    Summary
    -------
    This python script can be used to bundle the files
    for an application or utility that you would like
    to distribute.
    
    See the README.md for more information on how to
    configure and run the program.

    Archive
    -------
    You may also optionally create a C64 Archive file that
    you can use to distribute your application or utility
    to others.

    The current version of the tool only supports a Generic
    V2 archive file. Better support for V2 and other
    archive types will follow.

    This might eventually be split out into a stand-alone
    utility that other can use to create their own
    C64 Archive files.

    Note
    ----
    For licensing reasons, the utility petcat.exe and
    c1541.exe is not included in this repository. 
    Use the configuration file to specify the path to
    the location of that program on your computer.

    Meta
    ----
    Author:     paul@spocker.net
    Github:     https://github.com/OpCoders-Inc/c64os-dev
    Date:		2024-03-24

"""

import pathlib
import os
import logging
import sys
import subprocess
import configparser
import tempfile

print(__file__)
print(os.path.dirname(os.path.realpath(__file__)))

logging.basicConfig(level=logging.DEBUG)

HOME_PATH = pathlib.Path.home()
logging.debug(HOME_PATH)

file_from = ""
file_to = ""
file_type = ""

#
# find the settings for this run
#

config_filename = os.path.join(HOME_PATH, "bundleapp.ini")
logging.info("checking for configuration file %s", config_filename)

if not os.path.exists(config_filename):
    config_filename = os.path.join(pathlib.Path(os.path.dirname(os.path.realpath(__file__))).absolute(), "bundleapp.ini")
    logging.info("checking for configuration file %s", config_filename)

    if not os.path.exists(config_filename):
        logging.error("configuration file not found -- consult README.md and try again.")
        sys.exit(1)

logging.info("opening configuration file %s", config_filename)
config = configparser.ConfigParser()
config.read(config_filename)

logging.debug(config.sections)

# the location of the petcat utility from vice
PETCAT_PATH = config.get("general", "petcat_path")

# the location of the petcat utility from vice
C1541_PATH = config.get("general", "c1541_path")

# the location of the petcat utility from vice
TMPX_PATH = config.get("general", "tmpx_path")

# a place to store throw away things
TEMP_PATH = tempfile.TemporaryDirectory()

logging.info("CONFIGURATION SETTINGS")
logging.info("======================")
logging.info("PATCAT_PATH:  %s", PETCAT_PATH)
logging.info("C1541_PATH:   %s", C1541_PATH)
logging.info("TMPX_PATH:    %s", TMPX_PATH)
logging.info("TEMP_PATH:    %s", TEMP_PATH.name)

#
# find the bundle.ini in the project folder file
#

bundle_filename = os.path.join(pathlib.Path(os.getcwd()).absolute(), "bundle.ini")

logging.debug("trying to find %s", bundle_filename)

if not os.path.exists(bundle_filename):
    logging.error("the bundle.ini file was not found -- consult README.md and try again.")
    sys.exit(1)

logging.info("opening bundle configuration file %s", bundle_filename)
bundle = configparser.ConfigParser()
bundle.read(bundle_filename)

# the name of the app
APP_NAME = "myapp"
if bundle.has_option("bundle", "app_name"):
    APP_NAME = bundle.get("bundle", "app_name")

# the type of disk to create
DISK_TYPE = ".d64"
if bundle.has_option("bundle", "disk_type"):
    DISK_TYPE = bundle.get("bundle", "disk_type")

# the type of c64 archive to build
CAR_TYPE = "2"
if bundle.has_option("bundle", "car_type"):
    CAR_TYPE = bundle.get("bundle", "car_type")

# should we build the disk
BUILD_DISK = 0
if bundle.has_option("bundle", "build_disk"):
    BUILD_DISK = int(bundle.get("bundle", "build_disk"))

# should we build the car
BUILD_CAR = 0
if bundle.has_option("bundle", "build_car"):
    BUILD_CAR = int(bundle.get("bundle", "build_car"))

final_disk_name = APP_NAME + "." + DISK_TYPE
final_car_name = APP_NAME + ".car"

logging.info("BUNDLE SETTINGS")
logging.info("====================")
logging.info("APP_NAME:     %s", APP_NAME)
logging.info("DISK_TYPE:    %s", DISK_TYPE)
logging.info("CAR_TYPE:     %s", CAR_TYPE)
logging.info("BUILD_DISK:   %s", BUILD_DISK)
logging.info("BUILD_CAR:    %s", BUILD_CAR)

logging.debug("final_disk_name = %s", final_disk_name)
logging.debug("final_car_name = %s", final_car_name)

for section in bundle.sections():
    logging.debug(section)

for file in bundle.options('build'):

    logging.debug("building file %s", file)
    file_src = bundle.get('build', file).strip()
    logging.debug("file source : %s", file_src )
    subprocess.run([TMPX_PATH, file_src, "-o", file], shell=True, check=False)

#
# create the disk
#
if BUILD_DISK > 0:
    create_disk_title = "%s,a1" % APP_NAME
    create_disk_name = "%s" % final_disk_name
    subprocess.run([C1541_PATH, "-format", 
        create_disk_title, 
        DISK_TYPE, 
        create_disk_name], 
        shell=True, 
        check=False)


CAR_DATA = b''

if BUILD_CAR > 0:

    # create the header

    HEADER_STR = """
        .byte 0
        .text "C64Archive"
        .byte 2
        .byte 12
        .byte 03
        .byte 30
        .byte 14
        .byte 18
        .text "123456789012345678901234567890"
        .byte 0
        """
    
    print(HEADER_STR)

    header_filename = os.path.join(TEMP_PATH.name, "header.a")
    header_outfile = os.path.join(TEMP_PATH.name, "header.o")
    header_src = open(header_filename, "w", encoding=None)
    header_src.write(HEADER_STR)
    header_src.seek(0)
    header_src.close()
    subprocess.run([TMPX_PATH, header_filename, "-o", header_outfile], shell=True, check=False)
    header = open(header_outfile, "rb", encoding=None)
    data = header.read()
    header.close()
    print(data)
    CAR_DATA = CAR_DATA + data[2:]

    # create the dir

    file_count = len(bundle['files'])
    name_len = len(APP_NAME)
    name_fill = "$a0," * (16 - name_len)

    DIR_STR = f"""
        .byte "d"
        .byte 0
        .byte {file_count}, 0, 0
        .text "{APP_NAME}"
        .byte {name_fill[:-1]}
        .byte 0
        """
    
    print(DIR_STR)

    dir_filename = os.path.join(TEMP_PATH.name, "dir.a")
    dir_outfile = os.path.join(TEMP_PATH.name, "dir.o")
    dir_src = open(dir_filename, "w", encoding=None)
    dir_src.write(DIR_STR)
    dir_src.seek(0)
    dir_src.close()
    subprocess.run([TMPX_PATH, dir_filename, "-o", dir_outfile], shell=True, check=False)
    header = open(dir_outfile, "rb", encoding=None)
    data = header.read()
    header.close()
    print(data)
    CAR_DATA = CAR_DATA + data[2:]


#
# make sure the bundle file is valid
#
if 'bundle' not in bundle.sections():
    logging.error("your bundle must have a BUNDLE section -- see the README for more help and try again")
    sys.exit(1)

if 'files' not in bundle.sections():
    logging.error("your bundle must have a FILES section -- see the README for more help and try again")
    sys.exit(1)

#
# iterate thru all objects in the files section
#


for file in bundle.options('files'):

    logging.debug("working on file %s", file)
    
    file_props = bundle.get('files', file).strip()
    
    logging.debug("the properties for this file are %s", file_props)
    
    list_props = []
    if len(file_props.strip()) > 0:
        list_props = file_props.split(",")
    
    logging.debug("the properties have been converted to a list %s", list_props)

    logging.debug("the list has %s items", len(list_props))

    if len(list_props) <= 0:
        continue

    curr_index = 0
    file_type = "prg"
    file_from = file
    file_to = file

    for prop in list_props:

        logging.debug("woking on %s", prop)

        prop_index = curr_index
        prop_val = prop

        if (prop.find("=") > 0):
            logging.debug("this is a formal setting %s", prop)
            prop_vals = prop.split("=")
            prop_val = prop_vals[1]
            prop_index_name = prop_vals[0]

            logging.debug("the property is of %s", prop_index_name)
            logging.debug("the propery value is %s", prop_val)

            if prop_index_name == "type":
                prop_index = 0

            if prop_index_name == "from":
                prop_index = 1

            if prop_index_name == "tp":
                prop_index = 2

        logging.debug("prop_index = %s", prop_index)
        logging.debug("prop_val = %s", prop_val)

        if prop_index == 0:
            file_type = prop_val

        if prop_index == 1:
            file_from = prop_val

        if prop_index == 2:
            file_to = prop_val
        
        curr_index += 1

    logging.debug("file type:   %s", file_type)
    logging.debug("file from:   %s", file_from)
    logging.debug("file to:     %s", file_to)

    final_file_from = file_from
    final_file_to = file_to

    #
    # convert a file from ascii to petscii
    #

    if file_type == "seq":

        logging.debug('converting crlf to lf in file %s', file_from)

        # create temp file that removes the crlf with just lf
        
        CRLF = b'\r\n'
        LF = b'\n'
 
        with open(file_from, 'rb') as open_file:
            content = open_file.read()

        content = content.replace(CRLF, LF)

        logging.debug(content)

        new_from_file = tempfile.TemporaryFile(delete=False)

        with open(new_from_file.name, 'wb') as open_file:
            open_file.write(content)

        subprocess.run([PETCAT_PATH, "-text", "-w2", "-o", file_to, "--", new_from_file.name], shell=True, check=False)

        # convert left arrow to underscore (as intended)

        with open(file_to, 'rb') as open_file:

            LEFT_ARROW = b'\x5f'
            UNDERSCORE = b'\xa4'
            content = open_file.read()
            content = content.replace(LEFT_ARROW, UNDERSCORE)

        with open(file_to, 'wb') as open_file:
            open_file.write(content)

        final_file_from = file_to
        final_file_to = f"{file_to},s"

    #
    # add a file to the disk with type if requested
    #

    logging.debug("final_file_from = %s", final_file_from)
    logging.debug("final_file_to = %s", final_file_to)

    if BUILD_DISK > 0:
        subprocess.run([C1541_PATH, "-attach", create_disk_name, "-write", final_file_from, final_file_to], shell=True, check=False)

    if BUILD_CAR > 0:

        data_file_from = open(final_file_from, "rb", encoding=None)
        data = data_file_from.read()
        data_file_from.close()

        # if file_type != "seq":
        #     data = data[2:]

        name_len = len(file_to)
        name_fill = "$a0," * (16 - name_len)
        data_len_zen = 0
        data_len_hi = len(data) // 256
        data_len_lo = abs((data_len_hi * 256) - len(data))

        data_type = file_type[0]

        FILE_STR = f"""
            .byte "{data_type}"
            .byte 0
            .byte {data_len_lo}, {data_len_hi}, {data_len_zen}
            .text "{file_to}"
            .byte {name_fill[:-1]}
            .byte 0
            """
        
        print(FILE_STR)

        file_filename = os.path.join(TEMP_PATH.name, "file.a")
        file_outfilename = os.path.join(TEMP_PATH.name, "file.o")
        file_src = open(file_filename, "w", encoding=None)
        file_src.write(FILE_STR)
        file_src.seek(0)
        file_src.close()
        subprocess.run([TMPX_PATH, file_filename, "-o", file_outfilename], shell=True, check=False)
        file_outfile = open(file_outfilename, "rb", encoding=None)
        file_data = file_outfile.read()
        file_outfile.close()
        print(file_data)
        CAR_DATA = CAR_DATA + file_data[2:]
        CAR_DATA = CAR_DATA + data

if BUILD_CAR > 0:
    print(CAR_DATA)
    f = open(final_car_name, "wb")
    f.write(CAR_DATA)
    f.close

sys.exit(0)
