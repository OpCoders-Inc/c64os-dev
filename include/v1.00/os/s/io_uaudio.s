;----[ io_uaudio.s ]--------------------

;1541 Ultimate II+: Ultimate Audio

ua_ch1   = $df20
ua_ch2   = $df40
ua_ch3   = $df60
ua_ch4   = $df80
ua_ch5   = $dfa0
ua_ch6   = $dfc0
ua_ch7   = $dfe0

ua_ctrl  = $00
ua_vol   = $01
ua_pan   = $02

ua_shi   = $04 ;Big Endian
ua_smh   = $05
ua_sml   = $06
ua_slo   = $07

ua_lhi   = $08 ;Big Endian
ua_lmi   = $09
ua_llo   = $0a

ua_rhi   = $0e ;Big Endian
ua_rlo   = $0f

ua_rahi  = $11 ;Big Endian
ua_rami  = $12
ua_ralo  = $13

ua_rbhi  = $15 ;Big Endian
ua_rbmi  = $16
ua_rblo  = $17

ua_iclr  = $1f

