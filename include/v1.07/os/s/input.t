;----[ input.t ]------------------------

scrlwhls = $0287 ;ScrlWheel Sensitivity
dblclktm = $0288 ;DblClick Jiffy Delay
mouseptr = $028f
mouseacc = $0290

musxpos  = $41 ;$42 16-bit 0 to 319
musypos  = $43 ;$44 16-bit 0 to 200
               ;Room for overflow math

mus0col  = $02fa ;Mouse Sprite 0 Color
mus1col  = $02fb ;Mouse Sprite 1 Color
mousesiz = $08cb ;X/Y Sprite Expand

;Mouse and Key Command Buffers: 24 bytes

mbufidx  = $0310 ;offset to next mus evt

musbufx  = $07e8 ;evt X positions (6)
musbufy  = $07ee ;evt Y positions (6)
musbuff  = $07f4 ;evt Flags       (6)

kcbufidx = $0311 ;offset to next key evt

kcbufpet = $07fa ;PET values (3)
kcbufkmd = $07fd ;Keymods    (3)

kbufptr  = $c6   ;Index into KeyPrnt buf

kbuffer  = $0277 ;Printable Key Buffer


musflgs  = $03fd

mouseon  = %00000001 ;mouse On/Off
mousetrk = %00000010 ;move events On/Off
mousemvd = %00000100 ;mouse moved

          ;%00001000 ;reserved

mousehid = %00010000 ;mouse hidden
mousepre = %00100000 ;precision tracking

mousenat = %01000000 ;natural scrl mode
mouselft = %10000000 ;left-handed mode


keymods  = $028d     ;Modifier Keys Mask
musbtns  = $f2

lshftkey = %00000001
cbmkey   = %00000010
ctrlkey  = %00000100
rshftkey = %00001000

mus_shft = %00010000
mus_cbm  = %00100000
mus_ctrl = %01000000

lbutmask = %00010000 ;Left but, Joy Fire
wdnmask  = %00001000 ;Wheel Dn, Joy Rght
wupmask  = %00000100 ;Wheel Up, Joy Left
mbutmask = %00000010 ;Midl but, Joy Down
rbutmask = %00000001 ;Rght but, Joy Up

;Mouse Event Types
move     = 0
ldown    = 1
ltrack   = 2
lup      = 3
lclick   = 4
ldclik   = 5
rdown    = 6
rtrack   = 7
rup      = 8
rclick   = 9
mdown    = 10
mup      = 11
mclick   = 12
wdown    = 13
wup      = 14
;reservd = 15