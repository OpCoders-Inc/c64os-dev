;----[ file.s ]-------------------------

setlfs   = $ffba ;Compatible
setnam   = $ffbd ;Compatible
load     = $ffd5 ;Compatible

open     = $ffc0 ;Compatible
close    = $ffc3 ;Compatible
save     = $ffd8 ;Compatible

;--- File Constants ---

;LOAD Modes
loadop   = $00
verifyop = $01

;SETLFS before a LOAD
loadrel  = $00 ;Relocate, ignore header
loaddef  = $01 ;Load to header address

;SETLFS before an OPEN
cmdload  = $00
cmdsave  = $01
;I/O     = $02 through $0e
cmdchan  = $0f

