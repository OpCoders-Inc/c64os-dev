;---[ rtc.t ]---------------------------

t_secs   = $dc09 ;cia1
t_mins   = $dc0a ;cia1
t_hour   = $dc0b ;cia1

d_dow    = $03b2
d_year   = $03b3
d_month  = $03b4
d_day    = $03b5

t_twelve = $03b6 ;$a0=24Hrs,$00=12Hrs
t_blinks = $03b7 ;$a0=blink,$ba=no blink

;rtc.iec.r supports:
; CMD HD
; CMD FD
; CMD RL
; IDE64
; SD2IEC

;rtc.uci.r supports:
; 1541 Ultimate II+
; Ultimate 64

;rtc.i2c.r supports:
; A DS3231 on I2C bus with i2c.lib

;TODO: driver for CMD SmartMouse

