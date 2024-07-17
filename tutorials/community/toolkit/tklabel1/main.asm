
;
; tklabel1
; 
; a simple example of how
; to add a tklabel object
; to your application
;
;
; c64os programmers guide
;
; http://tinyurl.com/268ve99v
;
; c64os writing an application tutorial
;
; https://www.c64os.com/c64os/programmersguide/writingapp_tutorial1
;
; tklabel api documentation
;
; http://tinyurl.com/268ve99v

;------------------------------

; use for cross development

    .include "os/h/modules.h"

; use for native development

    ;.include "//os/h/:modules.h"

;------------------------------

        #inc_s "app"
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
        #inc_tkh "tkctrl"
        #inc_tkh "tklabel"

        *= appbase

        .word j_init
        .word j_msg
        .word j_quit
        .word raw_rts
        .word raw_rts

views
        .word 0         ; root view

widgets
        .word 0         ; label

layer
        .word j_draw
        .word sec_rts
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
        .word drawctx   ;draw contex
        .byte 0         ;memory pool
        .byte 1         ;dirty
        .byte 0         ;scrlayer 0
        .word 0         ;root view
        .word 0         ;1st key view
        .word 0         ;1st mus view
        .word 0         ;clikmus view
        .byte 0         ;ctx2scr ppsx
        .byte 0         ;ctx2scr posy

ui_s
        #strxyget 
        .null "Hello TKLabel"

;------------------------------

j_init

        .block

ptr     = $fb;$fc

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

;
; allocating 1 page of memory for
; the toolkit
; 
; each widget needs a certain amount
; of memory
;
; TKVIEW      39
; TKLABEL     62
;
;            225
;
; OBJS 4*3    12
;
; TOTAL      237
;
; 237 < 256 = 1 page
;

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

; create label

        ldx #tklabel
        jsr classptr
        jsr tknew

        #storeset widgets,0

        ldy #init_
        jsr getmethod
        jsr sysjmp

        ldy #setstrp_
        jsr getmethod
        lda #0
        jsr ui_s
        jsr xytoax
        jsr sysjmp

        #setobj8 this,offtop,4
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

xytoax
        .block

        txa
        pha
        tya
        tax
        pla

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

         #inc_h "screen"
layerpush
         #syscall lscr,layerpush_
markredraw
         #syscall lscr,markredraw_
ctx2scr
         #syscall lscr,ctx2scr_


;------------------------------

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

         .byte $ff
