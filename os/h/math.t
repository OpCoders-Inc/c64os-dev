;----[ math.t ]-------------------------

lmat     = $0100-(2*4)       ;4th Module

mul16_   = 0
;  multplr -> Multiplier   .word
;  multcnd -> Multiplicand .word
;  product <- Product      .word

div16_   = 3
;  C       -> Round on set
;  divisor -> Divisor   .word
;  dividnd -> Dividnd   .word
;  divrslt <- Quotient  .word
;  remandr <- Remainder .word

;---------------------------------------

tostr_   = 6
;  divisor -> base   (max 10)
;  dividnd -> Int value
;  RegPtr  <- string

toint_   = 9
;  multcnd -> base   (max 10)
;  RegPtr  -> string
;  A       -> strlen (optional)
;  multplr <- Int value

tohex_   = 12
;  A -> int 0 to 255
;  X <- Lower Nybble, PETSCII
;  Y <- Upper Nybble, PETSCII

;---------------------------------------

seebas_  = 15
;Enables BASIC/IO/KERNAL.
;Preserves A/X/Y registers

