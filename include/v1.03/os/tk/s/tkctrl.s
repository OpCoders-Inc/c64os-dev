;----[ tkctrl.s ]-----------------------

;----Control Flags------

cf_rvrs  = 1    ;Draw in Reverse Mode
cf_cont  = 2    ;Trigger continuously

cf_hilit = 16   ;Draw Highlighted
cf_deflt = 32   ;Default Control Status

cf_state = 64   ;Active/Inactive State
cf_disab = 128  ;Enable/Disable State

;----Value Types--------

vt_byt   = 1    ;1-byte Byte
vt_wrd   = 2    ;2-byte Word
vt_flt   = 4    ;5-byte Float
vt_str   = 8    ;2-byte String Pointer

;----Action Props-------

sender   = tkviewsz
act_meth = tkviewsz+2
act_tgt  = tkviewsz+3

;----Interaction Props--

cflags   = tkviewsz+5
rtvalu   = tkviewsz+6 ;Repeat timer valu

;----Value Props--------

valtype  = tkviewsz+9
value    = tkviewsz+10

