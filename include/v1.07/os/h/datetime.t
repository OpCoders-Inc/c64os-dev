;----[ datetime.t for datetime.lib.a ]--

;link = $00

toisodt_ = $03

;Int to ISO Date
;  Y -> Year  ($00=1900,$FF=2155)
;  X -> Month (1=Jan,12=Dec)
;  A -> Date  (1 to 31)
;  RegPtr <- ptr to "YYYY-MM-DD"
;  No Date Validity Checking!

frisodt_ = $06

;From ISO Date to Int
;  RegPtr -> ptr to "YYYY-MM-DD"
;  Y <- Year  ($00=1900,$FF=2155)
;  X <- Month (1=Jan,12=Dec)
;  A <- Date  (1 to 31)
;  No Date Validity Checking!

toisotm_ = $09

;Int to ISO Time
;  Y -> Hour (0 to 23) decimal
;  X -> Min  (0 to 59) decimal
;  RegPtr <- ptr to "HH:MM:SS"
;  No Date Validity Checking!

frisotm_ = $0c

;From ISO Time to Int
;  RegPtr -> ptr to "HH:MM:SS"
;  Y <- Hour (0 to 23) decimal
;  X <- Min  (0 to 59) decimal
;  No Date Validity Checking!

gettime_ = $0f

;Get current time in Int format
;  Y <- Current Hour (0 to 23) decimal
;  X <- Current Min  (0 to 59) decimal

bcd2int_ = $12

;Convert 8-bit BCD to INT
;  A -> BCD ($00 to $99)
;  A <- INT ($00 to $63)