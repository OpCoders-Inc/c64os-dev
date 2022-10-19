;---[ savejobs.t ]----------------------

;A pointer to a SaveJob must be passed
;in opnutilmdlo/hi with mcmd mc_mptr
;to the Save Utility.

;SaveJob Struct

sj_type  = 0 ;4 SaveJob Type Code
sj_vcb   = 4 ;2 Validation Callback
sj_ovr   = 6 ;1 Overwrite Flag
sj_nlen  = 7 ;1 Filename Length

;SaveJob size = 8

;sj_ovr passes to the Save Utility the
;initial state of the overwrite flag.
;And if the Utility changes the state
;of the box, it's passed back to the
;Application via the SaveJob Struct.

;sj_nlen is the available length of the
;filename, implemented as a maxlen on
;the filename input field. The length
;is equal to 16-(extension length+1).

;SaveJob Types

;"sjsf" Save   File
;"sjcf" Create File
;"sjbX" Browse X=f

