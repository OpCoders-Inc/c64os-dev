;---[ c64archive.t ]--------------------

;Archive Header

car_type = 0   ;OS Archive Type
car_magic = 1  ;"C64Archive"
car_ver  = 11  ;Version #
car_date = 12  ;YMDhm 5-byte format
car_note = 17  ;30 char note+NULL

;File Header

;car_type = 0  ;(p/s/d) ... maybe others
car_lock = 1   ;1 = Locked
car_size = 2   ;filesize or DIR children
car_name = 5   ;Petsii, padded with $a0
car_comp = 21  ;This file's compression

;Compression Types

;0 = None (default)
;1 = RLE
;2 = LZ

;OS Archive types are used to tell the
;C64 Installer where to put the output
;folder. If it's of install type,
;the contents of the install start at
;the system directory, and overlay its
;subdirectories. This can put libs in
;/library/, drivers in /drivers/, apps
;and utilities in their directories.

;OS Archive Types

at_gnrl  = 0 ;General, any file or dir
at_rstr  = 1 ;Restore, sys directory
at_instl = 2 ;Install, sys overlay

