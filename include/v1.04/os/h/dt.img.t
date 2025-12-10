;----[ dt.img.t ]-----------------------

;The jump tables for image datatype
;loaders and savers.


;---- Image Loaders ----

;link = 0
;Called Automatically by loadreloc

imginfo  = 3
;Get Image Info String
;  A      -> String Index
;  RegPtr <- Info String

imgconf  = 6
;Configure read buffers and gfxctx
;  RegPtr -> GfxCtx pointer
;  A      -> First pg of bitmap buffer

imgload  = 9
;Load image into preconfigured buffers
;  imgconf must be called first.
;  RegPtr -> FileRef to img file to load
;  C <- Clr = Success
;  C <- Sec = Failure

;---- Image Savers ----

;TODO: Extend with Saver jump table