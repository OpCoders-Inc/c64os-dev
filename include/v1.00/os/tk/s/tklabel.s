;----[ tklabel.s ]----------------------

;----String Flags-------

a_lft    = %00000001 ;Align Left
a_rgt    = %00000010 ;Align Right

f_rev    = %10000000 ;Reverse Draw

;Text Align Bits

;Full    = 00 ;Not used by tklabel
;Left    = 01
;Right   = 10
;Center  = 11

;----Text Props---------

;strptr   = tkviewsz
strflgs  = tkviewsz+2
strlgth  = tkviewsz+3



