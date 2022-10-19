;----[ io_joy.s ]-----------------------

jdrvpg   = $0802 ;Joystick Driver Page #

;Joystick Ports

jport1   = $0304
jport2   = $0305
jport3   = $0306
jport4   = $0307

;8 Joystick Buttons

jbut_up  = %00000001 ;Up
jbut_dn  = %00000010 ;Down
jbut_lt  = %00000100 ;Left
jbut_rt  = %00001000 ;Right
jbut_f1  = %00010000 ;Fire 1 (A But)
jbut_f2  = %00100000 ;Fire 2 (B But)
jbut_se  = %01000000 ;Select
jbut_st  = %10000000 ;Start



