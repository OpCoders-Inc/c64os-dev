;----[ network.t for network.lib ]------

ndrvpg   = $0804
cnplibpg = $0244

nettimer = $02 ;Network Delay Timer

netstat  = $0245

;--- Network Statuses ------

ns_nhcf  = %00000001 ;NHD Configured
ns_nhsp  = %00000010 ;NHD Speed Set
ns_trcf  = %00000100 ;Transport Conf'd
ns_trup  = %00001000 ;Transport Conn'd
ns_cpcf  = %00010000 ;CNP Configured
ns_cpup  = %00100000 ;CNP Connected

ns_onlin = %00111111 ;All the above set

;ns_nhcf - The network hardware driver
;          is loaded and able to find
;          the hardware that it drives.

;ns_nhsp - The hardware's speed and
;          other parameters have been
;          initialized.

;ns_trcf - The transport layer is conf-
;          igured. I.e., a wifi SSID and
;          password are set up.

;ns_trup - The transport layer is up.
;          I.e., a wifi hotspot has been
;          joined and connected.

;ns_cpcf - A CNP server has been conf-
;          igured with address and auth-
;          entication credentials.

;ns_cpup - Connection to the CNP server
;          is up and running. CNPSockets
;          can be opened and used.

;ns_onlin - A constant equal to all of
;           the above flags being set.

;--- Settings Properties ---

;Driver Settings
nhdpgsz  = 0   ;"1" -> "5" = 1 ->  5
inibaud  = 1   ;"a" -> "k" = 0 -> 10
maxbaud  = 2   ;"a" -> "k" = 0 -> 10

nhddrvr  = 3   ;String Max. 16

;Wifi Settings
wifinam  = 4   ;String Max. 32
wifipas  = 5   ;String Max. 32

;Commodore Network Protocol
cnphost  = 6   ;String Max. 20
cnpport  = 7   ;String Max.  5
cnpuser  = 8   ;String Max. 16
cnppass  = 9   ;String Max. 16