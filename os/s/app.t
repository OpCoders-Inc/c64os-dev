;----[ app.t ]--------------------------

appbase  = $0900
utilbase = $e000

initextern = $02fc

;Application Jump Table
appinit  = 0 ;App Initalizer
appmcmd  = 2 ;Message Command
appquit  = 4 ;App Will Quit
appfrze  = 6 ;App Will Freeze to REU
appthaw  = 8 ;App Will Thaw from REU

;Utility Jump Table
utilidnt = 0 ;Util Identity
utilinit = 2 ;Util Initializer
utilquit = 4 ;Util Will Quit
utilmcmd = 6 ;Message Command

;Message Commands
mc_mnu   = 0 ;Menu Action
mc_menq  = 1 ;Menu Action Enquiry
mc_col   = 2 ;Selected Color

mc_fopn  = 3 ;File Open
mc_fsav  = 4 ;File Save

mc_stptr = 5 ;Status Pointer

mc_mous  = 6 ;Event (in Gfx Mode)
mc_kcmd  = 7 ;Event (in Gfx Mode)
mc_kprt  = 8 ;Event (in Gfx Mode)

mc_mptr  = 9 ;Memory Pointer

mc_rflg  = 10 ;Redraw Flags Changed
mc_hmem  = 11 ;Hi Mem Usage Changed
mc_theme = 12 ;TK Theme Changed
mc_chrs  = 13 ;Custom Charset Changed
mc_devs  = 14 ;Detected Devices Changed

mc_memw  = 15 ;Low Memory Warning
mc_jobc  = 16 ;Job Complete
mc_dmod  = 17 ;Dir Entry Modified
mc_cpbd  = 18 ;Clipboard Modified

mc_date  = 19 ;Selected Date or Datetime
mc_fsel  = 20 ;File Selection Change

mc_null  = $ff ;No Message

;Menu Status Inquiry Flags
mnu_dis  = %00000001 ;Entry Disabled
mnu_sel  = %00000010 ;Entry Selected

