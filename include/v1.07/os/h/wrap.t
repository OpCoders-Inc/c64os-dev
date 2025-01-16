;----[ wrap.t ]-------------------------

;link = $00

reindex  = $03 ;Reindex string

  ;Reindex the lines in a string
  ;RegPtr -> C-String Pointer
  ;width_ -> wrap width
  ;width_ -> 0 = unwrap the text.

  ;width_ <- longest line (.word)
  ;A      <- line map page
  ;X      <- line map size