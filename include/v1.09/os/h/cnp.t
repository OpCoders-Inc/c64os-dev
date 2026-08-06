;----[ cnp.t for cnp.lib.r ]------------

;Commodore Network Protocol library

;link_   = $00
;  Initializes cnp.lib

;unlink  = $03
;  Unsets itself as nhd data handler

bindnhd_ = $06
;  Updates nhd link table from ndrvpg

sessbgn_ = $09
;  Begin CNP server session. Take ctrl
;  of an open socket. Send auth.
;  Assigns itself as nhd data handler.
;  RegPtr -> CNP Auth Struct
;  C <- Set on Error
;    A <- 0 = ns_cpup already set
;    A <- 1 = No Carrier

sessend_ = $0c
;  End CNP server session
;  Pauses the keep alive timer.
;  C -> Set = Notify that socket closed
;  C -> Clr = Send service msg to close

;---------------------------------------

opencnps_ = $0f
;  Open CNP Socket
;  RegPtr -> CNP Socket Struct
;  C <- Set = No free socket slot

closcnps_ = $12
;  Close CNP Socket
;  RegPtr -> CNP Socket Struct
;  C <- Clr = close packet sent

cnpsout_ = $15
;  Prepare CNP Socket for output
;  Equiv. of chkout in KERNAL ROM
;  RegPtr -> CNP Socket Struct
;  Raises exceptions.

cnpsput_ = $18
;  Output a byte to CNP Socket
;  Equiv. of chrout in KERNAL ROM
;  A -> byte to send
;  C <- Set = can take more data
;  C <- Clr = current packet full
;  Raises exceptions.

cnpsclr_ = $1b
;  Clear to send packet.
;  The socket is still open, but no more
;  data will be written at this time.
;  Whatever is in the current packet can
;  be sent immediately.
;  Raises exceptions.

cnpsin_  = $1e
;  Prepare CNP Socket for input
;  Equiv. of chkin in KERNAL ROM
;  This must only be called in response
;  to a socket notification that new
;  data has arrived.
;  RegPtr -> CNP Socket Struct

cnpsget_ = $21
;  Read a byte from the current receive
;  packet. Requires cnpsin_ first.
;  A <- next byte in packet
;  C <- Set = when A holds last byte.

cnpsack_ = $24
;  Acknowledge that reading the packet
;  is complete. Sends a pt_ack packet.
;  Allows the CNP server to send the
;  next packet.

cnpspas_ = $27
;  Acknowledge that reading the packet
;  is complete. Sends a pt_pause packet.
;  Tells the CNP server to hold before
;  sending the next packet.

cnpsres_ = $2a
;  Resumes the socket. Sends a pt_resum
;  packet. Tells the CNP server that it
;  can send the next packet.