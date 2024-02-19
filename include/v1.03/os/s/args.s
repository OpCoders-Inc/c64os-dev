;----[ args.s ]-------------------------

argptr   = $45 ;$46

arg8     .macro ;index,addr
         ldy #\1+1
         lda (argptr),y
         sta \2
         .endm

arg16    .macro ;index,addr
         #arg8 \1,\2
         iny
         lda (argptr),y
         sta \2+1
         .endm








