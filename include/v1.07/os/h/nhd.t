;----[ nhd.t for nhd.* drivers ]--------

;link_ = $00
;  Initialize Network Hardware Driver
;  Allocates 2 buffer pages
;  Backs up and wedges the NMI vector

;unlink_ = $03
;  Deallocates buffer pages
;  Restores original NMI vector

sethand_ = $06
;  Configure incoming data handlers
;  C -> Clr = Command Mode
;  C -> Set = Carrier Detect Mode
;  RegPtr -> Handler routine ptr
;
;  C <- Clr = Command Mode (no carrier)
;  C <- Set = Carrier Detected

pollget_ = $09
;  Poll incoming buffer for data
;  If data is in the Rx buffer:
;    - Checks carrier detect signal
;    - Calls appropriate handler

dataget_ = $0c
;  Fetch a byte from Rx buffer
;  C <- Set = buffer is empty
;  A <- Same as it came in
;
;  C <- Clr = .A got a byte
;  A <- byte from Rx buffer

dataput_ = $0f
;  Put a byte in Tx buffer
;  A -> byte to transmit

;---------------------------------------
;Auxilliary Routines

;TODO: figure this out.
;(not all nhd.* drivers have the same)

;nhd.up24.zi

setrate_ = $12
;  Set baud rate
;  A -> baud rate code
;       0 =  300 baud
;       1 = 1200 baud
;       2 = 2400 baud
;  C -> Clr = Set driver speed only
;  C -> Set = Send "atb" command first

ssidstat_ = $15
;  Read or Join SSID
;  C -> Clr = Read current SSID
;  C -> Set = Join SSID
;  RegPtr -> SSID Join Struct

opensock_ = $18
;  Open a TCP/IP Socket
;  RegPtr -> Socket Struct
;  C -> Clr = Open Socket
;  C -> Set = Close Socket (hang up)

nhdpause_ = $1b
;  Pause RS-232 NMI handling, or equiv.

nhdresum_ = $1e
;  Resume RS-232 NMI handling, or equiv.
;  C <- Clr = Command Mode (offline)
;  C <- Set = Data Mode    (online)