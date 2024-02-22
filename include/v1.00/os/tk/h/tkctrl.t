;----[ tkctrl.t ]-----------------------

;----Target/Action--------

settgt_  = tcviewsz
;  A -> Action Method
;  if !actionmethod
;    RegPtr -> Routine Ptr
;  else
;    RegPtr -> null (uses firstkey view)
;    RegPtr -> Target Object

sendact_ = tcviewsz+3

;----Value Methods--------

setbyt_  = tcviewsz+6   ;Int/Char/Byte
setwrd_  = tcviewsz+9   ;Double/16-bit
setflt_  = tcviewsz+12  ;BASIC Float
setstr_  = tcviewsz+15  ;String Pointer




