;----[ ctxdraw.t ]----------------------

tkcolors = $0387     ;See ctxcolors.t

;Draw Context Flags
d_crsr_h = %00000001 ;Crsr travels left
d_petscr = %01000000 ;Convert Pet 2 Scr
d_revers = %10000000 ;Reverse the char

;ZeroPage Draw Context
d_dcrsr  = $39 ;$3a Draw Cursor
d_ccrsr  = $3b ;$3c Color Cursor
d_outbnd = $3d ;$3e Outbound Countdown

;Struct: Draw Context
d_ctx    = $039c

d_origin = 0          ;Character Origin
d_coloro = d_origin+2 ;Color Origin
d_bwidth = d_coloro+2 ;Buffer Width

d_width  = d_bwidth+1 ;0 to 40 columns
d_height = d_width+1  ;0 to 25 rows
d_otop   = d_height+1 ;offset top
d_oleft  = d_otop+2   ;offset left

;Size of Draw Context to push to stack
d_size   = d_oleft+2

;Volatile Draw Context, set each draw
d_lrow   = d_oleft+2  ;Local Row Coord
d_lcol   = d_lrow+2   ;Local Col Coord
d_ibh    = d_lcol+2   ;InBounds Horz.
d_ibv    = d_ibh+1    ;InBounds Vert.

d_color  = d_ibv+1      ;Draw Color
d_pet2scr = d_color+1   ;Conversion Flag
d_reverse = d_pet2scr+1 ;Reverse Flag
d_crsrmov = d_reverse+1 ;Cursor Mover

d_redraw = d_crsrmov+1  ;Redraw flags

