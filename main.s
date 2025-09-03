.segment "HEADER"
    .byte "NES", $1A
    .byte 0,0,0,0
    .byte 0,0,0,0
    .byte 0,0,0,1

.segment "CODE"
start:
    jmp start

.segment "CHRROM"
    .byte 1