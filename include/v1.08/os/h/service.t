;----[ service.t ]----------------------

lser     = $0100-(2*7)       ;7th Module

alert_   = $00
;Rotates the border color twice.

confirq_ = $03
;  Replace Default IRQ Routine

;---------------------------------------

getargs_ = $06
;  A -> argc
;  argptr <- Points to inline args

updstat_ = $09
;  Mark menu layer for redraw

setflags_ = $0c
;  Sets the system draw flags
;  A -> Flags Byte

redrwtod_ = $0f
;  Redraw Clock if enabled

setgfx_  = $12
;  Configures the current graphix state.
;  Allows split screen and rgraphix mode
;  RegPtr -> gstate struct
;  gfx.lib must be loaded before calling
;  setgfx.

getsfref_ = $15
;  Y -> Allocated page into which to
;       initialize the sysfref.
;  Y -> 0 to automatically allocate one
;       new memory page for the sysfref.
;  Y <- End of Path
;  X <- Page of new system fref
;  frefptr <- Alloc'd and Init'd

syskcmd_ = $18
;  Process lowest level system key cmds
;  A -> PETSCII Value
;  Y -> Mod Key Flags

;---------------------------------------

initextern_ = $1b
;  Initialize an externs jump table
;  RegPtr -> Start of externs table

loadutil_ = $1e
;  RegPtr -> Utility name c-string
;  C <- CLR = Will be Opened
;  C <- SET = Already Open

quitapp_ = $21
;  RegPtr <- Addr to runhome routine

loadapp_ = $24
;  RegPtr -> AppFileRef

loadreloc_ = $27
;  RegPtr -> FileRef to TSR program
;  A <- First page relocated to
;  C <- Set on error
;
;  Automatically runs the first jump
;  table entry, at $xx00. Usually "link"
;
;  Can relocate a binary that is one or
;  more pages. If the binary is > 1 page
;  the FileRef must be embedded in a mem
;  buffer large enough to hold the file
;  that it references.

loadlib_ = $2a
;  X -> 1st lib filename char
;  Y -> 2nd lib filename char
;  A -> Lo nybble = size 0-15pgs
;  A -> Hi nybble = load flags
;  A <- 1st Page of Library
;
;  Loads a library if not loaded. Sets
;  reference count to 1. If lib already
;  loaded, increments the ref count.

unldlib_ = $2d
;  X -> 1st lib filename char
;  Y -> 2nd lib filename char
;  A -> Unload flags
;
;  Decrements library's reference count.
;  If RefCount=0, unloads and frees mem.