;----[ input.t ]------------------------

linp     = $0100-(2*2)       ;2nd Module

initmouse_ = 0
;  C -> Set = Skip Load, just enable
;  Loads mouse cursor from disk
;  Starts tracking mouse events

killmouse_ = 3
;  Turns off mouse cursor
;  Stops tracking mouse events
;  C <- Set = Mouse Killed
;  C <- Clr = Mouse Already Off

hidemouse_ = 6
;  Turns off mouse cursor

mouserc_ = 9
;  A -> Flags
;  X -> X Pos (Pixels)
;  Y -> Y Pos (Pixels)
;  A <- Flags
;  X <- X Pos (Text Column)
;  Y <- Y Pos (Text Row)

;---------------------------------------

readmouse_ = 12
;  C <- Set on Empty
;  A <- Flags
;  X <- X Pos (Pixels)
;  Y <- Y Pos (Pixels)

deqmouse_ = 15
;  C -> Clear for normal dequeue
;  Dequeues the first mouse event
;  Shifts the remaining buffer by one
;  C -> Set writes A,X,Y to current evt

readkcmd_ = 18
;  C <- Set on Empty
;  A <- PETSCII Value
;  Y <- Key Event Flags

deqkcmd_ = 21
;  Dequeues the first key cmd event
;  Shifts the remaining buffer by one

readkprnt_ = 24
;  C <- Set on Empty
;  A <- PETSCII Value

deqkprnt_ = 27
;  Dequeues the first print key event
;  Shifts the remaining buffer by one

;---------------------------------------

polldevices_ = 30
;  Moves the mouse cursor
;  Queues mouse and keyboard events

