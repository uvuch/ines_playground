.segment "HEADER"
    ; https://www.nesdev.org/wiki/INES#iNES_file_format
    MAPPER    = 0   ; 0 - NROM mapper
    MIRROR    = 1   ; 0 - vertical arrangement ("horizontal mirrored")
                    ; 1 -horizontal arrangement ("vertically mirrored") 
    BATT_RAM  = 0   ; 1 -Cartridge contains battery-backed PRG RAM ($6000-7FFF) or other persistent memory
    TRAINER   = 0   ; 1 -512-byte trainer at $7000-$71FF (stored before PRG data)
    NT_LAYOUT = 0   ; 1: Alternative nametable layout

    ; https://www.nesdev.org/wiki/INES#Flags_6
    FLAGS6 = MIRROR | (BATT_RAM << 1) | (TRAINER << 2) | (NT_LAYOUT << 3) | ((MAPPER & $0F) << 4)
    ; https://www.nesdev.org/wiki/INES#Flags_7
    FLAGS7 = (MAPPER & $F0)
    
    FLAGS8  = 0 ; PRG-RAM size (rarely used extension) 
    FLAGS9  = 0 ; TV system (rarely used extension) 

    TV_SYSTEM = 0       ; TV system (0: NTSC; 2: PAL; 1/3: dual compatible)
    FLAGS10 = TV_SYSTEM ; TV system, PRG-RAM presence (unofficial, rarely used extension) 

    .byte "NES", $1A
    .byte 2         ; Size of PRG ROM in 16 KB units 
    .byte 1         ; Size of CHR ROM in 8 KB units (value 0 means the board uses CHR RAM) 
    .byte FLAGS6    ; Mapper, mirroring, battery, trainer, https://www.nesdev.org/wiki/INES#Flags_6
    .byte FLAGS7    ; Mapper, VS/Playchoice, NES 2.0, https://www.nesdev.org/wiki/INES#Flags_7
    .byte FLAGS8
    .byte FLAGS9
    .byte FLAGS10
    .byte 0
    .byte 0,0,0,0
