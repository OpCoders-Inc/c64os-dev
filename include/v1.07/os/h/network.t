;----[ network.t for network.lib.r ]----

;link_   = $00
;  Initializes network.lib
;  Loads cnp.lib
;  Attempts full connection including
;    installing nhd.* driver
;  Opens Network Utility on failure.

;unlink  = $03
;  Unloads cnp.lib
;  Unintalls nhd.* driver

loadset_ = $06
;  Load settings from
;  os/settings/:network.t
;  C <- Set on error (file not found)

readset_ = $09
;  Fetch pointer to settings buffer
;  X -> settings index
;       (see: os/s/:network.t)
;  RegPtr <- buffer of requested setting

loadnhd_ = $0c
;  Load network hardware driver.
;  Uninstalls any previous driver.
;  C <- Set on error (driver not found)
;
;  Driver settings must be populated.
;  Either by: loadset or Network Utility

confbaud_ = $0f
;  Configure device and driver to step
;  up from initial to maximum baud rate.
;
;  C <- Set on error
;  A <- Error code
;
;  Driver settings must be populated.
;  Either by: loadset or Network Utility

joinwifi_ = $12
;  Join or Read Wifi Hotspot
;  C -> Clr = Read SSID
;  C <- Always clear
;
;  C -> Set = Join Hotspot
;  RegPtr -> Success callback
;  C <- Set on error
;    A <- 0 = Carrier Detect
;    A <- 1 = Not Configured
;
;  Wifi settings must be populated.
;  Either by: loadset or Network Utility
;
;     Callback
;       A <- response code
;       RegPtr <- response buffer
;                 (with SSID in it)

cnpsrvr_ = $15
;  Join/Part CNP server
;  C -> Set = Part from CNP Server
;
;  C -> Clr = Join CNP Server
;  RegPtr -> Success callback
;  C <- Set on error
;    A <- 0 = Carrier Detect
;    A <- 1 = Not Configured
;
;  CNP settings must be populated.
;  Either by: loadset or Network Utility
;
;     Callback
;       A <- response code

cnpctrl_ = $18
;  Transfer control to CNP.lib
;  C -> Set = Network.lib handles
;             disconnect state.
;  C -> Clr = Specify disconnect
;  RegPtr -> disconnect handler