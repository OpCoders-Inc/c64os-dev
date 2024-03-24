;----[ rtc.t for rtc.* drivers ]--------

;init_ = 0
;  Initialize the RTC driver

gettime_ = 3
;  Reads time from RTC driver and sets
;  memory and CIA(1) TOD registers.

settime_ = 6
;  RegPtr -> YMDHM formatted date/time
;  Writes date/time in the formatted
;  input out the the RTC device.