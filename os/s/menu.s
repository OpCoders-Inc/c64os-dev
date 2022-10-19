;----[ menu.s ]-------------------------

mnuicon  = $f2 ;Hamburger menu, rvs'd
mnulayer = 3   ;Highest of 4

tptr     = $50 ;Text/Temp Pointer
lptr     = $52 ;LastSib/Line Pointer
cptr     = $26 ;ColorLine Pointer

rootpg   = $0382 ;Menu Structure Root Pg
defpg    = $0383 ;Menu Def's Root Page
defpgcnt = $0384 ;Menu Def's Page Count
umdefpg  = $0385 ;Util Def's Root Page
umdefpgc = $0386 ;Util Def's Page Count

timutil  = $08cd ;17 bytes
memutil  = $08de ;17 bytes

statmode = $08ef

;Status Modes
stat_drv = 0 ;Drive Status
stat_app = 1 ;Application Custom
stat_fil = 2 ;Path to Open File

;struct
nextptr  = 0 ;2 bytes
childptr = 2 ;2 bytes
titleptr = 4 ;2 bytes
codeptr  = 6 ;2 bytes
entrysize = 8
;menuentry

;struct
awidth   = 0 ;1 byte
petvalue = 1 ;1 byte
actcode  = 2 ;1 byte
modkeys  = 3 ;1 byte
actionsize = 4
;actioncode

;struct
hwidth   = 0  ;1 byte
hopen    = 1  ;1 byte
headersize = 2
;headercode

