;----[ sidplay.t for sidplay.lib.r ]----

;Init called automatically by loadlib.
;init    = 0

;Unload called automatically by unldlib.
;unload  = 3

loadtune_ = 6
;  RegPtr -> File Ref to relocated SID
;  C <- CLR = SID file loaded.
;  A <- Number of songs loaded.
;  X <- Start Song #.

;  C <- SET = SID NOT loaded.

;  RegPtr -> NULL to unload tune.
;  C <- CLR = Unloaded.
;  C <- SET = Nothing was loaded.

stattune_ = 9
;  A -> Tune State{SHIFT--}Tune# to init

tuneinfo_ = 12
;  A      -> Sidplay Tune Info Index
;  RegPtr <- Pointer to info string