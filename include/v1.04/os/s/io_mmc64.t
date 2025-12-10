;----[ io_mmc64.t ]---------------------

;MMC64 uses Serial Peripheral Interface
;(SPI) for communications with MMC and
;SD Cards, and also with an RTC chip.

;MMC64 Registers

mmc_spi  = $df10 ;SPI  transfer register
mmc_ctl  = $df11 ;MMC64 control register
mmc_sta  = $df12 ;MMC64  status register
mmc_idy  = $df13 ;MMC64  ident. register


;MMC64 Identity Register Values

;Read if MMC64 is present and enabled.

mmi_card = $64 ;When card selected
mmi_reva = $01 ;Card not selected, Rev.A
mmi_revb = $02 ;Card not selected, Rev.B

;Write mmi_unl1 then write mmi_unl2 to
;unlock. Then write mcr_dact to mmc_ctl
;to disable MMC64 without unplugging it.

mmi_unl1 = %01010101 ;Unlock Stage 1
mmi_unl2 = %10101010 ;Unlock Stage 2

;When MMC64 has been disabled, write
;mmi_ena1 then write mmi_ena2 to mmc_idy

mmi_ena1 = %00001010 ;Enable Stage 1
mmi_ena2 = %00011100 ;Enable Stage 2


;MMC64 Control Register Bits

;First read the mmc_ctl register.
;Then flip one of the bits.
;Write result back to mmc_ctl register.

mcr_dact = %10000000

;ora #mcr_dact     ;Deactivate MMC64
;and #mcr_dact:$ff ;Activate   MMC64

mcr_trgr = %01000000

;ora #mcr_trgr     ;Trigger on Read
;and #mcr_trgr:$ff ;Trigger on Write

mcr_dxrm = %00100000

;ora #mcr_dxrm     ;Disable EX ROM
;and #mcr_dxrm:$ff ;Enable  EX ROM

mcr_flmd = %00010000

;ora #mcr_flmd     ;Flash Update Mode
;and #mcr_flmd:$ff ;Normal Mode

mcr_fast = %00000100

;ora #mcr_fast     ;  8MHz Clock Speed
;and #mcr_fast:$ff ;250KHz Clock Speed

mcr_ncrd = %00000010

;ora #mcr_ncrd     ;Card Not Selected
;and #mcr_ncrd:$ff ;Card Selected

mcr_dbio = %00000001

;ora #mcr_dbio     ;Disable BIOS ROM
;ora #mcr_dbio:$ff ;Enable  BIOS ROM


;Accessing the RTC

mcr_rtc  = mcr_flmd.mcr_ncrd.mcr_dbio

;ora #mcr_rtc      ;Access the RTC
;and #mcr_fast:$ff ;RTC needs 250KHz Clk


;MMC64 Status Register Bits (Read-Only)

msr_wrtp = %00010000 ;MMC Write Protect
msr_ncrd = %00001000 ;No Card Present
msr_busy = %00000001 ;Busy wait state


;The PFC2123 is an SPI RTC clock chip
;built into the MMC64 cartridge.


;PFC2123 Registers

pfc_ct1  = $00 ;Control 1
pfc_ct2  = $01 ;Control 2

pfc_secs = $02 ;Seconds
pfc_mins = $03 ;Minutes
pfc_hour = $04 ;Hours

pfc_date = $05 ;Date of Month
pfc_dow  = $06 ;Day of Week ($00 = Sun.)
pfc_mnth = $07 ;Month       ($01 = Jan.)
pfc_year = $08 ;Year        (No Century)


;PFC2123 Command Bits

pfc_read = %10000000

;ora #%pfc_read     ;Read Mode
;and #%pfc_read:$ff ;Write Mode

pfc_suba = %00010000

;ora #%pfc_suba     ;Command SubAddress

;If the SubAddress bit is not set in the
;command, the data transfer is ignored.