;----[ fpattern.t for fpattern.lib.r ]--

;link = $00

filepatt_ = $03
;Load directory from pattern
;
;  RegPtr -> file pattern (nhd.????.??)
;  e.g. "nhd.????.??" or "img.*"
;
;  Y <- Start page alloc'd
;  X <- Number of pages alloc'd
;  A <- Number of dir entries
;
;  Raises exception if it can't allocate
;  the memory needed to load the data.
;
;  currentdv must be set.
;  finit already called on dev.