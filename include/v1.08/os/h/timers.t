;----[ timers.t ]-----------------------

ltim     = $0100-(2*10)     ;10th module

;Initial state of tcancel flag matters.
;If tcancel is set when timer queued,
;the timer will undergo an initial reset
;If tcancel is clr, timer will not be
;reset, and first countdown can be diff.
;than the reset value.

timeque_ = $00
;  Enqueues a timer struct.
;  Called by the application.
;  RegPtr -> Timer struct
;  C <- Set on failure, buffer full

timedwn_ = $03
;  Counts down all timers.
;  Called by the IRQ routine.

timeevt_ = $06
;  Runs expired timer triggers.
;  Called by the main event loop.

msgapp_  = $09
;  Queue asynchronous message to app.
;  A -> msg code
;  X -> msg data
;  Y -> msg data
;  C -> set, 20 jiffy delay

msgutil_ = $0c
;  Queue asynchronous message to util.
;  A -> msg code
;  X -> msg data
;  Y -> msg data
;  C -> set, 20 jiffy delay