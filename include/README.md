# C64OS Include Files
** **Work In Progress** **
## What Are These Files For?
The files found here are used when you are developing for C64OS using a cross platform tool like [TMPx](https://turbo.style64.org/docs/tmpx-overview) from Style64. They provide the definitions of the C64OS Kernal, functions and macros that you can use as a developer.

Without these files, you would need to memorize a great deal of code and do a lot of extra work.

More information on how to use the Kernal calls can be [found here](https://c64os.com/c64os/programmersguide/usingkernal#modules)

## How Are They Organized?
The include files are organized by the released version of C64OS. Any release prior to v1.00 is not included.
## Which Set Of Include Files Should I Use?
It will depend on what version of C64OS you are building your application or utility for. As a general rule of thumb, you should match the version of the include files that matches your version of C64OS you are using or targetting. 

That said, unless you are using a specific feature of a version, you can sometimes use older versions with successful results.
## What Is In The DIFFS Folder?
This folder contains a report that was generated from WinMerge that compared the Include files from that version to its previous version.

This can help you identify new Kernal calls and features in C64OS that you might want to use in your applications.

## How Do I Use The Files?
When you are developing an application for C64OS you can simple copy the `os` folder to your work folder or create a symbolic link (or junction) in your source folder.

Here is a example for Windows that will create a juntion to the location of the `os` folder.

`> mklink /j c:\path\to\c64os-dev\include\v1.06\os\`

See the example programs for more information on how to use these include files, and of course be sure to consult the [C64OS Programmers Guide](https://c64os.com/c64os/programmersguide/) on how to use them.
## How Are They Different From the Files in C64OS?
These files have been converted from PETSCII to ASCII and the paths have been modified so that they can be used withe TMPx on your personal computer.
## Do I Need To Keep The Files In My Source Folder?
No. In fact, we recommend that you do not. Instead just create a symbolic link or Junction (on Windows) for the `os` folder. If you are using a version control system like GitHub, then be sure to include that folder in your `.gitignore` file.
## What Is That OS_RAW Folder For?
This is the original PETSCII include files that come from the `os` directory in C64OS. They are kept here for historical reference and also in case bugs are found in the conversion tool, which might require that we run the conversion again.

You will not (and should not) use any of the file in the `os_raw` folders.