;----[ io_i2c.t for i2c.lib.r ]---------


slvwait  = 50 ;wait time for slave
              ;to ack the address

ciareg   = $dd01 ;CIA 2 PortB
ciadir   = $dd03 ;1 = output, 0 = input

procreg  = $01   ;6510 Port
procdir  = $00   ;1 = output, 0 = input

;These two constants are now
;conditionally defined in i2c.lib.a
;as either ciareg/dir or procreg/dir.

;datareg
;datadir

;response codes
ret_ok   = 0 ;Not an error
ret_nok  = 1

err_sdalo = 2
err_scllo = 3

;i2c address flags
writebit = 0    ;in i2c address byte
readbit  = 1    ;in i2c address byte
purebyte = $ff  ;don't modify data byte