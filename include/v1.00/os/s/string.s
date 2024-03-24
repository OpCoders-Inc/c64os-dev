;----[ string.s ]-----------------------

;Requires: pointer.s


;Used by strins/strdel

strptr   = $61 ;$62
stralt   = $63 ;$64

stradd   .macro ;ptr, string
         ;X -> string start index
         ;Y -> pointer start index
         lda \2,x
         sta (\1),y
         beq *+6
         iny
         inx
         bne *-9
         .endm

;Call these macros before a set
;of null terminated strings.

strxyget .macro         ;48-Byte Routine
         ;A      -> String Number
         ;RegPtr <- String Pointer

         #ldxy strings
         cmp #0
         bne *+3
         rts

         sta index
         #stxy search+1

next     cmp #0
         bne search

         dec index
         beq found

search   lda $ffff

         inc search+1
         bne next
         inc search+2
         bne next

found    #rdxy search+1
         rts

index    .byte 0

strings
         .endm

straxget .macro         ;52-Byte Routine
         ;A   -> String Number
         ;A/X <- String Pointer
         ;Preserves Y

         cmp #0
         bne *+7

         lda #<strings
         ldx #>strings
         rts

         ldx #<strings
         stx search+1
         ldx #>strings
         stx search+2

         sta index

next     cmp #0
         bne search

         dec index
         beq found

search   lda $ffff

         inc search+1
         bne next
         inc search+2
         bne next

found    lda search+1
         ldx search+2
         rts

index    .byte 0

strings
         .endm

