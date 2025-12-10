;----[ dir.t for dir.lib.r ]------------

getdirp_ = $00
;  A <- directory chain root page

freedir_ = $03
;  A -> directory chain root page

readdir_ = $06
;  mdptr   -> directory metadata
;  frefptr -> fref w/path to load
;  X <- directory chain root page
;  C <- SET on error.