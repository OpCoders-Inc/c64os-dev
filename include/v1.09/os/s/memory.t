;----[ memory.t ]-----------------------

;Memory Mapping Routines
seeram   = $02a7
seeioker = $02ac

;Other bits can be used in the map for
;taken to mean that the OS allocated
;them, or that they are in the REU, etc.

;maptemp is used when the system alloc's
;memory for the app. The App must change
;the type to mapapp to retain it. Other-
;wise the system will deallocate it.

memmap   = $0800 ;$08a0 (pages $09->$a0)

mapfree  = $00
mapsys   = $01 ;Allocated by the system
maputil  = $02 ;Allocated by the util
mapapp   = $ff ;Allocated by the app
maptemp  = $7f ;Allocated By the system

;This is used so we don't have to pass
;the default memory pool into every call

mempool  = $0380 ;Memory Pool Start Page

;Pages are allocated from the top down

;Page number of first page is configured
;and stored at mappgfst. But mappglst is
;static, it's always page #$09.

mappgfst = $08a1 ;First Page (variable)
mappglst = $09   ;Last  Page (constant)

;Memory Display Mode

;In os/settings/:memory.t
; 0 = Pages{SHIFT--}REU Units -> "P" in memdisp
; 1 = Kilobytes       -> "K" in memdisp

memdisp  = $08cc ;"P"{SHIFT--}"K"

;Struct
mhfree   = 0 ;1 byte
mhlen    = 1 ;2 bytes
mhsize   = 3
;Malloc Header

;For realloc
memsize  = $61 ;$62