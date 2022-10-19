;----[ tkscroll.t ]---------------------

setctnt_ = tcviewsz
;  RegPtr -> tkview, scroll content view

setbar_  = tcviewsz+3
;  X ->  0 = Disable Horz Sbar
;  X -> !0 = Enable  Horz Sbar
;  Y ->  0 = Disable Vert Sbar
;  Y -> !0 = Enable  Vert Sbar

;--- Scroll Methods ---

adjust_  = tcviewsz+6
;  RegPtr -> tksbar object

setoff_  = tcviewsz+9
;  RegWrd -> new scroll offset
;  C -> Set = Vertical, Clr = Horizontal





