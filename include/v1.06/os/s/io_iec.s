;---[ io_iec.s ]------------------------

detectiec = $2a00 ;2pages relocatable

drivemap = $0334 ;(+8->30) $033c->$0353

;Legacy Devices:
; Bit7 -> 0 = No Sub-Directories
; No Partitions

devnot   = 0     ;No Device Present
devfor   = 1     ;Foreign/Unknown Device
devvice  = 10    ;VICE FS (single dir.)
dev1541  = 41    ;Commodore 1541
dev1571  = 71    ;Commodore 1571
dev1581  = 81    ;Commodore 1581

;Modern Devices:
; Bit7 -> 1 = Sub-Directories

; Bit6 -> 0 = Supports Partitions
; Bit6 -> 1 = 1 Partition Only

devcmdfd = $80+2  ;CMD FD2000/4000
devcmdhd = $80+3  ;CMD HD
devcmdrl = $80+4  ;CMD RamLink
devcmdrd = $80+5  ;RamDrive/REU w/RamDos
devsdiec = $80+6  ;SD2IEC/uIEC SD
devide64 = $80+7  ;IDE64

devultim = $c0+10 ;Ultimate SoftIEC
devp1541 = $c0+11 ;pi1541