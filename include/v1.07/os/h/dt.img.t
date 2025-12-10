;----[ dt.img.t ]-----------------------

;The jump tables for image datatype
;loaders and savers.


;---- Image Loaders ----

;link = $00
;Called Automatically by loadreloc

imginfo  = $03
;Get Image Info String
;  A      -> String Index
;  RegPtr <- Info String

imgconf  = $06
;Configure read buffers and gfxctx
;  RegPtr -> GfxCtx pointer

imgload  = $09
;Load image into preconfigured buffers
;  imgconf must be called first.
;  RegPtr -> FileRef to img file to load
;  C <- Clr = Success
;  C <- Sec = Failure

;---- Image Savers ----

;link = $00
;Called Automatically by loadreloc

imgprep  = $03
;Config write buffers and confirm
;that gfxctx has valid img data.
;  RegPtr -> GfxCtx pointer

imgsave  = $06
;Save image from preconfigured buffers
;  imgprep must be called first.
;  A      -> $00 or ff_o for overwrite.
;  RegPtr -> FileRef to img file to save
;  C <- Clr = Success
;  C <- Sec = Failure