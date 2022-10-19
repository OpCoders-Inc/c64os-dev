;----[ modules.h ]----------------------

sltb     = $d000-(2*10)

;Under $cxxx for IDE64

sser     = sltb-$06fc
sinp     = sser-$0574
smat     = sinp-$0130
stim     = smat-$020c

smem     = stim-$028a
sstr     = smem-$014b
sfil     = sstr-$0537
sscr     = sfil-$069f
smnu     = sscr-$089d
stkt     = smnu-$0548

syscall  .segment ;lxxx,routine
         .byte \1
         .word \2
         .endm

inc_h    .segment
         .include "os/h/@1.h"
         .endm

inc_s    .segment
         .include "os/s/@1.s"
         .endm

inc_k    .segment
         .include "os/s/ker/@1.s"
         .endm

inc_tkh  .segment
         .include "os/tk/h/@1.h"
         .endm

inc_tks  .segment
         .include "os/tk/s/@1.s"
         .endm

