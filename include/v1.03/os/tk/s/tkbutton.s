;----[ tkbutton.s ]---------------------

;----Button Types------

bt_rad   = 0 ;Radio
bt_chk   = 1 ;Checkbox
bt_cyc   = 2 ;Cycle Button
bt_mnu   = 3 ;Menu  Button
bt_psh   = 4 ;Push  Button

;----Button Props-------

btype    = tkctrlsz   ;Button type

title    = tkctrlsz+1 ;String ptr
lpad     = tkctrlsz+3 ;Left padding

bnext    = tkctrlsz+4 ;Radio Link Ptr

;When one radio button is activated
;it needs to deactivate all the others
;in its set. Radio Buttons must be
;linked together in a singly-linked loop
;via bnext. 1 -> 2 -> 3 -> 4 -> 1 etc.

minval   = tkctrlsz+6  ;Minimum Value
maxval   = tkctrlsz+7 ;Maximum Value

