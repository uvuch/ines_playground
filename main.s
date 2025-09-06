.include "nes_header.s"

.segment "VECTORS"
    .word irq
    .word reset
    .word nmi

.segment "CODE"
start:
    jmp start

irq:
    rti

reset:
    rti

nmi:
    rti


.segment "CHRROM"

