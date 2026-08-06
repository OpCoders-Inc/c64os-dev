;----[ io_sid.t ]-----------------------

;Sound Interface Device (SID)

;sid is defined by io.s

;sid     = $d400 ;SID base address

voice1   = $00
voice2   = $07
voice3   = $0e

sid_freq = $00 ;.word Frequency
sid_puls = $02 ;.word Pulse Width
sid_ctrl = $04 ;.byte Control
sid_adsr = $05 ;.word Atk/Dec/Sus/Rel

sid_filt = $15 ;.word Filter
sid_resf = $17 ;.byte Resonance/Filter
sid_vlmd = $18 ;.byte Volume/Mode