;----[ pet.s ]--------------------------

;PETSCII Image File Format (*.pet)
;C64 OS screen grabs are in this format.


;File Header

pi_magic = 0  ; 3 bytes (PET)
pi_ver   = 3  ; 1 byte  ("0","1","2"...)
pi_title = 4  ;17 bytes (16chars+NULL)
pi_auth  = 21 ;17 bytes (16chars+NULL)
pi_copyr = 38 ;17 bytes (16chars+NULL)
;----------------------
; Header Size  55 bytes

;Image Data (version 0+)

pi_scrmem = 55   ;1000 bytes
pi_colmem = 1055 ;1000 bytes
pi_brdcol = 2055 ;   1 byte
pi_bakcol = 2056 ;   1 byte
;---------------------------
; Image Data Size 2002 bytes

;Character Data (version 2+)

pi_chrset = 2057 ;2048 bytes (2K bitmap)

;Version 0 implies Uppercase/Graphics
;Version 1 implies Lowercase/Uppercase
;Version 2 includes custom charset