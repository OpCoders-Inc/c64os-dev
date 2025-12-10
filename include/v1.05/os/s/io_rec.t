;----[ io_rec.t ]-----------------------

detectrec = $6400 ;1 Page Relocatable

reubanks = $0281 ;Detected  REU Banks
appreubk = $0282 ;First App REU Bank

reupage  = $0283 ;Curr. App REU Page -lo
reubank  = $0284 ;Curr. App REU Bank -hi
reufrzbk = $0286 ;App's REU Freeze Bank

recshunt = $022a ;REC Transfer Routine

reu_inc  = $01   ;Auto inc REU page/bank

;---------------------------------------

;Ram Expansion Controller

rec      = $df00 ;REC base address

rec_stat = $00 ;REC status  byte
rec_cmd  = $01 ;REC command byte

rec_clo  = $02 ;C64 main mem address lo
rec_chi  = $03 ;C64 main mem address hi

rec_rlo  = $04 ;REU in-bank address lo
rec_rmi  = $05 ;REU in-bank address hi

rec_rhi  = $06 ;REU bank number

rec_llo  = $07 ;Transfer length lo
rec_lhi  = $08 ;Transfer length hi

rec_imsk = $09 ;Interrupt mask
rec_ac   = $0a ;Address control

;REC Command Byte Options

rc_ctr   = %10010000 ;Immediate C64->REU
rc_rtc   = %10010001 ;Immediate REU->C64
rc_swap  = %10010010 ;Immediate Swap

rc_tctr  = %10000000 ;Triggered C64->REU
rc_trtc  = %10000001 ;Triggered REU->C64
rc_tswap = %10000010 ;Triggered Swap

;REC Shunt Table Offsets

rsh_cmd  = $00 ;Command Byte
rsh_cadr = $01 ;C64 Addr (16-bit)
rsh_radr = $03 ;REC Addr (16-bit)
rsh_bank = $05 ;REC Bank Number
rsh_size = $06 ;Transfer Size (16-bit)