;----[ checksum.t for checksum.lib.r ]--

;link    = 0

;If maketab is called in this library,
;then it must be unlinked when unloaded.
;Otherwise, it leaks the table memory.

;unlink  = 3


;Maketab must be called to create the
;lookup tables before initcrc is called.

;Eg, before calling updc16, you must
;    call maketab with A->16 first.

maketab_ = 6  ;Make CRC Tables
;  A -> 1,2,4   = 8,16,32
;  A -> 8,16,32 = 8,16,32
;  C <- Set on Error

;Call initcrc to initialize the crc to
;valid initial state before calling the
;updcX routines on the data.

;Eg, to reset a CRC and prepare to
;    compute a new CRC call initcrc.

initcrc_ = 9  ;Initialize CRC workspace
;  A -> 1,2,4   = 8,16,32
;  A -> 8,16,32 = 8,16,32
;  C <- Set on Error


;Call initcrc A->1{SHIFT--}8 once before
;calling updc8 repeatedly on the data.

updc8_   = 12 ;Update CRC8
;  A   -> next byte to checksum
;  crc <- 8-bit CRC

;Call initcrc A->2{SHIFT--}16 once before
;calling updc16 repeatedly on the data.

updc16_  = 15 ;Update CRC16
;  A   -> next byte to checksum
;  crc <- 16-bit CRC

;Call initcrc A->4{SHIFT--}32 once before
;calling updc32 repeatedly on the data.

updc32_  = 18 ;Update CRC32
;  A   -> next byte to checksum
;  crc <- 32-bit CRC (xor'd $ff)


;After calling updcX on all data, call
;getcrc one to fetch a poiner to the
;data as an int or a string conversion.

;This also performs some required post
;processing on the crc data.

;NOTE: May only be called once if
;      CRC32, because of final EOR's.

getcrc_  = 21 ;Get CRC Value
;  A -> 1,2,4   = 8,16,32
;  A -> 8,16,32 = 8,16,32
;  C -> Set = Convert to string
;  C -> Clr = Get data as int

;  C      <- Clr on success
;  RegPtr <- Pointer to int or string.

;  C      <- Set on Error