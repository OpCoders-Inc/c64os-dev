;----[ math.s ]---------------------

;Division
;16bit/16bit = 16bit (+16bit r.)

divisor  = $61;$62 16bit
dividnd  = $63;$64 16bit
divrslt  = $63;$64 (same as dividnd)
remandr  = $65;$66
divrond  = $67

;Division
;32bit/16bit = 16bit (+16bit r.)

;divisor = $61;$62         16bit
;dividnd = $63;$64,$65,$66 32bit
;divrslt = $63;$64 (same as dividnd lo)
;remandr = $65;$66 (same as dividnd hi)
divtemp  = $67
divcarry = $68

;Multiply
;16bit*16bit = 32bit

multplr  = $61;$62
multcnd  = $63;$64
product  = $65;$66 $67 $68 ;32-bit

;16-bit inc/dec, addition and subtract

inc16    .macro        ;16-bit increment
         inc \1                ;Lo Byte
         bne done              ;Rollover
         inc \1+1              ;Hi Byte
done
         .endm

dec16    .macro        ;16-bit decrement
         lda \1            ;Test Lo Byte
         bne declo
         dec \1+1               ;Hi Byte
declo    dec \1                 ;Lo Byte
         .endm

add816   .macro ;ptr += int8
         clc
         lda \1
         adc #\2
         sta \1

         bcc done
         inc \1+1
done
         .endm

sub816   .macro ;ptr -= int8
         sec
         lda \1
         sbc #<\2
         sta \1

         bcs done
         dec \1+1
done
         .endm

add16    .macro ;ptr += int16
         clc
         lda \1
         adc #<\2
         sta \1

         lda \1+1
         adc #>\2
         sta \1+1
         .endm

sub16    .macro ;ptr -= int16
         sec
         lda \1
         sbc #<\2
         sta \1

         lda \1+1
         sbc #>\2
         sta \1+1
         .endm

add16ptr .macro ;ptr += ptr
         clc
         lda \1
         adc \2
         sta \1

         lda \1+1
         adc \2+1
         sta \1+1
         .endm

sub16ptr .macro ;ptr -= ptr
         sec
         lda \1
         sbc \2
         sta \1

         lda \1+1
         sbc \2+1
         sta \1+1
         .endm