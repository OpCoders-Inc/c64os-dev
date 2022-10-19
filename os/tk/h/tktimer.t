;----[ tktimer.t ]----------------------

;init_ override
; A -> font page, or 0 to allocate/load
; A <- font page.

tiset_   = tcviewsz
; A -> seconds
; X -> minutes
; Y -> hours
;clears ti_cnting
;raises exception if > 23:59:59

titoggle_ = tcviewsz+3
; Toggles ti_cnting
; C <- Set = started, Clr = stopped

titick_  = tcviewsz+6
; Called by ticker timer trigger routine





