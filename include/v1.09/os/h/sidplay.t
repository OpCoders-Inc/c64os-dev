;----[ sidplay.t for sidplay.lib.r ]----

;Init called automatically by loadlib.
;init    = $00

;Unload called automatically by unldlib.
;unload  = $03

loadtune_ = $06
;  RegPtr -> File Ref to relocated SID
;  C <- CLR = SID file loaded.
;  A <- Number of songs loaded.
;  X <- Start Song #.

;  C <- SET = SID NOT loaded.

;  RegPtr -> NULL to unload tune.
;  C <- CLR = Unloaded.
;  C <- SET = Nothing was loaded.

stattune_ = $09
;  A -> Tune State{SHIFT--}Tune# to init

tuneinfo_ = $0c
;  X      -> Sidplay Tune Info Index
;  RegPtr <- Pointer to info string