;----[ nhd.t ]--------------------------

;Constants for Network Hardware Drivers.

;SSID/Wifi Join Struct

;A pointer to this struct is sent to
;ssidstat routine of nhd.* drivers.

wifi_ssid = 0 ;2 bytes
wifi_pass = 2 ;2 bytes

;TCP/IP Socket Struct

;A pointer to this struct is sent to
;opensock routine of nhd.* drivers.

tcp_host = 0  ;2 bytes
tcp_port = 2  ;2 bytes

;Baud Rate Codes

brc_3    = 0  ;   300
brc_12   = 1  ;  1200
brc_24   = 2  ;  2400 ;UP24 Maximum

brc_48   = 3  ;  4800
brc_96   = 4  ;  9600 ;UP96 Driver

brc_144  = 5  ; 14400
brc_192  = 6  ; 19200
brc_384  = 7  ; 38400 ;SwiftLink Maximum

brc_576  = 8  ; 57600
brc_115  = 9  ;115200
brc_230  = 10 ;230400 ;Turbo232 Maximum