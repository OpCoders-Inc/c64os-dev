;----[ io_swiftlink.t ]-----------------

;Workspace memory addresses for
;swiftlink serial buffers and state.

;driver code addressing scheme

; e0 = $de00
; e2 = $de20
; e4 = $de40
; e6 = $de60
; e8 = $de80
; ea = $dea0
; ec = $dec0
; ee = $dee0

; f0 = $df00
; f2 = $df20
; f4 = $df40
; f6 = $df60
; f8 = $df80
; fa = $dfa0
; fc = $dfc0
; fe = $dfe0


;--- Buffer Management ---

swibuf   = $f7 ;$f8 ;Input  Buf Ptr
swobuf   = $f9 ;$fa ;Output Buf Ptr

swidbe   = $029b  ;Input buf end   index
swidbs   = $029c  ;Input buf start index

swodbe   = $029d ;Output buf end   index
swodbs   = $029e ;Output buf start index

;--- ACIA Registers ------

sw_data  = sw+$00 ;Data Read/Write
sw_stat  = sw+$01 ;Status Read/Reset
sw_cmd   = sw+$02 ;Command Read/Write
sw_ctrl  = sw+$03 ;Control Read/Write

;--- Status Bits ---------

sws_per  = %00000001 ;Parity  Error
sws_fer  = %00000010 ;Framing Error
sws_oer  = %00000100 ;Overrun Error

sws_rrd  = %00001000 ;Receiver    Full
sws_trd  = %00010000 ;Transmitter Empty

sws_dsr  = %00100000 ;Data Set Ready
                     ;Hi = Not Ready
                     ;Lo = Ready

sws_dcd  = %01000000 ;Carrier Detect
                     ;Hi = Not Detected
                     ;Lo = Detected

sws_irq  = %10000000 ;Interrupt Flag
                     ;Hi = IRQ Occurred
                     ;Lo = No IRQ occur.

                     ;Unreliable >9600

;--- Command Bits --------

swc_dtr  = %00000001 ;Data Term. Ready
                     ;Hi = Enable  Rx/Tx
                     ;Lo = Disable Rx/Tx

swc_irq  = %00000010 ;IRQ Mask:
                     ;Hi = Disable IRQs
                     ;Lo = Enable  IRQs

swc_tc0  = %00000100 ;Transmitter Ctrl 0
swc_tc1  = %00001000 ;Transmitter Ctrl 1

swc_ech  = %00010000 ;Echo
                     ;Hi = Echo On
                     ;Lo = Echo Off

swc_par  = %00100000 ;Parity Enable

;swc_pm0 = %01000000 ;Parity Mode 0
;swc_pm1 = %10000000 ;Parity Mode 1

;Transmitter Control Bits

swt_tmrh = %00000000 ;TxIRQ=Mask,RTS=Hi
swt_torl = %00000100 ;TxIRQ=On  ,RTS=Lo
swt_tmrl = %00001000 ;TxIRQ=Mask,RTS=Lo
swt_tbrk = %00001100 ;TxIRQ=Mask,RTS=Lo
                     ;And... Tx BRK ??

;Parity Mode Bits

swp_odd  = %00000000 ;R-Odd  Parity 0<<6
swp_evn  = %01000000 ;R-Even Parity 1<<6
swp_mrk  = %10000000 ;X-Mark Parity 2<<6
swp_spc  = %11000000 ;X-Spc  Parity 3<<6

;--- Control Bits --------

;swx_br0 = %00000001 ;Baud Rate 0
;swx_br1 = %00000010 ;Baud Rate 1
;swx_br2 = %00000100 ;Baud Rate 2
;swx_br3 = %00001000 ;Baud Rate 3

swx_brc  = %00010000 ;Baud Rate Clocked

;swx_wl0 = %00100000 ;Word Length 0
;swx_wl1 = %01000000 ;Word Length 1

swx_stp  = %10000000 ;Lo = 1 Stop Bit
                     ;Hi = 2 Stop Bits

;Baud Rate Values (2x Crystal Speed)

                ;brc_ from /s/:nhd.t
swb_100  = $01
swb_150  = $02
swb_220  = $03
swb_270  = $04
swb_300  = $05  ;brc_3
swb_600  = $06
swb_1200 = $07  ;brc_12
swb_2400 = $08  ;brc_24
swb_3600 = $09
swb_4800 = $0a  ;brc_48
swb_7200 = $0b
swb_9600 = $0c  ;brc_96
swb14400 = $0d  ;brc_144
swb19200 = $0e  ;brc_192
swb38400 = $0f  ;brc_384

;Word length padding, left-shifted 5x.

swx_w8b  = %00000000 ;Word Length: 8-bit
swx_w7b  = %00100000 ;Word Length: 7-bit
swx_w6b  = %01000000 ;Word Length: 6-bit
swx_w5b  = %01100000 ;Word Length: 5-bit

;--- NMI Control ---------

swn_rxtx = $b6 ;Rx{SHIFT--}Tx Ready NMIs (both)
swn_rx   = $bd ;Rx    Ready NMIs (only)

;--- Buffer Control ------

tbuf_cnt = $ab ;Tx Buffer byte count
rbuf_cnt = $b4 ;Rx Buffer byte count