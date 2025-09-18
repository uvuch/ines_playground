PPUCTRL   = $2000
PPUMASK   = $2001
PPUSTATUS = $2002

PPUSCROLL = $2005
PPUADDR   = $2006
PPUDATA   = $2007

OAMADDR   = $2003
OAMDATA   = $2004
OAMDMA    = $4014

; PPUCTRL flags
VBLANK_ON   = %10000000
VBLANK_OFF  = %00000000
SPRITE_H8   = %00000000
SPRITE_H16  = %00100000
BG_TBL0     = %00000000
BG_TBL1     = %00010000
SPRITE_TBL0 = %00000000
SPRITE_TBL1 = %00001000
VRAM_INCCOL = %00000000
VRAM_INCROW = %00000100
NAMETBL0    = %00000000     ; 2000
NAMETBL1    = %00000001     ; 2400
NAMETBL2    = %00000010     ; 2800
NAMETBL3    = %00000011     ; 2C00

; PPUMASK flags
E_BLUE_ON    = %10000000
E_BLUE_OFF   = %00000000
E_GREEN_ON   = %01000000
E_GREEN_OFF  = %00000000
E_RED_ON     = %00100000
E_RED_OFF    = %00000000
ENABLE_SPR   = %00010000
DISABLE_SPR  = %00000000
ENABLE_BG    = %00001000
DISABLE_BG   = %00000000
SPR_LEFT8_ON  = %00000100
SPR_LEFT8_OFF = %00000000
BG_LEFT8_ON   = %00000010
BG_LEFT8_OFF  = %00000000
GREYSCALE_ON  = %00000001
GREYSCALE_OFF = %00000000

.import __OAM_LOAD__

.macro ppu_init
    ; -------- 1. Wait til PPU accepts writes to registers. --------------------------------------------------------------------------
    ; PPU ignores writes to registers PPUCTRL, PPUMASK, PPUSCROLL and PPUADDR until reaching the pre-render scanline of the next frame.
    ; More specifically, for around 29658 NTSC CPU cycles or 33132 PAL CPU cycles.
    ; So, I have to wait for a frame or two before I can start writing to the mentioned registers.
    bit PPUSTATUS   ; clear the VBL flag if it was set at reset time
:   bit PPUSTATUS
    bpl :-          ; at this point, less than 27385 cycles have passed
:   bit PPUSTATUS
    bpl :-          ; at this point, about another 29781 cycles have passed

    ; -------- 2. Turn off rendering ------------------------------------------------------------------------------------------------
    lda #0           
    sta PPUCTRL     ; vblank off
    sta PPUMASK     ; disable sprites and background rendering

    ; ---------3. Turn off scrolling ------------------------------------------------------------------------------------------------
    sta PPUSCROLL   ; first write sets X scrolling
    sta PPUSCROLL   ; second write sets Y scrolling

    ; -------- 4. Clear OAM ---------------------------------------------------------------------------------------------------------
    lda #0
    tax
:   dex
    sta __OAM_LOAD__, x
    bne :-
    lda #02
    sta OAMDMA      ; DMA copy of OAM from mem to PPU OAM area

.endmacro