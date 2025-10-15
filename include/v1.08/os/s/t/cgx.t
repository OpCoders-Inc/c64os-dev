;----[ cgx.t ]--------------------------

;Commodore Grafix format, RIFF/CGFX

;This is a RIFF container format for
;essentially all modern C64 Graphics
;formats. With support for metadata,
;3D matrix images, animations, variable
;frame sizes, sprite overlays, etc.

;MediaID ("CGFX")

;Metadata chunk ("META")

cgm_artist = 0
cgm_source = 32
cgm_releas = 64
cgm_title = 96

;Frame Format chunk ("FRMT")

cgf_mxrws = 0  ;Matrix Rows
cgf_mxcls = 1  ;Matrix Cols
cgf_mxsri = 2  ;Start Row Index
cgf_mxsci = 3  ;Start Col Index

cgf_frcnt = 4  ;Frame Count
cgf_frdel = 5  ;Frame Delay
cgf_lpcnt = 6  ;Loop Count
cgf_mdctl = 7  ;Media Control

;Frame count: Matrix rows * Matrix cols

;Frame delay: 10ths of a second.
;Non-animated should have value of 0.
;
;  NTSC: 1 = 6 Jiffies between frames.
;   PAL: 1 = 5 Jiffies between frames.

;Loop Count: 0 = Infinite.

cgf_fsrws = 8  ;Frame Size Rows
cgf_fscls = 9  ;Frame Size Cols
cgf_vdmod = 10 ;Video Mode
cgf_vdatr = 11 ;Video Attributes