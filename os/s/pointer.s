;----[ pointer.s ]----------------------

rdxy     .macro ;Reads Ptr into X/Y
         ldx \1
         ldy \1+1
         .endm

ldxy     .macro ;Loads X/Y with address
         ldx #<\1
         ldy #>\1
         .endm

stxy     .macro
         stx \1
         sty \1+1
         .endm

;---------------------------------------
;Get and Set RegPtr from Store

storeset .macro ;store,index
         stx \1+(\2*2)
         sty \1+(\2*2)+1
         .endm

storeget .macro ;store,index
         ldx \1+(\2*2)
         ldy \1+(\2*2)+1
         .endm

;---------------------------------------
;Toolkit Helpers

classmethod .macro ;method_offset
         jsr setclass_+stkt
         ldy #\1
         jsr getmethod_+stkt
         .endm

supermethod .macro ;method_offset
         jsr setsuper_+stkt
         ldy #\1
         jsr getmethod_+stkt
         .endm

;---------------------------------------
;Flag Manipulation

setflag  .macro ;ptr,index,flags
         ldy #\2
         lda (\1),y
         ora #\3
         sta (\1),y
         .endm

clrflag  .macro ;ptr,index,flags
         ldy #\2
         lda (\1),y
         and #\3:$ff
         sta (\1),y
         .endm

togflag  .macro ;ptr,index,flags
         ldy #\2
         lda (\1),y
         eor #\3
         sta (\1),y
         .endm

;---------------------------------------
;Setters and Getters

setobj8  .macro ;ptr,offset,int8
         ldy #\2
         lda #\3
         sta (\1),y
         .endm

setobj16 .macro ;ptr,offset,int16
         ldy #\2
         lda #<\3
         sta (\1),y
         iny
         lda #>\3
         sta (\1),y
         .endm

setobjptr .macro ;ptr,offset,ptr
         ldy #\2
         lda \3
         sta (\1),y
         iny
         lda \3+1
         sta (\1),y
         .endm

setobjxy .macro ;ptr,offset,(RegWrd)
         tya
         ldy #\2+1
         sta (\1),y
         dey
         txa
         sta (\1),y
         .endm

rdobj16  .macro ;ptr,offset
         ;RegPtr <- property
         ldy #\2
         lda (\1),y
         tax
         iny
         lda (\1),y
         tay
         .endm

getobj16 .macro ;ptr,offset,to
         ;A <- property hi byte
         ldy #\2+1  ;offset hi byte
         lda (\1),y
         pha
         dey        ;offset lo byte
         lda (\1),y
         sta \3     ;Save lo byte
         pla
         sta \3+1   ;Save hi byte
         .endm

;---------------------------------------

pushxy   .macro
         tya ;Hi
         pha
         txa ;Lo
         pha
         .endm

pullxy   .macro
         pla
         tax ;Lo
         pla
         tay ;Hi
         .endm

push16   .macro ;word to put on stack
         lda #>\1 ;Hi
         pha
         lda #<\1 ;Lo
         pha
         .endm

pushptr  .macro ;ptr to put on stack
         lda \1+1 ;Hi
         pha
         lda \1   ;Lo
         pha
         .endm

pull16   .macro ;ptr to pull from stack
         pla
         sta \1   ;Lo
         pla
         sta \1+1 ;Hi
         .endm

;---------------------------------------

copy16   .macro ;word,dest
         lda #<\1
         sta \2   ;1st: lo byte
         lda #>\1
         sta \2+1 ;2nd: hi byte
         .endm

copyptr  .macro ;ptr,dest
         lda \1
         sta \2   ;1st: lo byte
         lda \1+1
         sta \2+1 ;2nd: hi byte
         .endm

