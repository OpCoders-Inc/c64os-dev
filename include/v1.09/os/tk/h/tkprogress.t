;----[ tkprogress.t ]-------------------

setmax_  = tcviewsz

;  RegWrd -> max size
;  RegWrd -> 0 = reset and cancel timer

inccur_  = tcviewsz+3

togtim_  = tcviewsz+6

;  C -> CLR = Unpause/resume timer
;  C -> SET = Pause timer

tcprgsz  = tcviewsz+9