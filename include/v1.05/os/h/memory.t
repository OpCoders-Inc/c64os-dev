;----[ memory.t ]-----------------------

lmem     = $0100-(2*1)       ;1st Module

memcpy_  = 0
;  A -> Source page address
;  Y -> Dest page address

memset_  = 3
;  A     -> Fill byte value
;  Y     -> Page address to fill
;  A/X/Y <- Same as the came in.

memfree_ = 6
;  X <- Number of free pages

;---------------------------------------

free_    = 9
;  RegPtr -> pointer to malloc'd memory

malloc_  = 12
;  A      -> Memory pool (start page)
;  RegWrd -> 16-bit length to allocate
;  C      <- Set on error
;  RegPtr <- Pointer to start of memory

;---------------------------------------

pgfree_  = 15
;  Y -> Page address to free
;  X -> Number of pages to free
;  C <- Set on error

pgmark_  = 18
;  X -> First page to mark
;  Y -> Last  page to mark

pgalloc_ = 21
;  A -> Allocation Type
;  X -> Number of pages to allocate
;  Y <- First allocated page address
;  C <- Set on error

;---------------------------------------

reuconf_ = 24
;  RegPtr -> REU Bank/Page
;  A      -> Config Flags
;  C      <- Set on NO REU available
;  A      <- # Banks Available to App

pgfetch_ = 27
;  RegPtr -> C64 Memory Buffer to fetch
;  C      <- Set on failure to fetch
;  C      <- Clr on successful fetch

pgstash_ = 30
;  RegPtr -> C64 Memory Buffer to stash
;  C      <- Set on failure to stash
;  C      <- Clr on successful stash


;---------------------------------------
;memory.lib routines (not in KERNAL)

realloc_ = 3
;  A       -> Memory pool (start page)
;  RegPtr  -> Ptr returned from malloc
;  memsize -> Resize to 16-bit length
;  C       <- Set on error
;  RegPtr  <- Pointer to resized memory

bkfree_  = 6
;  Y -> Start bank number (normal)
;  X -> Number of banks
;  C <- Failure (bankmap not changed)
;  C <- Success

;Fails if the range attempting to be
;freed contains any allocation type
;other than the current App's reufrzbk.

bkalloc_ = 9
;  X -> Size in 64K banks
;  Y <- Start bank number (normal)
;  C <- Set on failure
;  C <- Clr on success

;Fails if a contiguous range of free
;banks of size X cannot be found.

;Allocated banks are marked as alloc'd
;by the current App's reufrzbk.