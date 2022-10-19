;----[ dt.img.t ]-----------------------

;DataType:Image

;ImgInfo string indexes

dti_frmt = 0
dti_mode = 1
dti_pxsz = 2
dti_imsz = 3

;---[ Loaders ]-------------------------

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

;---[ Savers ]--------------------------

;TODO: Extend with Saver jump table

