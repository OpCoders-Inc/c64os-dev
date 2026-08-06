;----[ calendar.t for calendar.lib.r ]--

;link = $00

datetos_ = $03

;Date to Screencodes
;  A -> Date (1 to 31)
;  Y <- Tens Digit (SCRCode)
;  X <- Ones Digit (SCRCode)
;  Raises out-of-range exception

firstdow_ = $06

;Day of Week of Date
;  Y -> Year  (1900=0)
;  X -> Month  (Jan=1)
;  A -> Date  (1 to 31)
;  A <- Day of Week (Sun=0)
;  Raises out-of-range exception

dayofyr_ = $09

;Compute Day of Year + 6
;  Y -> Year
;  X -> Month
;  A -> Date
;  dividnd <- DofY+6

weeknum_ = $0c

;Compute week number of mon/day
;  Y -> Year
;  X -> Month
;  A -> Date
;  RegWrd <- Week Number

daysinm_ = $0f

;Number of days in month
;  Y -> Year  (1900=0)
;  X -> Month  (Jan=1)
;  A <- Number of Days (28-31)

isleap_  = $12

;Checks if a year is a leap
;  Y -> Year (1900=0)
;  C <- Clr = Not a leap year
;  C <- Set = Is a leap year

mnthname_ = $15

;Get Month Name String
;  X -> jan=1 dec=12
;  RegPtr <- Month name string
;  A      <- string length
;  Raises out-of-range exception

dayname_ = $18

;Get Day Name String
;  X -> sun=0 sat=6
;  RegPtr <- Day name string
;  A      <- string length
;  Raises out-of-range exception