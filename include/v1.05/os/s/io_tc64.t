;----[ io_tc64.t ]----------------------

;Turbo Chameleon has a set of registers
;for configuration,detection,modes,etc.


;Turbo Chameleon Config Registers

tcc_crt  = $d0f0 ;Config Cartridge Emul.
tcc_spi  = $d0f1 ;Clockport, MMC64 Emul.
tcc_vic  = $d0f2 ;VIC-II Emulation.
tcc_tur  = $d0f3 ;Turbo Configuration.
tcc_sid  = $d0f4 ;SID Emulation.
tcc_reu  = $d0f5 ;REU/GEORAM Emulation.
tcc_dwr  = $d0f6 ;Disk Image Write Bits.
tcc_dsk  = $d0f7 ;Disk Images.
tcc_fd0  = $d0f8 ;Drive 0 Emulation.
tcc_fd1  = $d0f9 ;Drive 1 Emulation.
tcc_reg  = $d0fa ;Chameleon Registers.
tcc_btn  = $d0fb ;Debug info and buttons
tcc_gio  = $d0fc ;I/O and IEC Config.
tcc_dis  = $d0fd ;Disable Config Mode.
tcc_ena  = $d0fe ;Enable  Config Mode.


;Turbo Chameleon Config Values

;See: www.syntiac.com/pdf/chameleon_prog
;manual_beta9.pdf
;Complete Register Map, starts Page 42.

;NOTE:
;
;In order to prevent random software
;from accidentally changing TC64 config,
;you have to enable config mode first.
;This enables all the config registers:
;$d0f0 to $d0ff. After changing config,
;play it safe and disable config mode.


;Turbo Chameleon SPI Values

tspi_nmi = %01000000 ;ClockPort NMI Enab
tspi_cdf = %00100000 ;ClockPort $df20-2f
tspi_cde = %00010000 ;ClockPort $de00-0f
tspi_rom = %00001000 ;BAS/KER ROMs used
tspi_mda = %00000100 ;MMC64 Deactivated

tspi_mcr = %00000011 ;MMC64 Emul+RTC+FR
tspi_mce = %00000001 ;MMC64 Emulation

;Turbo Chameleon uses MMC64 emulation
;for access to its RTC chip (PCF2123).


;Turbo Chameleon Conf Enable Values

tena_cnf = %00101010 ;Enter Config Mode
tena_mnu = %00100000 ;Enter Menu   Mode
tena_rst = %10100101 ;Reset Machine
tena_dis = %11111111 ;Exit  Config Mode

;Menu mode and reset can only be used
;after entering config mode first.


;Turbo Chameleon REU Values

treu_r128 = %10000000 ;17xxREU 128K
treu_r256 = %10000001 ;17xxREU 256K
treu_r512 = %10000010 ;17xxREU 512K
treu_r1m = %10000011  ;17xxREU 1MB
treu_r2m = %10000100  ;17xxREU 2MB
treu_r4m = %10000101  ;17xxREU 4MB
treu_r8m = %10000110  ;17xxREU 8MB
treu_r16 = %10000111  ;17xxREU 16MB

treu_g64 = %01000000  ;GEORAM  64K
treu_g128 = %01001000 ;GEORAM  128K
treu_g256 = %01010000 ;GEORAM  256K
treu_g512 = %01011000 ;GEORAM  512K
treu_g1m = %01100000  ;GEORAM  1MB
treu_g2m = %01101000  ;GEORAM  2MB
treu_g4m = %01110000  ;GEORAM  4MB