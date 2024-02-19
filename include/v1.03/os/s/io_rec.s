;----[ io_rec.s ]-----------------------

detectrec = $6400 ;1 Page Relocatable

reubanks = $0281 ;Detected REU Banks
appreubk = $0282 ;First App REU Bank

reupage  = $0283 ;Curr. App REU Page -lo
reubank  = $0284 ;Curr. App REU Bank -hi

reu_inc  = $01   ;Auto inc REU page/bank

;Ram Expansion Controller

rec      = $df00
rec_stat = $00
rec_cmd  = $01

rec_clo  = $02
rec_chi  = $03

rec_rlo  = $04
rec_rmi  = $05
rec_rhi  = $06

rec_llo  = $07
rec_lhi  = $08

rec_imsk = $09
rec_ac   = $0a

