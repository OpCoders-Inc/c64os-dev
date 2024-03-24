;----[ toolkit.t ]----------------------

this     = $2b ;$2c THIS  pointer
class    = $2d ;$2e CLASS pointer
pnode    = $2f ;$30 PNODE pointer

rootview = $03ba ;$03bb Root TK View

;View Resize Mask
rm_ankt  = %00000001 ;anchor top
rm_ankb  = %00000010 ;anchor bottom
rm_ankl  = %00000100 ;anchor left
rm_ankr  = %00001000 ;anchor right

rm_rschd = %10000000 ;Resize Children

;View Display Flags
df_dirty = %00000001 ;Needs redraw
df_sized = %00000010 ;Don't resize
df_opaqu = %00000100 ;Opaque

df_afkey = %00001000 ;Accept 1st Key
df_afmus = %00010000 ;Accept 1st Mouse
df_first = %00100000 ;1st Key Responder

df_ibnds = %01000000 ;Is within bounds
df_visib = %10000000 ;Visible (not hid)

;View Modified Flags
mf_resiz = %00000010 ;Needs resize
mf_bdchk = %01000000 ;Needs bounds check

tkenvptr = $ef; $f0

;Toolkit Environment
te_dctx  = 0  ;2 Draw Context Pointer
te_mpool = 2  ;1 Memory Pool Page
te_flags = 3  ;1 Env.Global Draw Flags
te_layer = 4  ;1 Screen Layer
te_rview = 5  ;2 Root view
te_fkeyv = 7  ;2 First key view
te_fmusv = 9  ;2 First mouse view
te_cmusv = 11 ;2 Clicked mouse view
te_posx  = 13 ;1 Ctx2scr X-Offset
te_posy  = 14 ;1 Ctx2scr Y-Offset

tf_dirty = %00000001 ;Update Rootview
tf_keyh  = %01000000 ;Key Event Handled
tf_blur  = %10000000 ;TKEnv Out of Focus

