;----[ tktarea.s ]----------------------

;See: tkinput.s for delegate struct
;     and first 5 properties that are
;     common to tkinput and tktarea.

ltbptr   = $65 ;$66 ;Line Table Pointer

;----Drawing Props------

;idelegs defined in tkinput.s

irowidx  = idelegs+2
icolidx  = idelegs+3
imcolidx = idelegs+4
ilntab   = idelegs+5