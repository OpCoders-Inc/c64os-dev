;----[ tktext.s ]-----------------------

;----String Flags-------

f_wrap   = %00000001
f_sel    = %00000010 ;Selectable
f_asc    = %01000000 ;Asc2Pet
f_rev    = %10000000 ;Reverse Draw

;----Text Props---------

tstrptr  = tkviewsz

tstrflgs = tkviewsz+2
tlinemap = tkviewsz+3
tmapsize = tkviewsz+4

tcwidth  = tkviewsz+5
tcheight = tkviewsz+7

tselstrt = tkviewsz+9
tselend  = tkviewsz+11


