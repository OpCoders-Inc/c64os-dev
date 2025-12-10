;----[ io_rs232.t ]---------------------

;cia2     = $dd00 ;TEMP

;Workspace memory addresses for
;RS-232 buffers and state.

ystash   = $97 ;Temp conserve Y reg

;--- Buffer Management ---

ribuf    = $f7;$f8 ;Input  Buf Ptr
robuf    = $f9;$fa ;Output Buf Ptr

ridbe    = $029b ;Input buf end   index
ridbs    = $029c ;Input buf start index

rodbe    = $029d ;Output buf end   index
rodbs    = $029e ;Output buf start index

;--- NMI Control ---------

txtmrlo  = cia2+$04 ;Tx Timer (A) Lo
txtmrhi  = cia2+$05 ;Tx Timer (A) Hi

rxtmrlo  = cia2+$06 ;Rx Timer (B) Lo
rxtmrhi  = cia2+$07 ;Rx Timer (B) Hi

cia_icr  = cia2+$0d ;Interrupt  Ctrl Reg
cia_txcr = cia2+$0e ;Tx Timer A Ctrl Reg
cia_rxcr = cia2+$0f ;Rx Timer B Ctrl Reg

nmictrl  = $02a1    ;ICR mask (enabl)

;--- RS-232 Lines --------

rs232out = cia2+$00 ;Port A
rs232in  = cia2+$01 ;Port B
rs232sig = cia2+$01 ;Port B

rs232rx  = %00000001 ;Rx Data (rs232in)
rs232tx  = %00000100 ;Tx Data (rs232out)

;The following bits are I/O
;signals available on rs232sig.

;Hardware handshaking is done with:
; - rs232rtr, when the C64   can receive
; - rs232cts, when the Modem can receive

rs232rtr = %00000010 ;Ready to Recv  out
rs232ri  = %00001000 ;Ring Indicator in
rs232dcd = %00010000 ;Carrier Detect in
rs232cts = %01000000 ;Clear to Send  in
rs232dsr = %10000000 ;Data Set Ready in

rsbyte   = $9e ;Current in{SHIFT--}out byte

rxbitcnt = $bd ;Rx Bit Count
rxbyte   = $ab ;Rx Input Byte Buffer

txbitcnt = $b4 ;Tx Bit Count
txnxtbit = $b5 ;Tx Next Bit
txbyte   = $b6 ;Tx Output Byte Buffer