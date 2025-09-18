.import __OAM_LOAD__

.include "nes_header.s"
.include "ppu.s"

.segment "ZP"
.segment "OAM"

.segment "VECTORS"
    .word irq
    .word reset
    .word nmi

.segment "CODE"
reset:
    cld
    ldx #$FF    ; initialize stack pointer
    txs

    ; 1. Clear nametables (fill with tile #0)
    ; 2. Set pallette

    ppu_init
start:
    jmp start

irq:
    rti

nmi:
    rti


.segment "CHRROM"

