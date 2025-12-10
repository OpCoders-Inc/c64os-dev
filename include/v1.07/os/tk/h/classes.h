;----[ classes.h ]----------------------

;Class Start Offsets      (class size)

tsobj    = stkt-$11

tsview   = tsobj-$06a8

tssplit  = tsview-$03d9
tstabs   = tssplit-$0351
tsscroll = tstabs-$0319

tslabel  = tsscroll-$01a8

tsctrl   = tslabel-$01f7

tsbutton = tsctrl-$02da
tssbar   = tsbutton-$0795

;--[ Sizes ]----------------------------

tcobjsz  = 10
tcviewsz = tcobjsz+51
tcsplitsz = tcviewsz+3
tctabsz  = tcviewsz+9
tcscrollsz = tcviewsz+12
tclabelsz = tcviewsz+3
tcctrlsz = tcviewsz+18

tcbuttonsz = tcctrlsz+6
tcsbarsz = tcctrlsz+6

;---------------------------------------

;C64 OS Toolkit: ClassPtr (ClassById)

tkobj    = 0

tkview   = 1

tksplit  = 2
tktabs   = 3
tkscroll = 4

tklabel  = 5

tkctrl   = 6

tkbutton = 7
tksbar   = 8