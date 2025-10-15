;----[ io_u64t.t ]----------------------

;Constants for detecting and using an
;Ultimate64's turbo mode acceleration.

;Detection

u6t_dtct = $d031

;If $ff, turbo is disabled.

;Mask the upper 4 bits, compare to
;speed constants for the current speed.

u6t_1m   = 0
u6t_2m   = 1
u6t_3m   = 2
u6t_4m   = 3

u6t_5m   = 4
u6t_6m   = 5
u6t_8m   = 6
u6t_10m  = 7

u6t_12m  = 8
u6t_14m  = 9
u6t_16m  = 10
u6t_20m  = 11

u6t_24m  = 12
u6t_32m  = 13
u6t_40m  = 14
u6t_48m  = 15