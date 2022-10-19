;----[ file.t ]-------------------------

;struct
frefdev  = 0  ;  1 byte
frefpart = 1  ;  1 byte
freflfn  = 2  ;  1 byte
frefblks = 3  ;  2 bytes
frefname = 5  ; 17 bytes
frefpath = 22 ;234 bytes
frefsize = 256
;fileref

;Partition 0 = Partition Directory

;File Flags
ff_r     = %00000001 ;Read      in
ff_s     = %00000010 ;Stat/Size in
ff_w     = %00000100 ;Write     out
ff_a     = %00001000 ;Append    out
ff_o     = %00010000 ;Overwrite out
          ;%00100000 ;RESERVED
ff_p     = %01000000 ;PRG       out
          ;%10000000 ;RESERVED

;--- Workspace Variables ---------------

status   = $90
filesopen = $98

fnamelen = $b7
currentlf = $b8
currentsa = $b9
currentdv = $ba
fnameptr = $bb ;$bc

f_prefix = $0200 ; 3 Bytes
f_name   = $0203 ;16 Bytes +4 Flag Bytes

lfntab   = $0259

;Used only for momentary disk access:
;Load, Save or a Command.
;templfn is the largest possible LF#

templfn  = $7f

;Clipboard Metadata
c_dtype  = $0246
c_dstype = $0247
c_dsize  = $0248 ;$0249

;Error Channel Status
l_code   = $0354 ;Drive status as int
l_dev    = $0355 ;Device of last status

;Device Error Channel
;stat,msg,trk,sec -> "00, ok,00,00"
l_stat   = $0356 ;$0358   ;Device Status
l_msg    = $0359 ;$037a   ;Message
l_trk    = $037b ;$037d   ;Track
l_sec    = $037e ;$037f   ;Sector

