;----[ exceptions.s ]-------------------

regstore = $c8     ;A/X/Y +0/+1/+2

backregs = $03bc   ;Temp Stashes A/X/Y
readregs = $03c3   ;Reads A/X/Y Back In

try_     = $03ca   ;Exception Handler
exception = $03df  ;Raise an Exception

excindex = $c7     ;Exceptions Tab Index

excaddr  = $0e;$0f ;Exception Address

try      .macro ;catch
         jsr backregs
         lda #<\1
         ldx #>\1
         jsr try_
         .endm                 ;10 bytes

;Use exittry if there is no catch block.

exittry  .macro
         dec excindex           ;2 bytes
         .endm

;Use endtry to skip the catch block.

endtry   .macro ;endcatch
         #exittry
         jmp \1
         .endm                  ;5 bytes

