;----[ util.frame.t ]-------------------

;Must also include os/h/:util.frame.h

metapage = $ff3f ;Follows uf_link

;uf_init config flags

uf_settit = %00000001
uf_clrbuf = %00000010
uf_cnfglb = %00000100
uf_swpicn = %00001000

uf_umodal = %10000000