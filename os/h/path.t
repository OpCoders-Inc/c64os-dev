;----[ path.t ]-------------------------

;link    = 0

setname  = 3
;  Set fileref's name from string
;  RegPtr -> Str Pointer
;  A      -> Fref Page #

pathadd  = 6
;  Append string+"/" to path
;  RegPtr -> Str Pointer
;  A      -> Fref Page #

pathup   = 9
;  Go up one directory level
;  A -> Fref Page #

partroot = 12
;  Go to root dir of partition
;  A -> Fref Page #

devroot  = 15
;  Go to root dir of device
;  A -> Fref Page #

gopath   = 18
;  Configure fref from place code
;  A -> Fref Page #
;  X -> Place Code

frclip   = 21
;  Fileref to/from clipboard
;  A -> Fref Page #
;  C -> CLR conf fref from CB
;  C -> SET copy fref to   CB

