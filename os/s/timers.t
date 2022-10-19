;----[ timers.t ]-----------------------

;Statically allocated timer struct.
utiltimr = $0221

;Set to zero to clear timer queue.
timeridx = $09

;Struct
ttime    = 0 ;3 bytes
tstat    = 3 ;1 byte
ttrig    = 4 ;2 bytes
tvalu    = 6 ;3 bytes
;Timer

tpause   = %10000000 ;Paused
tintrvl  = %01000000 ;Interval  (reload)
tcancel  = %00100000 ;Cancel   (dequeue)
treset   = %00010000 ;Reset (valu->time)
texprd   = %00001000 ;Expired  (trigger)
tprecis  = %00000100 ;Precise
trealtm  = %00000010 ;Realtime

;undef'd = %00000001 ;Was current lo bit

;If a timer evt is already queued when
;the timer elapses again, by default it
;will not double queue the same trigger.
;Use tprecis to override this behaviour.

;If timer is set as realtime, it will be
;triggered immediately, from the KERNAL
;IRQ handler that calls timedwn. Use
;with extreme care. Can be used, for
;example, to play a SID, or update the
;screen before the next draw cycle.

