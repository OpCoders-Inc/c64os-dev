;----[ io_i2c.t for i2c.lib.r ]---------

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