;----[ service.t ]----------------------

jiffylo  = $a2       ;Jiffy Clock 24-bit
jiffymi  = $a1
jiffyhi  = $a0
jcount   = $cd       ;Jiffy Counter
jc_min   = $eb       ;to $ee

sysjmp   = $54       ;JMP jmpvec
jmpvec   = $55;$56

raw_rts  = $02b2     ;Address of an RTS
sec_rts  = $02b3     ;Set Carry,    RTS
clc_rts  = $02b5     ;Clear Carry,  RTS

;sev      .macro           ;SEt oVerflow
;         bit raw_rts
;         .endm

emptystr = $02b7     ;Address of 0-Byte

sysfref  = $02c0     ;System File Ref
homebase = $02e9     ;Current Homebase

evttime  = $02ff     ;CPUBusy Event Time
cpuusage = $0217     ;CPU Usage History
busychar = $e6

loopbrkvec = $0336   ;Event Loop Break
appfileref = $0338   ;Current App Folder
opnfileref = $033a   ;Auto-Open File

berrcode = $03b9     ;BASIC Error Code
basicerr = $08f0     ;BASIC Err Handler

;Patches in IO/KERNAL
;Redirects through redirectvec
;Patches IO/KERNAL out

redirect = $08f4     ;KERNAL/IO Patch
redirectvec = $08f9  ;JMP to address

;Pass message to Util as it opens.
opnutilmcmd = $03fa  ;Message Command
opnutilmdlo = $03fb  ;Message Data Lo
opnutilmdhi = $03fc  ;Message Data Hi

;Pass message to App as it opens.
opnappmcmd = $03fa   ;Message Command
opnappmdlo = $03fb   ;Message Data Lo
opnappmdhi = $03fc   ;Message Data Hi

syskvals = $02b8   ;System Key Values
syskmods = $02bc   ;System Key Modifiers

;When in rgraphix mode
;hmemuse will always have hmembitm set.

himemuse = $03fe   ;Himem Usage

hmemfree = %00000000 ;Free/Unused
hmemutil = %00000001 ;Utility Executable
hmembuff = %00000010 ;Generic Buffer
;...
hmembitm = %01000000 ;Bitmap Mode Data
hmemmult = %10000000 ;Multi-Col Bitmap

;Graphix State Struct

;--- gfx.lib requires first 6 bytes ---

ghimemflg = 0 ;1 Byte  himem flags
gcolhptr = 1  ;2 Bytes screen mem buf
gcolmptr = 3  ;2 Bytes color  mem buf
gbgcol   = 5  ;1 Byte  background color

;--- data loaders/savers need these ----

gbmapptr = 6  ;2 Bytes bitmap mem buf
gchbufsz = 8  ;1 Bytes scr mem buf sz
gcmbufsz = 9  ;1 Bytes col mem buf sz
gbmbufsz = 10 ;1 Bytes bit mem buf sz

             ;11 Bytes Total


redrawflgs = $03ff ;Redraw Active Flags

;rnewgfx informs the split code that
;graphics data needs to be copied from
;buffers again.

;renagfx signals whether full screen gfx
;mode should be entered or exited.

;rgraphix indicates if full screen gfx
;is currently active or not.

rnewgfx  = %00000001 ;New GFX data
renagfx  = %00000010 ;Enable Full GFX
rgraphix = %00000100 ;Full GFX state

rmodal   = %00001000
rstatbar = %00010000
rcpubusy = %00100000
rclock   = %01000000
rmenubar = %10000000

;Shared Libraries

libchrlo = $08a2 ;$08ab
libchrhi = $08ac ;$08b5
libinfo  = $08b6 ;$08bf
liblocs  = $08c0 ;$08c9

;loadlib:
slnoinit = %10000000 ;Skip Auto Init

;unldlib:
slunload = %10000000 ;Make Unload Call

