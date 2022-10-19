;----[ tkview.s ]-----------------------

colcoord = $61 ; $62 ;multplr
rowcoord = $63 ; $64 ;multcnd

;----Responder Props----

nextresp = tkobjsz

;----Node Props---------

parent   = tkobjsz+2
child    = tkobjsz+4
sibling  = tkobjsz+6

tag      = tkobjsz+8

;----Sizing Props-------

offtop   = tkobjsz+9
offbot   = tkobjsz+11
absbot   = tkobjsz+13
height   = tkobjsz+15

offleft  = tkobjsz+17
offrght  = tkobjsz+19
absrght  = tkobjsz+21
width    = tkobjsz+23

rsmask   = tkobjsz+25

;----Scrolling Props----

s_top    = tkobjsz+26
s_left   = tkobjsz+28

;----Drawing Props------

dflags   = tkobjsz+30
mflags   = tkobjsz+31
bcolor   = tkobjsz+32

;----Hit Props----------

hitrow   = tkobjsz+33
hitcol   = tkobjsz+35

