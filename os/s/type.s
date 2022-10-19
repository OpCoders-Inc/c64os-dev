;----[ type.s ]-------------------------

;C64 OS data types

;Like MIME types, each C64 OS data type
;has a type and subtype, 1 byte each.
;Subtype is unique per type.

ct_text  = 0

ct_pettxt = 0
ct_asctxt = 1
ct_mtext = 2
ct_email = 3
ct_weburl = 4
ct_date  = 5
ct_dattim = 6
ct_fref  = 7
;ct_???   = 8
ct_number = 9
ct_tel   = 10
ct_cal   = 11
ct_html  = 12
ct_xml   = 13

ct_appl  = 1

ct_zip   = 0
ct_float = 1
ct_base64 = 2
ct_gzip  = 3
ct_uuenc = 4

ct_audio = 2

ct_raw   = 0
ct_aiff  = 1
ct_wave  = 2
ct_sid   = 3
ct_mod   = 4
ct_mp3   = 5
ct_midi  = 6
ct_snd   = 7

ct_image = 3

ct_multc = 0
ct_hires = 1
ct_koala = 2
ct_arts  = 3
ct_jpeg  = 4
ct_gif   = 5
ct_4bit  = 6
ct_3icon = 7

ct_video = 4

ct_hdx   = 0

