;----[ qsort.t for qsort.lib.r ]--------

presort_ = 0 ;Copy directory entry ptrs
             ;to dirlo/dirhi for sorting

  ;Sorter only supports 255 files
  ;Configures the item count.
  ;Must be called before "sort"

  ;A      -> Sort Page Lo (of 2pgs)
  ;RegPtr -> Item Fetch Routine

  ;Fetch routine takes an index and
  ;returns a pointer to an object or
  ;a struct to be sorted.

    ;X -> fetch item index
    ;RegPtr <- pointer to obj/struct
    ;Z      <- Set if done.

    ;RegPtr is null/invalid if Z set.

sort_    = 3 ;Sort item pointers

  ;Must call presort first.
  ;Comparator may be custom, or may come
  ;from routine returned by cmp.lib

  ;A      -> Item Count
  ;RegPtr -> Comparator

