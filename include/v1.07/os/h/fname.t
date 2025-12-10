;----[ fname.t for fname.lib ]----------

;link = $00

getext   = $03

;Get extension from filename
;  RegPtr -> filename string
;  C      <- CLR, extension found
;  RegPtr <- extension string
;  C      <- SET, no extension

;Ideas for future routines.

;setext  = $06
;normal  = $09