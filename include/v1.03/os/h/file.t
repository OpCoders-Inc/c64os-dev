;----[ file.t ]-------------------------

lfil     = $0100-(2*8)       ;8th Module

finit_   = 0
;  RegPtr -> FileRef
;  A <- Error Code
;  C <- Set on Error
;  X <- Current Dev's CmdChan LFN
;  currentdv <- set FileRef's dev

ferror_  = 3
;  currentdv -> Device Number
;  A <- value of l_code

;---------------------------------------

fopen_   = 6
;  RegPtr -> FileRef
;  A      -> Flags

;  RegPtr <- FileRef
;  C <- Set on error
;  A <- Error code

fread_   = 9
;  RegPtr -> FileRef
;  a1 -> .W Ptr to buffer
;  a2 -> .W Len to read
;  RegPtr <- FileRef

fwrite_  = 12
;  RegPtr -> FileRef
;  a1 -> .W Ptr to buffer
;  a2 -> .W Len to write
;  RegPtr <- FileRef

fclose_  = 15
;  RegPtr -> FileRef

;---------------------------------------

frefcvt_ = 18
;  C Set  -> Serialize
;  RegPtr -> fref struct
;  RegPtr <- fref string
;
;  C Clr  -> Unserialize
;  RegPtr -> fref string
;  RegPtr <- fref struct

;---------------------------------------

clipin_  = 21
;  RegPtr -> Buffer to read CB into
;  A -> Length to read. 0=No Limit

clipout_ = 24
;  RegPtr -> String to put on CB
;  A -> Length to write. 0=Entire String
;  Writes datatype text/plain.

copen_   = 27
;  A -> Clipboard "file" Flags
;  RegWrd <- Size of clipboard data

cread_   = 30
;  Requires copen with FF_R flag.
;  RegPtr -> Buffer to read CB into
;  A -> Length to read. 0=No Limit
;  Can raise an exception

cwrite_  = 33
;  Requires copen with FF_W flag.
;  RegPtr -> String to put on CB
;  A -> Length to write. 0=Entire String

cclose_  = 36
;  If copen with ff_w:
;  X -> Data Type
;  Y -> Data Subtype
;
;  If copen with ff_r:
;  Takes no parameters.

