
switch   .macro ;case count
         ;A -> switch code
         ;A is preserved if not found.
         stx tab-2           ;Stash .X
         ldx #\1

loop     dex
         bmi tab+(\1*3)
         cmp tab,x
         bne loop

         sta tab-4           ;Stash .A

         txa
         asl a
         tax

         lda tab+\1+1,x
         pha
         lda tab+\1,x
         pha
         lda #$ff            ;Restore .A
         ldx #$ff            ;Restore .X
         rts               ;Jump To .RTA
tab
         .endm

