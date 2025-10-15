;----[ io_scpu.t ]----------------------

;Constants for detecting and using a
;CMD SuperCPU 20MHz Accelerator.

;Detection

sc_dtct  = $d0bc

;bit sc_dtct
;N = DOS ext. mode (SuperCPU present)
;V = RAMLink Hardware Reg. Enabled

sc_mode  = $d0b0

scm1     = %11000000 ;Mask %11000000
scm2_64  = %01000000 ;Mask %11000000
scm2_128 = %00000000 ;Mask %11000000

;Write Switches (write sensitive)

sc_slow  = $d07a ; 1MHz or 2MHz on C128
sc_fast  = $d07b ;20MHz

;-------

sc_hrena = $d07e ;Hardware Reg. Enable
sc_hrdis = $d07f ;Hardware Reg. Disable

;Hardware register must be enabled to
;trigger these changes:

sc_vb1m  = $d074 ;VIC Bank 1 Mirroring
                 ;$8000 - $BFFF

sc_vb2m  = $d075 ;VIC Bank 2 Mirroring
                 ;$4000 - $7FFF

sc_basm  = $d076 ;BASIC Opt. Mirroring
                 ;$0400 - $07FF

sc_allm  = $d077 ;No Opt. Mirror all mem