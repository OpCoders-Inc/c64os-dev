;----[ network.t for network.lib.r ]----

;Network Control Library
;-----------------------
;
;- Loads cnp.lib (C= Network Protocol)
;- Loads driver settings
;- Loads nhd.* driver
;- Configs network.lib as command
;  mode data handler for driver.
;
;- Tells driver how to adjust baud rate
;- Tells driver which wifi to join
;- Tells driver to open a socket to
;  CNP server.
;- Passes online mode data handling to
;  cnp.lib, with auth credentials.

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
;    0 = Carrier Detected
;    1 = Baud Match Test Failed
;
;  Driver settings must be populated.
;  Either by: loadset or Network Utility

joinwifi_ = $12
;  Join or Read Wifi Hotspot
;  RegPtr -> Next stage callback
;  C -> Clr = Read SSID
;  C <- Always clear
;
;  C -> Set = Join Hotspot
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
;  RegPtr -> Next stage callback
;  C -> Set = Part from CNP Server
;  C -> Clr = Join CNP Server
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