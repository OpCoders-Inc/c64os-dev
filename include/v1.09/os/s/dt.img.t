;----[ dt.img.t ]-----------------------

;DataType:Image

;Every loader should support the first
;four, Generated Metadata indexes.

;If a loader does not support one of the
;later indexes, return with Carry Set.


;ImgInfo indexes

;Generated Metadata (RegPtr Strings)

dti_frmt = 0 ;Image Data Format
dti_mode = 1 ;VIC-II Video Mode
dti_pxsz = 2 ;Pixel Size (str WxH)
dti_imsz = 3 ;Image Size (str byte size)


;Stored Metadata    (RegPtr Strings)

dti_auth = 4 ;Author/Artist
dti_sorc = 5 ;Source (website,device...)
dti_date = 6 ;Year/Date
dti_titl = 7 ;Title

;Image Format       (INTs)

;Matrix info
dti_mxsz = 8 ;Matrix Size        (X,Y)
dti_mxst = 9 ;Matrix Start Frame (X,Y)

;Animation
dti_fcnt = 10 ;Frame Count       (X)
dti_fdel = 11 ;Frame Delay
dti_lcnt = 12 ;Loop Count        (X)

;Media control
dti_mctl = 13 ;Media Control     (X)

;Frame size
dti_frsz = 14 ;Frame Cell Size   (X,Y)

;Video modes
dti_vidm = 15 ;Video Mode        (X)
dti_vida = 16 ;Video Attributes  (X)

;---------------------------------------
;Metadata Value Constants

;Video Modes (VIC-II native modes)

vdm_stchr = 0  ;Standard Char
vdm_mcchr = 1  ;Multicolor Char
vdm_ebchr = 2  ;ExtBgnd Char
vdm_hrbmp = 3  ;HiRes Bitmap
vdm_mcbmp = 4  ;MultiColor Bitmap

;Video Attributes (CPU-assisted modes)

vat_fli8 = %00000001 ;8 Charmaps
vat_fli4 = %00000010 ;4 Charmaps
vat_lace = %00000100 ;Interlaced
vat_xshf = %00001000 ;X-shifted lacing
vat_bgnd = %00010000 ;BG Col#0 Array

;Media Controls

mcl_stat = 0 ;Static (not animated)
mcl_loop = 1 ;Loop   (anim. in a loop)
mcl_bnce = 2 ;Bounce (anim. back/forth)
mcl_hwrp = 3 ;Horz Wrap (3D Matrix)
mcl_vwrp = 4 ;Vert Wrap (3D Matrix)
mcl_mtrx = 5 ;No   Wrap (3D Matrix)