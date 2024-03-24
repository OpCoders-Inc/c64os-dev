
;----[ basic.s ]------------------------

;HOW TO USE:
;
; .include this file as first code.
; Omit the *= $xxxx from your code.

         *= $0801

         .word end    ;Next Line Ptr
         .word 64     ;Line #64 ;)

         .byte $9e    ;SYS
         .null "2061" ;$080d

end      .word $00    ;End of Basic







