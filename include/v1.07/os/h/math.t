;----[ math.t ]-------------------------

lmat     = $0100-(2*4)       ;4th Module

mul16_   = $00
;  multplr -> Multiplier   .word
;  multcnd -> Multiplicand .word
;  product <- Product      .word

div16_   = $03
;  C       -> Round on set
;  divisor -> Divisor   .word
;  dividnd -> Dividnd   .word
;  divrslt <- Quotient  .word
;  remandr <- Remainder .word

;---------------------------------------

tostr_   = $06
;  divisor -> base   (max 10)
;  dividnd -> Int value
;  RegPtr  <- string

toint_   = $09
;  multcnd -> base   (max 10)
;  RegPtr  -> string
;  A       -> strlen (optional)
;  multplr <- Int value

tohex_   = $0c
;  A -> int 0 to 255
;  X <- Lower Nybble, PETSCII
;  Y <- Upper Nybble, PETSCII

;---------------------------------------

seebas_  = $0f
;Enables BASIC/IO/KERNAL.
;Preserves A/X/Y registers

div3216_ = $12
;  divisor  -> Divisor     .word
;  dividnd  -> Dividend  32.word
;  divrslt  <- Quotient    .word
;  remandr  <- Remainder   .word