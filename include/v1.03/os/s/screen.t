;----[ screen.t ]-----------------------

screen_cols = 40
screen_rows = 25

split    = $3f ;Current Screen Split Row
lastsplt = $40    ;Last Screen Split Row

colhbuf  = $0300;$0301 Hires Color Buf
colmbuf  = $0302;$0303 Multi Color Buf

;When moving the split, line at a time:

;load colhbuf pointer to RegPtr
;load line # into .A and call scrrow
;write RegPtr to $fd/$fe temp ZP ptr
;load screen memory ptr to RegPtr
;same line # still in .A call scrrow
;write RegPtr to $fb/$fc temp ZP ptr
;load #screen_cols into .Y
;copy row of color data ($fd),y->($fb),y
;if multicolor bitmap, repeat to move
;a row from colmbuf to color memory.

rvs_mask = %10000000

;Struct: Screen Layer
sldraw   = 0 ;Vec redraw screen
slmous   = 2 ;Vec handle mouse event
slkcmd   = 4 ;Vec handle key command
slkprt   = 6 ;Vec handle key print
slindx   = 8 ;This layer's pushed index

slsize   = 9 ;sizeof a screen layer

current  = $0381 ;Current Render Layer

