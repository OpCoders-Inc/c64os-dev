;----[ service.t ]----------------------

lser     = $0100-(2*7)       ;7th Module

alert_   = 0
;Rotates the border color twice.

confirq_ = 3
;  Replace Default IRQ Routine

;---------------------------------------

getargs_ = 6
;  A -> argc
;  argptr <- Points to inline args

updstat_ = 9
;  Mark menu layer for redraw

setflags_ = 12
;  Sets the system draw flags
;  A -> Flags Byte

redrwtod_ = 15
;  Redraw Clock if enabled

setgfx_  = 18
;  Configures the current graphix state.
;  Allows split screen and rgraphix mode
;  RegPtr -> gstate struct
;  If gfx.lib is not installed, it will
;  be automatically installed when this
;  routine is called for the first time.

getsfref_ = 21
;  Y -> Allocated page into which to
;       initialize the sysfref.
;  Y -> 0 to automatically allocate one
;       new memory page for the sysfref.
;  Y <- End of Path
;  X <- Page of new system fref
;  frefptr <- Alloc'd and Init'd

syskcmd_ = 24
;  Process lowest level system key cmds
;  A -> PETSCII Value
;  Y -> Mod Key Flags

;---------------------------------------

initextern_ = 27
;  Initialize an externs jump table
;  RegPtr -> Start of externs table

loadutil_ = 30
;  RegPtr -> Utility name c-string
;  C <- CLR = Will be Opened
;  C <- SET = Already Open

quitapp_ = 33
;  RegPtr <- Addr to runhome routine

loadapp_ = 36
;  RegPtr -> AppFileRef

loadreloc_ = 39
;  RegPtr -> FileRef to TSR program
;  A <- First page relocated to
;
;  Can relocate a binary that is one or
;  more pages. If the binary is > 1 page
;  the FileRef must be embedded in a mem
;  buffer large enough to hold the file
;  that it references.

loadlib_ = 42
;  X -> 1st lib filename char
;  Y -> 2nd lib filename char
;  A -> Lo nybble = size 0-15pgs
;  A -> Hi nybble = load flags
;  A <- 1st Page of Library
;
;  Loads a library if not loaded. Sets
;  reference count to 1. If lib already
;  loaded, increments the ref count.

unldlib_ = 45
;  X -> 1st lib filename char
;  Y -> 2nd lib filename char
;  A -> Unload flags
;
;  Decrements library's reference count.
;  If RefCount=0, unloads and frees mem.

