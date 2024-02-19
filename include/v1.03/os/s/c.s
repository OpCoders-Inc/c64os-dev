;----[ c.s ]----------------------------

;This is an experimental idea,for macros
;to make it easier to pass args on the
;stack. And pop them after the call.

;C Function Calls
carg16   .macro
         lda #<\1         ;Lo byte 1st
         pha
         lda #>\1         ;Hi byte 2nd
         pha
         .endm
carg8    .macro
         lda #\1
         pha
         .endm

ccall    .macro ;routine,sizeof_args
         jsr \1

         ;pop arguments from the stack
         tsx
         txa
         clc
         adc #\2 ;sizeof args
         tax
         txs
         .endm

