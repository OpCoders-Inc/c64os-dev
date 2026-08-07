#!/usr/bin/env python
""" Extraction tool for C64 Archives from C64OS. Requires Python3 """
import argparse
import binascii
import os
import sys
import zlib
from pathlib import Path

ARCHIVE_VERSIONS = [2, 3]
ARCHIVE_TYPES = ["General", "Restore", "Install"]
AT_GENERAL = 0
AT_RESTORE = 1
AT_INSTALL = 2
COMPRESS_TYPE = ["none", "RLE", "LZ"]

# header sizes
ARCHIVE_HEADER = 48
FILE_HEADER = 22

PATH = ""

# pet2ascii characters to remap
REMAP = {0xA4: "_"}


def pet2ascii(petscii):
    """Convert PETSCII string to ASCII with some substitutions."""
    ascii_string = ""
    # based on the algorithm SD2IEC uses for FAT32 names.
    for char in petscii:
        if (128 + 64) < char < (128 + 91):
            char -= 128
        elif (96 - 32) < char < (123 - 32):
            char += 32
        elif (192 - 128) < char < (219 - 128):
            char += 128
        elif char == 255:
            char = "~"
        # remap some special characters
        if char in REMAP:
            char = ord(REMAP[char])
        ascii_string += chr(char)
    return ascii_string


def extract(
    car,
    file_offset,
    base,
    path,
    wrap,
    listing,
    ignorerootentry=False,
    scratch=False,
    version=2,
):
    """Perform the actual extraction.  Called recursively."""
    file_start = file_offset + FILE_HEADER
    header = car[file_offset:file_start]

    # extract header info.
    file_type = chr(header[0])
    # car_lock = header[1]
    car_size = int.from_bytes(header[2:5], "little")

    # the file/directory name is terminated with 0xa0
    car_name = header[5:21]
    end = car_name.find(0xA0)
    if end > 0:
        car_name = car_name[:end]

    # These are always used but empty they are a NOP.
    # They will be filled if wrapping is requested.
    # Which will change the file extension and embed
    # the header.
    wrap_header = bytes()
    wrap_extension = ""
    # If file wrapping is requested we will use the original C64 PETSCII
    # filename from the archive for the embedded header. Before decoding ascii.
    if wrap:
        embedded_pad = bytes()
        # File name is 16 bytes and a 0x00 terminator. (aka 17 bytes)
        for _ in range(17 - len(car_name)):
            embedded_pad += b"\x00"
        # Set last byte (REL file record length) to zero for now.
        wrap_header = b"C64File" + b"\x00" + car_name + embedded_pad + b"\x00"
        if file_type == "-":
            wrap_extension = ""
        else:
            wrap_extension = "." + file_type + "00"

    # Get ASCII compatible filename
    car_name = pet2ascii(car_name)
    car_comp = header[21]

    if file_type != "D":
        filepath = safe_path(base + path + car_name + wrap_extension)

        if file_type == "-":
            if listing:
                print(f"Archive marks file for scratching: {filepath}")
            else:
                if scratch:
                    print(f"Scratching:", end="")
                    if wrap:
                        scratch_p = filepath + ".P00"
                        if not os.path.exists(scratch_p):
                            scratch_p = filepath + ".S00"
                        try:
                            os.remove(scratch_p)
                            print(f" {filepath}")
                        except OSError as error:
                            print(f"{error}")
                    else:
                        try:
                            os.remove(filepath)
                            print(f" {filepath}")
                        except OSError as error:
                            print(f"{error}")
                else:
                    print(f"WARN: NOT scratching: {filepath}")
        else:
            # write out the file.
            data = wrap_header + car[file_start : file_start + car_size]
            if listing:
                crc32 = binascii.crc32(data)
                print(f"{crc32:08x} {file_type} {len(data)} {filepath.lstrip('./')}")
            else:
                print(f"Extracting {filepath} ({len(data)} bytes)")
                if car_comp != 0:
                    print(
                        f"Not extracting {filepath}. Compressed: ({COMPRESS_TYPE[car_comp]})"
                    )
                with open(filepath, "wb") as newfile:
                    newfile.write(data)
        return file_offset + FILE_HEADER + car_size

    # Handle directory entries.
    # The initial entry of an installer archive type is ignored.
    if not ignorerootentry:
        # add trailing '/' after call or it will be stripped
        path = safe_path(path + car_name) + "/"
        if not listing:
            # Create path if it doesn't exist.
            print(f"Creating directory {path}")
            Path(base + path).mkdir(parents=True, exist_ok=True)
    else:
        print(f'Install archive, initial entry note: "{car_name}".')

    # skip over file header (directories have just a header, no data)
    offset = file_offset + FILE_HEADER

    # Call extract for each item in the archive (car_size) and use the returned offset
    # for each subsequent file (or directory)
    for _ in range(0, car_size):
        offset = extract(
            car, offset, base, path, wrap, listing, scratch=scratch, version=version
        )
    # offset points to the next file_header until we reach the end
    # with v3 archives it points to the checksum after the last file/directory entry.
    if version == 3:
        if offset == len(car) - 4:
            file_cksum = int.from_bytes(car[offset:], "little")
            data_cksum = zlib.crc32(car[:-4])
            if file_cksum == data_cksum:
                print(f"INFO: GOOD Checksum: {hex(file_cksum)}")
            else:
                print(
                    f"ERROR: BAD crc32: embedded: {hex(file_cksum)} vs calculated: {hex(data_cksum)}"
                )
            # Mark 4 bytes of CRC32 as handled.
            offset += 4
    return offset


