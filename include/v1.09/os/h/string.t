;----[ string.t ]-----------------------

lstr     = $0100-(2*3)       ;3rd Module

strlen_  = $00
;  RegPtr -> Pointer to c-string
;  RegWrd <- String Length

memncpy_ = $03
;  X -> ZP Address to source memory
;  Y -> ZP Address to destin memory
;  A -> ZP to 16-bit length to copy

;---------------------------------------

asc2pet_ = $06
;  A -> ASCII character
;  A <- PETSCII character

pet2asc_ = $09
;  A -> PETSCII character
;  A <- ASCII character

pet2scr_ = $0c
;  A -> PETSCII character
;  A <- Screen Code

;---------------------------------------

tolower_ = $0f
;  A -> Mixedcase character
;  A <- Lowercase character

toupper_ = $12
;  A -> Mixedcase character
;  A <- Uppercase character

isdigit_ = $15
;  A -> PETSCII character
;  C <- Set is a digit
;  C <- Clr is non digit

;---------------------------------------

strdel_  = $18
;  strptr -> Pointer to c-string
;  Y -> start index
;  A -> depth

strins_  = $1b
;  strptr -> Pointer to c-string
;  Y -> start index
;  A -> depth