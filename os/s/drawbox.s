;----[ drawbox.s ]----------------------

drawbox  .macro
xa       = 0
ya       = 1
xb       = 2
yb       = 3
fillchar = 4
fillcolr = 5

width    = xb ;Overwrites
hight    = yb ;Overwrites
;---------------------------------------

         lda par+xb
         cmp par+xa
         bcs skipswx

         ;Swap xa/xb
         ldy par+xa
         sta par+xa
         sty par+xb
skipswx
         ;Get width from deltaX
         sec
         lda par+xb
         sbc par+xa    ;OriginX
         sta par+width ;Width

         ;Inset draw cursor X
         clc
         lda d_ctx+d_origin
         adc par+xa
         sta d_dcrsr
         lda d_ctx+d_origin+1
         adc #0
         sta d_dcrsr+1

         ;Inset colr cursor X
         clc
         lda d_ctx+d_coloro
         adc par+xa
         sta d_ccrsr
         lda d_ctx+d_coloro+1
         adc #0
         sta d_ccrsr+1

;---------------------------------------

         lda par+yb
         cmp par+ya
         bcs skipswy

         ;Swap ya/yb
         ldy par+ya
         sta par+ya
         sty par+yb
skipswy
         ;Get height from deltaY
         sec
         lda par+yb
         sbc par+ya    ;OriginY
         sta par+hight ;Height

         ldy par+ya
         beq *+8
         jsr incrow
         dey
         bne *-4

         lda par+fillchar
         sta getchar+1
         lda par+fillcolr
         sta getcolr+1

         ldx par+hight

drawrow  ldy par+width
getchar  lda #$ff              ;Self-Mod
         sta (d_dcrsr),y
getcolr  lda #$ff              ;Self-Mod
         sta (d_ccrsr),y
         dey
         bpl getchar

         jsr incrow
         dex
         bpl drawrow

         jmp par+6

incrow   ;Increment Draw Row
         clc
         lda d_dcrsr
         adc d_ctx+d_bwidth
         sta d_dcrsr
         bcc *+4
         inc d_dcrsr+1

         ;Increment Colr Row
         clc
         lda d_ccrsr
         adc d_ctx+d_bwidth
         sta d_ccrsr
         bcc *+4
         inc d_ccrsr+1

         rts

par      ;Parameters (6 bytes)
         .endm


