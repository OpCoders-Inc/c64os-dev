;----[ modules.h ]----------------------

sltb     = $d000-(2*10)

;Under $cxxx for IDE64

sser     = sltb-$0716
sinp     = sser-$0350
smat     = sinp-$0175
stim     = smat-$021b

smem     = stim-$028a
sstr     = smem-$014d
sfil     = sstr-$0546
sscr     = sfil-$06ae
smnu     = sscr-$08aa
stkt     = smnu-$0557

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

inc_t    .segment
         .include "os/s/t/@1.s"
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