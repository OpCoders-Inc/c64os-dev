;----[ string.t ]-----------------------

lstr     = $0100-(2*3)       ;3rd Module

strlen_  = 0
;  RegPtr -> Pointer to c-string
;  RegWrd <- String Length

strcpy_  = 3
;  X -> ZP Address to source c-string
;  Y -> ZP Address to destin c-string
;  A -> ZP to 16-bit length to copy

;---------------------------------------

asc2pet_ = 6
;  A -> ASCII character
;  A <- PETSCII character

pet2asc_ = 9
;  A -> PETSCII character
;  A <- ASCII character

pet2scr_ = 12
;  A -> PETSCII character
;  A <- Screen Code

;---------------------------------------

tolower_ = 15
;  A -> Mixedcase character
;  A <- Lowercase character

toupper_ = 18
;  A -> Mixedcase character
;  A <- Uppercase character

isdigit_ = 21
;  A -> PETSCII character
;  C <- Set is a digit
;  C <- Clr is non digit

;---------------------------------------

strdel_  = 24
;  strptr -> Pointer to c-string
;  Y -> start index
;  A -> depth

strins_  = 27
;  strptr -> Pointer to c-string
;  Y -> start index
;  A -> depth

