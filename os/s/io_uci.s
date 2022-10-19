;----[ io_uci.s ]-----------------------

;Ultimate Command Interface

uci      = $df00

uci_ctrl = $1c ;Use with Write
uci_stat = $1c ;Use with Read

uci_cmd  = $1d ;Use with Write
uci_id   = $1d ;Use with Read

uci_resp = $1e ;Data Response (readonly)
uci_sdat = $1f ;Status Data   (readonly)

;Control Register Flags

uci_pcmd = %00000001 ;Push Command
uci_dacc = %00000010 ;Data Accepted
uci_abrt = %00000100 ;Abort
uci_cerr = %00001000 ;Clear Error

;Status Register Flags

uci_cbsy = %00000001 ;Command Busy
          ;%00000010 ;Data Accepted
          ;%00000100 ;Abort
uci_eror = %00001000 ;Error
uci_smsk = %00110000 ;State Mask
uci_stav = %01000000 ;State Available
uci_dtav = %10000000 ;Data  Available

;Status Register States

uci_idle = %00000000 ;Idle
uci_busy = %00010000 ;Command Busy
uci_dlst = %00100000 ;Data Last
uci_dmor = %00110000 ;Data More

