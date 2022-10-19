;----[ classes.h ]----------------------

;Class Start Offsets      (class size)

tsobj    = stkt-$21

tsview   = tsobj-$0699

tssplit  = tsview-$03d3
tstabs   = tssplit-$034f
tsscroll = tstabs-$0318

tslabel  = tsscroll-$0198

tsctrl   = tslabel-$01e7

tsbutton = tsctrl-$02d7
tssbar   = tsbutton-$0784

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

