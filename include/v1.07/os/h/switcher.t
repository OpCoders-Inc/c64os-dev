;----[ switcher.t ]---------------------

;The jump table routines for switcher.

;These are offsets that extend the
;appbase vector table, but they are only
;present in switcher, which loads to
;appbase.

;To use: jmp (appbase+sinitreu)
;        jmp (appbase+srestore)
;        ...etc.

sinitreu = $0a ;First Boot, init the REU
srestore = $0c ;Restore REU for reboot
prepload = $0e ;Prepare to Load an App