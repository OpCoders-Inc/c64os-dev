;----[ cnp.t ]--------------------------

;Constants for cnp.lib
;Commodore Network Protocol Library

;CNP Auth Struct

;A pointer to this struct is sent to
;openauth routine of cnp.lib

cnp_user = 0 ;2 bytes
cnp_pass = 2 ;2 bytes


;CNP Socket Struct

;A pointer to this struct is sent to
;cnp socket handling routines

csk_name = 0  ;2 bytes ;host name string
csk_stat = 2  ;2 bytes ;status callback
csk_flgs = 4  ;1 byte  ;status flags

csk_tsiz = 5  ;1 byte  ;Tx Data Size
csk_tsum = 6  ;1 byte  ;Tx Data Checksum
csk_tbuf = 7  ;1 byte  ;Tx Data Buffer

csk_rsiz = 8  ;1 byte  ;Rx Data Size
csk_rsum = 9  ;1 byte  ;Rx Data Checksum
csk_rbuf = 10 ;1 byte  ;Rx Data Buffer

csk_size = 11 ;CNP Socket Struct Size

;CNP Socket Flags

csf_opng = %00000001 ;Opening
csf_clng = %00000010 ;Closing
csf_txng = %00000100 ;Transmitting
csf_open = %10000000 ;Socket is open

;CNP Socket State Change Notifications

csc_open = 0 ;Socket Opened
csc_fail = 1 ;Socket Unable to Open
csc_clos = 2 ;Socket Closed
csc_time = 3 ;Socket Timedout
csc_data = 4 ;Socket has data to read
csc_tclr = 5 ;Socket clear to transmit

;CNP Packet Struct

cp_type  = 0 ;1 Packet Type
cp_port  = 1 ;1 App Bank,Socket Index
cp_dsiz  = 2 ;1 Data Size (w/out header)
cp_csum  = 3 ;1 XOR data checksum

cp_data  = 4 ;0-255 bytes

;CNP Packet Types

pt_alive = "-" ;CNP Service Keep Alive
pt_serv  = "s" ;CNP Service Packet

pt_open  = "o" ;Socket Open  Request
pt_close = "c" ;Socket Close Request
pt_time  = "t" ;Socket Timed Out

pt_ack   = "a" ;Acknowledgement
pt_nak   = "n" ;Negative Acknowledgement

pt_data  = "d" ;Data Carrier


;Packet Sizes by Type:

;pt_alive
;
;  Header    1 byte
;  Body      0 bytes

;pt_open
;pt_serv
;pt_data
;
;  Header    4 bytes
;  Body      x bytes

;pt_close
;pt_time
;pt_ack
;pt_nak
;
;  Header    2 bytes
;  Body      0 bytes