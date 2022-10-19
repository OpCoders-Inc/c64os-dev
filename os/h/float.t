;----[ float.t ]----------------------

;*************************************
;* ==-- FLOATING POINT ROUTINES --== *
;*************************************

;Text Conversion Routines

strfac   = $bcf3
;txtptr -> pointer to string
;fac <- floating point number

facstr   = $bddd
;fac -> floating point number
;A/Y <- pointer to string conversion

chrget   = $73
chrgot   = $79

;Int to Float Conversions

int8fac  = $bc3c
;A -> Signed 8bit Int
;fac <- floating point number

uint8fac = $b3a2
;Y -> Unsigned 8bit Int
;fac <- floating point number

int16fac = $b395
;A -> Signed 16bit Int lo byte
;Y -> Signed 16bit Int hi byte
;fac <- floating point number


;Float to Int Conversions

facint32 = $bc9b
;fac -> floating point number
;$62 <- Signed 32bit Int


;Memory Move Functions

facmem   = $bbd4
;fac -> float
;RegPtr -> Pointer to where to copy FAC

memfac   = $bba2
;A/Y -> float
;fac <- float

memarg   = $ba8c
;A/Y -> float
;arg <- float

facarg   = $bc0c
;fac -> float
;arg <- float

argfac   = $bbfc
;arg -> float
;fac <- float


;Floating Point Functions: FAC = F(FAC)

fp_rnd   = $e097

fp_abs   = $bc58
fp_sgn   = $bc39
fp_exp   = $bfed
fp_int   = $bccc

fp_log   = $b9ea
fp_sqr   = $bf71

fp_sin   = $e26b
fp_cos   = $e264
fp_tan   = $e2b4
fp_atn   = $e30e


;Arithmetic Operations

memplus  = $b867
;fac -> float
;A/Y -> float
;fac <- fac+mem

plus     = $b86a
;fac -> float
;arg -> float
;A   -> fac exp
;fac <- fac+arg


memminus = $b850
;fac -> float
;A/Y -> float
;fac <- mem-fac

minus    = $b853
;fac -> float
;arg -> float
;A   -> fac exp
;fac <- arg-fac


memmult  = $ba28
;fac -> float
;A/Y -> float
;fac <- fac*mem

mult     = $ba2b
;fac -> float
;arg -> float
;A   -> fac exp
;fac <- fac*arg


memdivi  = $bb0f
;fac -> float
;A/Y -> float
;fac <- mem/fac

divi     = $bb12
;fac -> float
;arg -> float
;A   -> fac exp
;fac <- arg/fac


mempow   = $bf78
;arg -> float
;A/Y -> float
;fac <- arg^mem

power    = $bf7b
;fac -> float
;arg -> float
;A   -> fac exp
;fac <- arg^fac


mult10   = $bae2
;fac -> float
;fac <- fac*10

divi10   = $bafe
;fac -> float
;fac <- fac/10


;Logical Operations: On int16 conversion

fp_or    = $afe6
;fac -> float
;arg -> float
;fac <- float(int16(arg){SHIFT--}int16(fac))

fp_and   = $afe9
;fac -> float
;arg -> float
;fac <- float(int16(arg)&int16(fac))

fp_not   = $aed4
;fac -> float
;fac <- float(!int16(fac))


;Other Operations

fp_cmp   = $bc5b
;fac -> float
;A/Y -> float
;A   <- mem > fac

fp_round = $bc1b
;fac -> float
;fac <- round(fac)

fp_chgsgn = $bfb4
;fac -> float
;fac <- fac*-1

