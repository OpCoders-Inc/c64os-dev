;----[ io_i2c.s ]-----------------------

;Header for i2c.lib.r

;Init called automatically by loadreloc

;init_   = 0

reset_   = 3
;  Takes no parameters.
;  Resets the I2C Bus.

prep_rw_ = 6
;  Regptr -> Pointer to memory buffer
;  A      -> Read/Write data length
;            (maximum 256 bytes)

;prep_rw must be called before a call to
;either readreg or writreg.

readreg_ = 9
;  Initialize with i2c_prep_rw
;  A -> i2c device address
;  Y -> device register
;  C -> Set = skip register write
;  A <- ok/nok response 0 = ok
;
;Register contents will be read from
;i2c device and copied to memory buffer.

writreg_ = 12
;  Initialize with i2c_prep_rw
;  A -> i2c device address
;  Y -> device register
;  A <- ok/nok response 0 = ok
;
;Contents of memory buffer will be
;written to the i2c device's register(s)

;---------------------------------------

slvwait  = 50 ;wait time for slave
              ;to ack the address

datareg  = $dd01 ;CIA 2 PortB
datadir  = $dd03 ;1 = output, 0 = input

;response codes
ret_ok   = 0 ;Not an error
ret_nok  = 1

err_sdalo = 2
err_scllo = 3

;i2c address flags
writebit = 0    ;in i2c address byte
readbit  = 1    ;in i2c address byte
purebyte = $ff  ;don't modify data byte

