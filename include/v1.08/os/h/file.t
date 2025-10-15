;----[ file.t ]-------------------------

lfil     = $0100-(2*8)       ;8th Module

finit_   = $00
;  RegPtr -> FileRef
;  A <- Error Code
;  C <- Set on Error
;  X <- Current Dev's CmdChan LFN
;  currentdv <- set FileRef's dev

ferror_  = $03
;  currentdv -> Device Number
;  A <- value of l_code

;---------------------------------------

fopen_   = $06
;  RegPtr -> FileRef
;  A      -> Flags

;  RegPtr <- FileRef
;  C <- Set on error
;  A <- Error code

fread_   = $09
;  RegPtr -> FileRef
;  a1 -> .W Ptr to buffer
;  a2 -> .W Len to read
;  RegPtr <- FileRef

fwrite_  = $0c
;  RegPtr -> FileRef
;  a1 -> .W Ptr to buffer
;  a2 -> .W Len to write
;  RegPtr <- FileRef

fclose_  = $0f
;  RegPtr -> FileRef

;---------------------------------------

frefcvt_ = $12
;  C Set  -> Serialize
;  RegPtr -> fref struct
;  RegPtr <- fref string
;
;  C Clr  -> Unserialize
;  RegPtr -> fref string
;  RegPtr <- fref struct

;---------------------------------------

clipin_  = $15
;  RegPtr -> Buffer to read CB into
;  A -> Length to read. 0=No Limit

clipout_ = $18
;  RegPtr -> String to put on CB
;  A -> Length to write. 0=Entire String
;  Writes datatype text/plain.

copen_   = $1b
;  A -> Clipboard "file" Flags
;  RegWrd <- Size of clipboard data

cread_   = $1e
;  Requires copen with FF_R flag.
;  RegPtr -> Buffer to read CB into
;  A -> Length to read. 0=No Limit
;  Can raise an exception

cwrite_  = $21
;  Requires copen with FF_W flag.
;  RegPtr -> String to put on CB
;  A -> Length to write. 0=Entire String

cclose_  = $24
;  If copen with ff_w:
;  X -> Data Type
;  Y -> Data Subtype
;
;  If copen with ff_r:
;  Takes no parameters.