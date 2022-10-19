;----[ screen.t ]-----------------------

lscr     = $0100-(2*5)       ;5th Module

evtloop_ = 0
;  Initializes the main event loop. The
;  loop pulls input events and forwards
;  them to screen layers.

;---------------------------------------

markredraw_ = 3
;  X -> Layer index to redraw from.
;       All layers above X will also be
;       redrawn.
;  X -> 0 to redraw all layers.

layerpush_ = 6
;  RegPtr -> layer struct
;  Sets pushed index into layer struct.
;  C <- Set on error

layerpop_ = 9
;  Pops last pushed screen layer.
;  Z <- Set if all layers popped
;  Z <- Clr if layers still exist

;---------------------------------------

;NOTE: It is possible and intended to
;change draw props mid draw. Such as to
;change color or reverse/pet2scr flags.

;WARNING: Changing cursor move direction
;middraw is not supported, and is buggy.
;Always call setlrc for row and column
;when changing the cursor direction.

;HOW TO USE:
;Call setdprops first, then optionally
;Call setlrc twice, for row then column.

setlrc_  = 12
;Set Local Row or Column
;  RegWrd -> 16-bit local row/column
;  C      -> Call first Unset for Row
;  C      -> Call again Set   for Column

setdprops_ = 15
;Set Draw Properties
;  X -> Draw Property Flags
;  Y -> Color Code

ctxclear_ = 18
;Fill the currently defined context.
;  d_ctx     -> Set and Configured
;  d_reverse -> All pixels on
;  d_color   -> Visible in RVS
;  A         -> Fill Character

ctxdraw_ = 21
;Draw a character with context settings
;  d_ctx     -> Set and Configured
;  setdprops -> Called earlier
;  setlrc    -> Called earlier
;  A         -> Character to draw

;  C <- Set, no more valid draws
;  C <- Clr, can still draw more
;  Note: Preserves .X and .Y

ctx2scr_ = 24
;Copy the draw context to the screen buf
;at the offset coordinates.
;  X -> Left offset (signed)
;  Y -> Top  offset

;---------------------------------------

redraw_  = 27
;  Redraws according to layers marked
;  dirty. Called automatically at the
;  end of the main event loop.

scrrow_  = 30
;  A -> Row Number
;  RegPtr -> screen buffer
;  RegPtr <- line buffer

loadclr_ = 33
;  Clears screen memory of the area
;  that is drawn to by the Loader's
;  splash screen.
;  This only needs to be called if the
;  app being loaded will install a
;  character set. Call this before
;  installing the new character data.

loadicns_ = 36
;  Loads a table of system icons
;  RegPtr -> Icon Table

;CharsetIndex,Bitmask,IconID
;.byte $77,$00,icn_man
;.byte $78,$ff,icn_flag
;.byte $00 ;Terminator

copybufs_ = 39
;  This is a private API. It will not be
;  documented. It allows other system
;  components to invoke a screen buffer
;  copy outside the main event loop. It
;  is used by the crash recover library.

