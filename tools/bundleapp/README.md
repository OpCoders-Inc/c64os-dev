# bundleapp
This is a tool, similar to make that can be used to build and bundle a C64OS application or utlity for you to distribute.

The tool is a python script that does not need any external libraries to run, so it should be relatively easy to setup and run.

## What Is The `bundleapp.ini` File?
This is a configuration file for the tool that will set the location of the utilities that are needed to build and bundle your application.

The contents looks like this
```ini
[general]
petcat_path=petcat.exe
c1541_path=c1541.exe
tmpx_path=tmpx.exe
```

There are two places where you can put this file. The first place is in your home folder on your computer. On Windows, this might be

```
c:\Users\Paul
```

while on Unix or MacOs it might be

```
/home/paul
```

The second place this file is searched for is in the current directory that you are running this tool from. So for that, the best place would be in your project folder where you keep the files that are part of your application.

The `helloworld` sample application has an example of how to use the bundleapp utility.

Regardless, create a copy of the `bindleapp.ini` file from this tool folder and place it in one of those two locations.

Then you can edit the file, and change the settings to let the tool know where some of the other programs it needs are located.

### PETCAT_PATH
The path and filename to the petcat utility. This utility is used to convert PETSCII to ASCII and vice-versa.

### C1541_PATH
The path and filename to the c1541 utility. This utility is used to create a distribution disk for your application.

### TMPX_PATH
The path and filename to the TMPx cross compiler from style. You can find the compiler at [this link](https://style64.org/release/tmpx-v1.1.0-style).

## What Is The `bundle.ini` File?
This file is used to tell the tool what needs to be bundled for your application.

The `helloworld` application has a bundle file that looks like this

```ini
[bundle]
app_name=helloworld
car_note=The Hello World App
car_date=[current]
disk_type=d64
car_type=2
disk_build=0
car_build=0
car_checksum=0

[build]
main.o=main.a

[files]
about.t=seq,about.txt
main.o=from=main.prg,type=prg
menu.m=seq,menu.txt
msg=seq,msg.txt,msg.t
```

### The `Bundle` Section
This section is used to tell the tool what some of the basic parts of the bundle are.

#### APP_NAME
This is the name of the application, and is also the name of the disk that is created, and also the name of the archive file that will be created.

#### DISK_BUILD 
This setting is used to control if you want to create an actual disk image.

- 0 = No (default)
- 1 = Yes

#### DISK_TYPE
This is an optional setting that you can use to change the type of disk you want to distribute your bundle in. The default is D64, and usually that is big enough for most applications, but the option is there. 

You can use any disk type supported by the C1541 utility that is provided by the VICE team.

Supported Types

`d64, d81, d71`

#### CAR_BUILD 
This setting is used to control if you want to create a C64 OS Archive file for distribution. 

- 0 = No (default)
- 1 = Yes

#### CAR_TYPE
This setting controls the type of C64 OS Archive file to create. The default value here is 0, which is a Generic archive type.

The tool currently supports up to a Version 3 archive type.

#### CAR_NOTE
This will provide the note in the installer application when opened, up to 30 characters.

#### CAR_CHECKSUM 
When archive type 3 is specified, you may optionally include a checksum on the file. Turn this setting on to calculate and print the CRC32 generated checksums of the CAR file.

### The `Build` Section
This section can be used to build file using the TMPx compiler. In future version, alternative assemblers like 64TASS might be supported.

The format of each file is as follows:

`object=source`

#### OBJECT
This is the name of the object that you want created. This is the equivalent of using the -o option from the command line.

#### SOURCE
This is the name of the source file that you want to use to build the object.

#### EXAMPLE
```ini
[build]
; create a program called main.o using main.a as
; its source file
;
; this is the same as running
;
; > tmpx main.a -o main.o
;
main.o=main.a
; create a program called loader.o using loader.asm
; as its source file
;
; this is the same as running
;
; > tmpx loader.a -o loader.asm
;
loader.o=loader.asm
```

### The `Files` Section
This section is used to define which files will be bundled for your application. 

You can have any number of files in your bundle, the only requirement, is that you cannot have the same filename listed twice.

The format of each file is as follows:

`filename=type,[from],[to]`

#### FILENAME
This required setting, is the file that you would like to have in your distribution. It might be the actual name of a file that is in your project folder, or it can also be used as the final name of your file as it will look on the distibution after it is bundled.

#### TYPE
The second required setting is the file type. Currently three types are supported

- SEQ (S) = seqential files
- PRG (P) = program files

This setting is especially important for sequential file types because the tool will try to convert the file to PETSCII before adding it to the bundle.

Other types might be supported in the future.

#### FROM
This is an optional setting that tells the bundler which file to use for distribution.

#### TO
This is an optional setting that tells the bundler what the final name of the file should be when creating the distribution.

#### EXAMPLE
```ini
[files]
; bundle a file called about.t that is a sequential file
; using the file about.txt as its source
about.t=seq,about.txt
; bundle a file called main.o from the file main.o 
; which is a program file
main.o=from=main.o,type=prg
; bundle a file called menu.m that is a sequential file
; using the file menu.txt as its source
menu.m=seq,menu.txt
; bundle a file called msg.t that is a sequential file
; using the file msg.txt as its source
msg=seq,msg.txt,msg.t
```

## How To Run This Tool
Once you have made copies of your bundleapp.ini and bundle.ini files, and have made appropriate changes, you are ready to run the tool.

### The Easy Way
If you are not too familiar with Python or changing the Python path, the easiest thing to do is simply copy the `bundleapp.py` program to your project folder, and then run the following from the command line.

```
> python bundleapp.py
```

### The Pythonic Way
The better, more pythonic way is to change your python path and invoke the program like a module.

#### Windows
```
> set PYTHON_PATH=c:\path\to\bundleapp\folder
```

#### Unix
```
export PYTHON_PATH=/path/to/bundleapp/folder
```

Then you can simply run the tool by issuing this command.

```
> python -m bundleapp
```
