
;
; helloworld
; 
; a very simple program that 
; prints a message and 
; consumes a menu event to
; close the application
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
    #inc_s "colors"
    #inc_s "ctxdraw"
    #inc_s "io"
    #inc_s "pointer"
    #inc_s "switch"

    #inc_s "screen"
    #inc_s "service"

;------------------------------

    *= appbase

    .word j_init
    .word j_msg
    .word j_quit
    .word raw_rts
    .word raw_rts

;------------------------------

j_init

    .block

    #ldxy externs
    jsr initextern

    #ldxy layer
    jsr layerpush

    rts

    .bend

;------------------------------

j_draw

    .block

; configure the drawing context
; for this app 

    #ldxy drawctx
    jsr setctx

; set the drawing attributes

    ldx #d_crsr_h.d_petscr
    ldy strcolor
    jsr setdprops

    lda #" "
    jsr ctxclear

; set the next draw position
; to row 5 column 5

    #ldxy 5
    clc
    jsr setlrc

    #ldxy 5
    sec
    jsr setlrc

; small loop to print the
; null terminated text from
; memory using ctxdraw 

; http://tinyurl.com/7kuk5esr

    ldx #0

    next

    lda hello_s,x
    beq done
    jsr ctxdraw
    inx
    bne next

    done

    rts

    .bend

;------------------------------

j_msg

    .block

    #switch 2
    .byte mc_menq,mc_mnu
    .rta mnuenq,mnucmd

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

;------------------------------

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

;------------------------------

hello_s

    .null "Hello World"

strcolor

    .byte clblue

;------------------------------

externs

;------------------------------
    #inc_h "screen"
;------------------------------

layerpush
    #syscall lscr,layerpush_
setlrc
    #syscall lscr,setlrc_
setdprops
    #syscall lscr,setdprops_
ctxclear
    #syscall lscr,ctxclear_
ctxdraw
    #syscall lscr,ctxdraw_

;------------------------------
    #inc_h "service"
;------------------------------

quitapp
    #syscall lser,quitapp_

;------------------------------
    #inc_h "toolkit"
;------------------------------

setctx
    #syscall ltkt,setctx_

    .byte $ff
