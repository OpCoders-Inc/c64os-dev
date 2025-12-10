;----[ input.t ]------------------------

linp     = $0100-(2*2)       ;2nd Module

initmouse_ = $00
;  C -> Set = Skip Load, just enable
;  Loads mouse cursor from disk
;  Starts tracking mouse events

killmouse_ = $03
;  Turns off mouse cursor
;  Stops tracking mouse events
;  C <- Set = Mouse Killed
;  C <- Clr = Mouse Already Off

hidemouse_ = $06
;  Turns off mouse cursor

mouserc_ = $09
;  A -> Flags
;  X -> X Pos (Pixels)
;  Y -> Y Pos (Pixels)
;  A <- Flags
;  X <- X Pos (Text Column)
;  Y <- Y Pos (Text Row)

;---------------------------------------

readmouse_ = $0c
;  C <- Set on Empty
;  A <- Flags
;  X <- X Pos (Pixels)
;  Y <- Y Pos (Pixels)

deqmouse_ = $0f
;  C -> Clear for normal dequeue
;  Dequeues the first mouse event
;  Shifts the remaining buffer by one
;  C -> Set writes A,X,Y to current evt

readkcmd_ = $12
;  C <- Set on Empty
;  A <- PETSCII Value
;  Y <- Key Event Flags

deqkcmd_ = $15
;  Dequeues the first key cmd event
;  Shifts the remaining buffer by one

readkprnt_ = $18
;  C <- Set on Empty
;  A <- PETSCII Value

deqkprnt_ = $1b
;  Dequeues the first print key event
;  Shifts the remaining buffer by one

;---------------------------------------

polldevices_ = $1e
;  Moves the mouse cursor
;  Queues mouse and keyboard events