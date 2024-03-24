;---[ io_iec.s ]------------------------

detectiec = $2a00 ;2pages relocatable

drivemap = $0334 ;(+8->30) $033c->$0353

;Drive Types
devnot   = 0     ;No Device Present
devfor   = 1     ;Foreign/Unknown Device
dev1541  = 41    ;Commodore 1541
dev1571  = 71    ;Commodore 1571
dev1581  = 81    ;Commodore 1581

;Support Parts and Sub-Directories
devcmdfd = $80+2 ;CMD FD2000/4000
devcmdhd = $80+3 ;CMD HD
devcmdrl = $80+4 ;CMD RamLink
devcmdrd = $80+5 ;RamDrive/REU w/RamDos
devsdiec = $80+6 ;SD2IEC/uIEC SD
devide64 = $80+7 ;IDE64




