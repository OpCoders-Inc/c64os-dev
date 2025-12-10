;----[ switcher.t ]---------------------

;For the Fast App Switcher. Defines the
;workspace bank, and where certain key
;properties are located in that bank.

workbank = $00 ;REU bank $00 workspace

;Switcher is found at appbase, just like
;loader and the bulk of booter.

magicadr = $00 ;Where "C64 OS" magic is.

;---------------------------------------

;Bank Order: 32 bytes, holds access
;order of bank numbers from $01 to $20

bankordr = $1ae0 ;-> $1aff   (32 bytes)

;Bank Map: 1 page, 256 bytes,
;1 byte for each of up to 256 REU banks.

bankmap  = $1b00 ;-> $1bff  (256 bytes)

;Bank usage values.

bnk_nota = $ff  ;Bank Not Available
bnk_free = $fe  ;Bank Not Allocated

bnk_empt = $fd  ;Bank Empty: Switchable
bnk_full = $fc  ;Bank Full:  Has an App

;Values from $01 to $20 in the bankmap
;represent allocated banks, whose owner
;is the App assigned to that bank.

;E.g.,
; App Launcher is in bank $01
; File Manager is in bank $02
; Image Viewer is in bank $03
;
; If bankmap+$14 holds the value $03,
; This means Image Viewer allocated REU
; bank number $14 for its own use.
;
; If the Application in bank $03 is ever
; forceably expunged, all values in the
; bankmap that are currently $03 get
; changed to bnk_free ($fe).


;Fast App Switch Slots: 4 pages.
;32 Slots at 32 bytes each.

fasslots = $1c00 ;-> $1fff (1024 bytes)

;The index into fasslots is the bankmap
;index-1. I.e., if an Application is in
;bank $03, its name appears in the slot
;fasslots,2 or (fasslots+(32*2))

;Temporary address where an App sets
;its state during appfrze handler. This
;value gets copied to the FAS Slot by
;switcher before loading the next App.

fss_stat = $03b8 ;Temporary address

;Structure of a FAS Slot

fas_name = $00 ;16-chars + NULL
fas_stat = $11 ;Saved State

;FAS Slot States

fss_safe = $00 ;Saved and quittable
fss_usaf = $01 ;Unsaved content!


;Open File Reference placeholder

opnfrefreu = $2000 ;-> $20ff (1 Page)

;Switcher passes an open file reference
;between banks by first copying it to
;the REU workbank at opnfrefreu.

;RTC Driver Cache

rtcdrvrreu = $2100 ;-> $23ff (3 Pages)

;The booter loads the RTC driver and
;relocates it to $2100. Then stashes it
;here in workbank. Switcher swaps this
;code in, and calls gettime, during
;reurstr to refresh the date/time.