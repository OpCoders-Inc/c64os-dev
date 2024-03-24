;----[ fcopy.t for fcopy.lib.r ]--------

;link_    = 0
;unload_  = 3

;Configure source and destination
;file references and command channels.

confcopy_ = 6

  ;X -> src fileref page
  ;Y -> dst fileref page

  ;C <- Set on error
  ;C <- Clr on ready
  ;  X <- src command channel
  ;  Y <- dst command channel

;Copy source file to destination

filecopy_ = 9

  ;src fileref -> source file
  ;dst fileref -> destination file
  ;A -> File Flags for Write:
  ;     ff_o,ff_p

  ;A <- value of l_code (ferror)

;Copy file from old filename

spotcopy_ = 12

  ;A      -> fileref ptr high byte
  ;RegPtr -> old name string ptr
  ;A      <- value of l_code (ferror)

;Rename file from old filename

renamef_ = 15

  ;A      -> fileref ptr high byte
  ;RegPtr -> old name string ptr
  ;A      <- value of l_code (ferror)

;Scratch a file by file reference
;May be called from behind KERNAL ROM.

scratchf_ = 18

  ;Y -> filefref ptr high byte

