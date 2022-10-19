;----[ dir.t ]--------------------------

frefptr  = $9b ;$9c
deptr    = $22 ;$23 ;Was $fb ;$fc
mdptr    = $24 ;$25 ;Was $fd ;$fe

;Dir Entry Struct

fdbsiz   = 1   ; 2 bytes (Alt., Part #)
fdname   = 3   ;17 bytes
fdtype   = 20  ; 1 byte
fdstatus = 21  ; 1 byte

fdyear   = 22  ; 1 byte
fdmnth   = 23  ; 1 byte
fddate   = 24  ; 1 byte
fdhour   = 25  ; 1 byte
fdmin    = 26  ; 1 byte

fdpetsz  = 27  ; 5 bytes (PETSCII Size)

;File Type (not datatype)

ft_dir   = 0 ;sort dir's to top
ft_prg   = 1
ft_rel   = 2
ft_seq   = 3
ft_usr   = 4
ft_del   = 5 ;sort del's to bottom

;Partition Type

pt_nat   = 6
pt_41    = 7
pt_71    = 8
pt_81    = 9
pt_cpm   = 10
pt_cfs   = 11
pt_sys   = 12

;File Status Flags

fds_lock = %00000001
fds_hide = %00000010
fds_open = %00000100
fds_boot = %00001000 ;IDE64 Boot Part.
fds_slct = %10000000

;Dir Metadata Struct

td_head  = 0  ;17 Dir Header
td_did   = 17 ; 2 Dir ID

td_free  = 19 ; 2 Blocks Free (int)
td_pfree = 21 ; 6 Blocks Free (PET)

td_part  = 27 ; 2 Part # (int)
td_ppart = 29 ; 4 Part # (PET)

td_fc    = 33 ; 2 File Count  (int)
td_pfc   = 35 ; 5 File Count  (PET)

td_patt  = 40 ;17 File Pattern
td_type  = 57 ; 1 File Type

td_sortf = 58 ; 1 Sort Field
td_sorto = 59 ; 1 Sort Options

td_sel   = 60 ; 1 Selected File Count
td_flags = 61 ; 1 Special Flags

;Sort Fields

;All sorts > ts_name subsort by ts_name

ts_disk  = 0
ts_name  = 1
ts_size  = 2
ts_type  = 3
ts_date  = 4

;Sort Options

ts_des   = %00000001 ;Descending

;other bits reserved

ts_a2p   = %01000000 ;ASCII 2 PETSCII
ts_case  = %10000000 ;Case Insensitive

;Special Dev/Dir Flags

ts_apps  = %00000001 ;Applications Dir
ts_utils = %00000010 ;Utilities Dir
ts_dirs  = %00000100 ;Dev Supports Dirs
ts_pdir  = %00001000 ;Partition Dir
ts_time  = %00010000 ;Include Date/Time

