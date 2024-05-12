
;
; tkbutton1
; 
; a simple program for c64os that
; creates a VIEW and then attaches
; three BUTTON widgets to it
;
; there is no button handling
; code in this program

;
; c64os programmers guide
;
; http://tinyurl.com/268ve99v
;

;------------------------------

;
; use for cross development
;

    .include "os/h/modules.h"

;
; use for native development
;

    ;.include "//os/h/:modules.h"


;------------------------------

         #inc_s "app"
         #inc_s "ctxcolors"
         #inc_s "ctxdraw"
         #inc_s "io"
         #inc_s "pointer"
         #inc_s "switch"

         #inc_s "memory"
         #inc_s "screen"
         #inc_s "service"
         #inc_s "string"
         #inc_s "toolkit"

         #inc_tkh "classes"
         #inc_tks "tksizes"

         #inc_tks "tkview"
         #inc_tks "tkctrl"

         #inc_tkh "tkobj"
         #inc_tkh "tkview"
         #inc_tkh "tkbutton"
         #inc_tkh "tkctrl"
         #inc_tkh "tktext"

         *= appbase

         .word j_init
         .word j_msg
         .word j_quit
         .word raw_rts
         .word raw_rts
views
         .word 0 ;root

widgets
         .word 0,0,0

layer
         .word j_draw
         .word j_mouse
         .word sec_rts
         .word sec_rts
         .byte 0

drawctx
         .word scrbuf
         .word colbuf
         .byte screen_cols
         .byte screen_cols
         .byte screen_rows
         .word 0
         .word 0

tkenv
         .word drawctx ;draw contex
         .byte 0       ;memory pool
         .byte 1       ;dirty
         .byte 0       ;scrlayer 0
         .word 0       ;root view
         .word 0       ;1st key view
         .word 0       ;1st mus view
         .word 0       ;clikmus view
         .byte 0       ;ctx2scr ppsx
         .byte 0       ;ctx2scr posy

ui_s
         #strxyget 

         .null "Test1"
         .null "Test2"
         .null "Test3"

;------------------------------

j_init
         .block

ptr      = $fb;$fc

         #ldxy extern
         jsr initextern

         lda #mapapp
         ldx #4
         jsr pgalloc
         sty drawctx+d_coloro+1

         lda #mapapp
         ldx #4
         jsr pgalloc
         sty drawctx+d_origin+1

; allocating 1 page of memory for
; the toolkit
; 
; each widget needs a certain amount
; of memory
;
; TKVIEW      39
; TKBUTTON    62
; TKBUTTON    62
; TKBUTTON    62
;
;            225
;
; OBJS 4*3    12
;
; TOTAL      237
;
; 237 < 256 = 1 page

         lda #mapapp
         ldx #1
         jsr pgalloc
         sty tkenv+te_mpool

; creating view

         #ldxy tkenv
         jsr settkenv

         ldx #tkview
         jsr classptr
         jsr tknew

         #stxy tkenv+te_rview

         ldy #init_
         jsr getmethod
         jsr sysjmp

         #setflag this,dflags,df_opaqu

; create the button 1

         ldx #tkbutton
         jsr classptr
         jsr tknew

         #storeset widgets,0

         ldy #init_
         jsr getmethod
         jsr sysjmp

         ldy #settitle_
         jsr getmethod
         lda #0
         jsr ui_s
         jsr sysjmp

         #setobj8 this,offtop,2
         #setobj8 this,offleft,2
         #setobj8 this,width,8

         #rdxy tkenv+te_rview
         jsr appendto

; create the button 2

         ldx #tkbutton
         jsr classptr
         jsr tknew

         #storeset widgets,1

         ldy #init_
         jsr getmethod
         jsr sysjmp

         ldy #settitle_
         jsr getmethod
         lda #1
         jsr ui_s
         jsr sysjmp

         #setobj8 this,offtop,4
         #setobj8 this,offleft,2
         #setobj8 this,width,8

         #rdxy tkenv+te_rview
         jsr appendto

; create the button 3

         ldx #tkbutton
         jsr classptr
         jsr tknew

         #storeset widgets,2

         ldy #init_
         jsr getmethod
         jsr sysjmp

         ldy #settitle_
         jsr getmethod
         lda #2
         jsr ui_s
         jsr sysjmp

         #setobj8 this,offtop,6
         #setobj8 this,offleft,2
         #setobj8 this,width,8

         #rdxy tkenv+te_rview
         jsr appendto


; push main screen layer

         ldx #<layer
         ldy #>layer
         jsr layerpush

         ldx layer+slindx
         jmp markredraw

         rts

         .bend


;------------------------------

j_draw
         .block

         #ldxy tkenv
         jsr tkupdate

         ldy tkenv+te_posy
         ldx tkenv+te_posx
         jmp ctx2scr

         .bend


;------------------------------

j_mouse
         .block

         #ldxy tkenv
         jsr tkmouse

; check and see if we need to
; make the draw layer dirty

chkdirt
         lda tkenv+tf_dirty
         bne mkdirt+5
         sec
         rts

mkdirt
         lda #1
         sta tkenv+tf_dirty
         ldx layer+slindx
         jsr markredraw
         clc
         rts

         .bend

;------------------------------

j_msg
         .block

         #switch 2
         .byte mc_menq
         .byte mc_mnu
         .rta mnuenq
         .rta mnucmd

         sec
         rts

mnuenq
         lda #0
         rts

mnucmd
         txa
         #switch 1
         .text "!"
         .rta quitapp

         sec
         rts

         .bend

;------------------------------

j_quit
         .block

         rts

         .bend


extern

;------------------------------

         #inc_h "memory"
pgalloc
         #syscall lmem,pgalloc_


;------------------------------

         #inc_h "input"
initmouse
         #syscall linp,initmouse_
killmouse
         #syscall linp,killmouse_
hidemouse
         #syscall linp,hidemouse_


;------------------------------

         #inc_h "screen"
layerpush
         #syscall lscr,layerpush_
markredraw
         #syscall lscr,markredraw_
ctx2scr
         #syscall lscr,ctx2scr_


         #inc_h "service"
quitapp
         #syscall lser,quitapp_


;------------------------------

         #inc_h "toolkit"
classptr
         #syscall ltkt,classptr_
tknew
         #syscall ltkt,tknew_
appendto
         #syscall ltkt,appendto_
settkenv
         #syscall ltkt,settkenv_
getmethod
         #syscall ltkt,getmethod_
tkupdate
         #syscall ltkt,tkupdate_
tkmouse
         #syscall ltkt,tkmouse_

         .byte $ff
