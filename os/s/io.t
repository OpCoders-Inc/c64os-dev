;----[ io.t ]---------------------------

stack    = $0100 ;$01ff

scrbuf   = $0400 ;$07ff

;RAM mapped
charset  = $d000 ;$d7ff
colbuf   = $d800 ;$dbe7
scrmem   = $dc00 ;$dfe8
bmapmem  = $e000 ;$ff3f

;I/O mapped
vic      = $d000 ;$d3ff
sid      = $d400 ;$d7ff
colmem   = $d800 ;$dbe7
cia1     = $dc00 ;$dcff
cia2     = $dd00 ;$ddff






