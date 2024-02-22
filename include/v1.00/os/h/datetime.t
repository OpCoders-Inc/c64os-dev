;----[ datetime.t for datetime.lib.a ]--

;link = 0

toisodt_ = 3

;Int to ISO Date
;  Y -> Year  ($00=1900,$FF=2155)
;  X -> Month (1=Jan,12=Dec)
;  A -> Date  (1 to 31)
;  RegPtr <- ptr to "YYYY-MM-DD"
;  No Date Validity Checking!

frisodt_ = 6

;From ISO Date to Int
;  RegPtr -> ptr to "YYYY-MM-DD"
;  Y <- Year  ($00=1900,$FF=2155)
;  X <- Month (1=Jan,12=Dec)
;  A <- Date  (1 to 31)
;  No Date Validity Checking!

toisotm_ = 9

;Int to ISO Time
;  Y -> Hour (00 to 23)
;  X -> Min  (00 to 59)
;  RegPtr <- ptr to "HH:MM:SS"
;  No Date Validity Checking!

frisotm_ = 12

;From ISO Time to Int
;  RegPtr -> ptr to "HH:MM:SS"
;  Y <- Hour (00 to 23)
;  X <- Min  (00 to 59)
;  No Date Validity Checking!

gettime_ = 15

;Get current time in Int format
;  Y <- Current Hour (00 to 23)
;  X <- Current Min  (00 to 59)

bcd2int_ = 18

;Convert 8-bit BCD to INT
;  A -> BCD ($00 to $99)
;  A <- INT ($00 to $63)

