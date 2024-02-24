;---------------------------------------
;PSID format:
;
; .text "PSID"{SHIFT--}"RSID"
; .word $01{SHIFT--}$02{SHIFT--}$03{SHIFT--}$04 version number
; .word $76{SHIFT--}$7c{SHIFT--}$7c{SHIFT--}$7c sid data offset
; .word $00 load addr. $00 = data head
; .word $00 init addr.
; .word $00 play addr.
; .word $00 number of songs.
; .word $00 start song #.
; .byte 0,0,0,0 32b BE. Speed of each
;               song. 0=vblank 1=60Hzcia
; .text 32-bytes Tune Name
; .text 32-bytes Author
; .text 32-bytes Copyright
;
; Data Starts Here if Version $01/$76
;
; .word $00 flags
; .byte $00 startPage (relocStartPage)
; .byte $00 pageLength (relocPages)
; .byte $00 2nd SID Addr.
; .byte $00 3rd SID Addr.
;
; Data Starts Here if Version $02-$04