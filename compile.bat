@echo Compiling...
ca65 -g main.s -o main.o -l main.l

@if ERRORLEVEL 1  (
    @echo Compilation failed!
    exit
)

@echo Linking...
ld65 main.o -C memory.cfg -o ines_playground.nes

@if ERRORLEVEL 1  (
    @echo Linking failed!
    exit
)

@echo Build is finished!
