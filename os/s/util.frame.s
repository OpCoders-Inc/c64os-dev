;----[ util.frame.s ]-------------------

;Extended Exports Table in Utility.

scrlayer_ = utilbase+8
drawctx_ = utilbase+10
tkenv_   = utilbase+12
config_  = utilbase+14
confsize_ = utilbase+16

;Utility Framework's Jumptable

uf_kill  = $ff1b
uf_load  = $ff1e ;Load Utility
uf_init  = $ff21
uf_quit  = $ff24
uf_mapc  = $ff27 ;Map Colors
uf_draw  = $ff2a
uf_msrc  = $ff2d ;Mouse Row/Col
uf_chkb  = $ff30 ;Check Bounds

uf_pmus  = $ff33 ;Mouse Evts
uf_kcmd  = $ff36 ;KeyCmd Evts
uf_kprt  = $ff39 ;KeyPrnt Evts

uf_link  = $ff3c

metapage = $ff3f

;uf_init config flags

uf_settit = %00000001
uf_clrbuf = %00000010
uf_cnfglb = %00000100
uf_swpicn = %00001000

uf_umodal = %10000000

