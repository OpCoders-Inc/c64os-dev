;----[ gfx.t ]--------------------------

;Header for gfx.lib.r

gfxlibpg = $08ca

;Init called automatically by loadlib.
;init    = 0

;Unload called automatically by unldlib.
;unload  = 3

procgfx_ = 6

;Called automatically by the IRQ handler
;c64os_service. Takes no parameters.

confgfx_ = 9
;  Y -> bmmode $D011
;  A -> mcmode $D016
;  X -> bgmode $D020

;Called by setgfx Service KERNAL call.