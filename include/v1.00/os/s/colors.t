;----[ colors.t ]-----------------------

cfgmask  = $0f ;AND -> disable hi nybble
cbgmask  = $f0 ;AND -> disable lo nybble

               ;Config / Mouse Codes
cblack   = $00 ; 1       @
cwhite   = $01 ; 2       a
cred     = $02 ; 3       b
ccyan    = $03 ; 4       c
cpurple  = $04 ; 5       d
cgreen   = $05 ; 6       e
cblue    = $06 ; 7       f
cyellow  = $07 ; 8       g
corange  = $08 ; q       h
cbrown   = $09 ; w       i
clred    = $0a ; e       j
cdgrey   = $0b ; r       k
cmgrey   = $0c ; t       l
clgreen  = $0d ; y       m
clblue   = $0e ; u       n
clgrey   = $0f ; i       o

;High Nybble, used for ON bits in hires

chblack  = $00
chwhite  = $10
chred    = $20
chcyan   = $30
chpurple = $40
chgreen  = $50
chblue   = $60
chyellow = $70
chorange = $80
chbrown  = $90
chlred   = $a0
chdgrey  = $b0
chmgrey  = $c0
chlgreen = $d0
chlblue  = $e0
chlgrey  = $f0

