;----[ aswitch.t for aswitch.lib.r ]----

;link   = $00
;unlink = $03

aswitch_ = $06
;Switch to another app by name
;
;  RegPtr -> name of application
;  C -> Clr = Do not Auto-Unload lib
;  C -> Set = Auto-Unload lib