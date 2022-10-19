;---[ openjobs.t ]----------------------

;A pointer to an OpenJob must be passed
;in opnutilmdlo/hi with mcmd mc_mptr
;to the Open Utility.

;OpenJob Struct

oj_type  = 0 ;4 Job Type Code
oj_vcb   = 4 ;2 Validation Callback

;OpenJob size = 6

;OpenJob Types

;"ojof" Open   File
;"ojsf" Select File
;"ojod" Open   Directory
;"ojsd" Select Directory
;"ojbX" Browse X=f{SHIFT--}d




