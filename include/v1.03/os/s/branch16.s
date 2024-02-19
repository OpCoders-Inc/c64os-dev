;----[ branch16.s ]---------------------

;16-bit Short Branches

b_ifnull .macro ;ptr,branchLabel
         lda \1
         ora \1+1
         beq \2
         .endm
b_ifset  .macro ;ptr,branchLabel
         lda \1
         ora \1+1
         bne \2
         .endm

;16-bit Long Branches

bl_ifnull .macro ;ptr,branchLabel
         lda \1
         ora \1+1
         bne *+3
         jmp \2
         .endm
bl_ifset .macro ;ptr,branchLabel
         lda \1
         ora \1+1
         beq *+3
         jmp \2
         .endm

;Long Branches

bcc_     .macro
         bcs *+5
         jmp \1
         .endm

bcs_     .macro
         bcc *+5
         jmp \1
         .endm

beq_     .macro
         bne *+5
         jmp \1
         .endm

bne_     .macro
         beq *+5
         jmp \1
         .endm

bmi_     .macro
         bpl *+5
         jmp \1
         .endm

bpl_     .macro
         bmi *+5
         jmp \1
         .endm

bvc_     .macro
         bvs *+5
         jmp \1
         .endm

bvs_     .macro
         bvc *+5
         jmp \1
         .endm

