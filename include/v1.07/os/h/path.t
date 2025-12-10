;----[ path.t ]-------------------------

;link    = $00

setname_ = $03
;  Set fileref's name from string
;  RegPtr -> Str Pointer
;  A      -> Fref Page #

pathadd_ = $06
;  Append string+"/" to path
;  RegPtr -> Str Pointer
;  A      -> Fref Page #

pathup_  = $09
;  Go up one directory level
;  A -> Fref Page #

partroot_ = $0c
;  Go to root dir of partition
;  A -> Fref Page #

devroot_ = $0f
;  Go to root dir of device
;  A -> Fref Page #

gopath_  = $12
;  Configure fref from place code
;  A -> Fref Page #
;  X -> Place Code

frclip_  = $15
;  Fileref to/from clipboard
;  A -> Fref Page #
;  C -> CLR conf fref from CB
;  C -> SET copy fref to   CB