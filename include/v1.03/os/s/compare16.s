;----[ compare16.s ]--------------------

;16-bit Comparisons
gtewrd   .macro ;num1,word,<label
         lda \1+1
         cmp #>\2
         bcc \3
         bne gte
         lda \1
         cmp #<\2
         bcc \3
gte
         .endm

gte16    .macro ;num1,num2,<label
         lda \1+1
         cmp \2+1
         bcc \3
         bne gte
         lda \1
         cmp \2
         bcc \3
gte
         .endm

eqwrd    .macro ;num1,word,!=label
         lda \1
         cmp #<\2
         bne \3
         lda \1+1
         cmp #>\2
         bne \3
         .endm

eq16     .macro ;num1,num2,!=label
         lda \1
         cmp \2
         bne \3
         lda \1+1
         cmp \2+1
         bne \3
         .endm

