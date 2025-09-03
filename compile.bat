@echo Compiling...
ca65 main.s -o main.o

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
