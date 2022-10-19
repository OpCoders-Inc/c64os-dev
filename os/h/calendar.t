;----[ calendar.t for calendar.lib.r ]--

;link = 0

datetos_ = 3

;Date to Screencodes
;  A -> Date (1 to 31)
;  Y <- Tens Digit (SCRCode)
;  X <- Ones Digit (SCRCode)
;  Raises out-of-range exception

firstdow_ = 6

;Day of Week of Date
;  Y -> Year  (1900=0)
;  X -> Month  (Jan=1)
;  A -> Date  (1 to 31)
;  A <- Day of Week (Sun=0)
;  Raises out-of-range exception

dayofyr_ = 9

;Compute Day of Year + 6
;  Y -> Year
;  X -> Month
;  A -> Date
;  dividnd <- DofY+6

weeknum_ = 12

;Compute week number of mon/day
;  Y -> Year
;  X -> Month
;  A -> Date
;  RegWrd <- Week Number

daysinm_ = 15

;Number of days in month
;  Y -> Year  (1900=0)
;  X -> Month  (Jan=1)
;  A <- Number of Days (28-31)

isleap_  = 18

;Checks if a year is a leap
;  Y -> Year (1900=0)
;  C <- Clr = Not a leap year
;  C <- Set = Is a leap year

mnthname_ = 21

;Get Month Name String
;  X -> jan=1 dec=12
;  RegPtr <- Month name string
;  A      <- string length
;  Raises out-of-range exception

dayname_ = 24

;Get Day Name String
;  X -> sun=0 sat=6
;  RegPtr <- Day name string
;  A      <- string length
;  Raises out-of-range exception

