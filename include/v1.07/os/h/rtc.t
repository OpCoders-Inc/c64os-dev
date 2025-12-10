;----[ rtc.t for rtc.* drivers ]--------

;init_ = $00
;  Initialize the RTC driver

gettime_ = $03
;  Reads time from RTC driver and sets
;  memory and CIA(1) TOD registers.

settime_ = $06
;  RegPtr -> YMDHM formatted date/time
;  Writes date/time in the formatted
;  input out the the RTC device.