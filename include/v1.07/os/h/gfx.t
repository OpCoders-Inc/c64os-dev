;----[ gfx.t ]--------------------------

;Header for gfx.lib.r

gfxlibpg = $08ca

;Init called automatically by loadlib.
;init    = $00

;Unload called automatically by unldlib.
;unload  = $03

procgfx_ = $06

;Called automatically by the IRQ handler
;c64os_service. Takes no parameters.

confgfx_ = $09
;  Y -> bmmode $D011
;  A -> mcmode $D016
;  X -> bgmode $D020

;Called by setgfx Service KERNAL call.