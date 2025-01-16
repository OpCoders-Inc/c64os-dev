;----[ toolkit.t ]----------------------

ltkt     = $0100-(2*9)       ;9th Module

pushctx_ = $00
;  Pushes the draw context to stack
;  Must be called with JSR, never JMP

pullctx_ = $03
;  Pulls the draw context from stack
;  Must be called with JSR, never JMP

setctx_  = $06
;  RegPtr -> Ptr to a drawctx in memory
;  Copies memory to the draw context

recontext_ = $09
;  Starts with the current context and
;  modifies and shrinks it for the
;  offset and size of this view.
;  this -> current node

boundschk_ = $0c
;  Checks if the current view falls at
;  least partially inside the context's
;  current drawing region.
;  this -> current node
;  C <- Set on out of bounds
;  C <- Clr on within bounds

settkenv_ = $0f
;  Sets the Toolkit environment
;  RegPtr -> Toolkit environment struct

;---------------------------------------

tkupdate_ = $12
;  Checks for dirty flag on the toolkit
;  environment, and then calls update on
;  the rootview. Clears TKE dirty flag.
;  RegPtr -> Toolkit Environment

tkmouse_ = $15
;  Hit tests and calls hit view's
;  responder method for the event type
;  RegPtr -> Toolkit Environment
;  C <- Clr = Event was handled
;  C <- Set = Event not handled

tkkcmd_  = $18
;  Calls dokeyeqv on first responder.
;  RegPtr -> Toolkit Environment
;  C <- Clr = Event was handled
;  C <- Set = Event not handled

tkkprnt_ = $1b
;  Calls keypress on first responder.
;  RegPtr -> Toolkit Environment
;  C <- Clr = Event was handled
;  C <- Set = Event not handled

;---------------------------------------

classlnk_ = $1e
;  Links a dynamically loaded class to
;  its superclass.
;  RegPtr -> Class to be linked
;  class  -> SuperClass

classptr_ = $21
;  Returns class ptr from a classId
;  X      -> classId
;  RegPtr <- Class

tknew_   = $24
;  Instantiates a new object of class X
;  RegPtr -> Class
;  this   <- new intance ptr
;  class  <- class of instance
;  RegPtr <- new intance ptr

getprop16_ = $27
;  Get 16-bit property of this
;  this   -> object
;  Y      -> property offset
;  RegWrd <- property

ptrthis_ = $2a
;  Set this to a new pointer.
;  Set class to this.isa (via fallthru)
;  RegPtr -> object
;  this   <- object
;  class  <- this.isa

setclass_ = $2d
;  Set class to this.isa
;  this  -> object
;  class <- this.isa

setsuper_ = $30
;  Set class to class.super
;  class -> class
;  class <- class.super

getmethod_ = $33
;  Get method pointer from class
;  class  -> class
;  Y      -> method offset
;  jmpvec <- method ptr
;  RegPtr <- method pointer

;---------------------------------------

instanceof_ = $36
;  Check if class descends from class
;  class  -> class
;  RegPtr -> class
;  C <- clr = It is an instance
;  C <- set = Not an instance

walk_    = $39
;  Recursively walks the node tree
;  calls sysjmp on each node.
;  this   -> current node
;  jmpvec -> routine to call
;  A -> $2c = Only visible nodes
;  A -> $4c = The whole node tree
;  C <- clr = completed
;  C <- set = keep walking

isdescof_ = $3c
;  Searches up the view hierarchy to see
;  if this is a nested child of the view
;  passed in.
;  this   -> current node
;  RegPtr -> potential ancestor view
;  A <- 1=Descends, 0=DoesNotDescend
;  Z <- Set if not a descendant
;  Z <- Clr if it does descend

opaqancs_ = $3f
;  Searches up the view hierarchy for
;  first opaque ancestor. Could return
;  this, if this is opaque.
;  this   -> current node
;  RegPtr <- opaque ancestor of this

viewwtag_ = $42
;  Finds a view that descends from this
;  that bears a matching tag.
;  this -> current node
;  A    -> a tag to search for

appendto_ = $45
;  Takes a parent, to which this is
;  appended, via the parent's addchild
;  method. This is left unchanged.
;  this   -> current node
;  RegPtr -> this's new parent
;  this   <- same this that was passed