def safe_path(filepath):
    temp = os.path.normpath(filepath)
    if temp[0].isalnum():
        return temp

    # hidden files/directories (start with .) are ok.
    if temp[0] == "." and temp[1].isalnum():
        return temp

    # skip over all '.' and '/' path manipulation characters
    try:
        temp_index = temp.find(next(filter(str.isalpha, temp)))
    except StopIteration:
        return ""
    print(f"WARNING: BOGUS path found {temp}")
    print(f"WARNING: truncating leading non-alphanumerics")
    return temp[temp_index:]


def main():
    """Parse arguments and examine the archive header."""

    parser = argparse.ArgumentParser()
    parser.add_argument("archive", help="input archive")
    parser.add_argument(
        "-b", "--base", default=".", help="Extraction base target directory."
    )
    parser.add_argument(
        "-l", "--list", action="store_true", help="Generate a list of files & CRC32."
    )
    parser.add_argument(
        "--scratch", action="store_true", help="Delete files if requested by archive."
    )
    parser.add_argument(
        "-s", "--system", default="os", help="System directory name, defaults to 'os'."
    )
    parser.add_argument(
        "-w", "--wrap", action="store_true", help="Wrap files in P00/S00/U00/R00."
    )
    args = parser.parse_args()

    base = args.base
    listing = args.list
    scratch = args.scratch
    system = args.system
    wrap = args.wrap

    # We read the archive header and then call
    # extract() with the first file header.
    # Read in the whole archive, they are small.
    try:
        with open(args.archive, "rb") as archive:
            contents = archive.read()
    except (FileNotFoundError, IsADirectoryError, PermissionError) as error:
        print(f"ERROR: {error}", file=sys.stderr)
        sys.exit(1)

    if len(contents) < (ARCHIVE_HEADER + FILE_HEADER):
        print(f"ERROR: Truncated archive file.", file=sys.stderr)
        sys.exit(1)

    # Parse the archive header
    car_type = contents[0]
    car_magic = pet2ascii(contents[1:11])
    car_ver = contents[11]
    car_yr = 1900 + contents[12]
    car_date = f"{car_yr}-{contents[13]:0>2}-{contents[14]:0>2}"
    car_time = f"{contents[15]:0>2}:{contents[16]:0>2}"
    car_note = contents[17:48]
    end = car_note.find(0x00)
    if end > 0:
        car_note = car_note[:end]
    car_note = pet2ascii(car_note)

    # We don't handle non C64 CAR files.
    if car_magic != "C64Archive":
        print(f"ERROR: bad magic: {car_magic}.")
        sys.exit(1)

    # We currently only handle version 2 & 3.
    if car_ver not in ARCHIVE_VERSIONS:
        print(f"ERROR: unsupported archive version: {car_ver}.")
        sys.exit(1)

    # Make sure directories end with a slash.
    if not base.endswith("/"):
        base += "/"
    if not system.endswith("/"):
        system += "/"

    # Installer archives extract into the system directory.
    if car_type == AT_INSTALL:
        base = base + system
        ignorerootentry = True
    else:
        ignorerootentry = False

    # Print out some archive info.
    if car_type <= len(ARCHIVE_TYPES):
        print(f"Archive type: {ARCHIVE_TYPES[car_type]}")
    else:
        print("Archive type: unknown? (please report)")
    print(f"Archive vers: {car_ver}")
    print(f"Archive note: {car_note}")
    print(f"Archive date: {car_date} {car_time}")

    # Skip the archive header to find the initial entry.
    foffset = ARCHIVE_HEADER

    # Call extract with the initial entry. It will
    # recursively extract all files / directories.
    try:
        extract(
            contents,
            foffset,
            base,
            PATH,
            wrap,
            listing,
            ignorerootentry,
            scratch,
            car_ver,
        )
    except Exception as error:
        print(f"ERROR: {error}", file=sys.stderr)
        sys.exit(1)
    sys.exit(0)


if __name__ == "__main__":
    # pylint: disable=no-value-for-parameter
    main()
