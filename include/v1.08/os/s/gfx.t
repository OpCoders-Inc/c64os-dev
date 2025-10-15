;----[ gfx.t ]--------------------------

;Graphix State Struct

;--- gfx.lib requires first 6 bytes ---

gvidmode = 0  ;1 Byte     vdm_X dt.img.s
gcolhptr = 1  ;2 Bytes    screen mem buf
gcolmptr = 3  ;2 Bytes    color  mem buf
gbgcol   = 5  ;4 bits(lo) bckgrnd color
              ;4 bits(hi) border  color

;--- data loaders/savers need these ----

gbmapptr = 6  ;2 Bytes bitmap mem buf
gchbufsz = 8  ;1 Bytes scr mem buf sz
gcmbufsz = 9  ;1 Bytes col mem buf sz
gbmbufsz = 10 ;1 Bytes bit mem buf sz

             ;11 Bytes Total