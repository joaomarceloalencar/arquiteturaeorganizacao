;
;   Building Instructions:
;   ml /Cx /coff CompleteProgram.asm /link /SUBSYSTEM:console /out:CompleteProgram.exe kernel32.lib legacy_stdio_definitions.lib msvcrt.lib
;
        .686
        .model  flat, c
        .stack  100h
printf  PROTO   arg1:Ptr Byte, printlist:VARARG
scanf   PROTO   arg2:Ptr Byte, inputlist:VARARG
        .data
in1fmt  byte    "%d",0
msg1fmt byte    0Ah, "%s", 0
msg2fmt byte    "%s",0
msg3fmt byte    0Ah, "%s%d", 0Ah, 0Ah,0
msg1    byte    "Enter the number of volts: ",0
msg2    byte    "Enter the number of ohms: ",0
msg3    byte    "The number of amperes is: ",0
volts   sdword  ? ; number of volts
ohms    sdword  ? ; number of ohms
amperes sdword  ? ; number of amperes
        .code
main    proc
        INVOKE  printf, ADDR msg1fmt, ADDR msg1
        INVOKE  scanf, ADDR in1fmt, ADDR volts
        INVOKE  printf, ADDR msg2fmt, ADDR msg2
        INVOKE  scanf, ADDR in1fmt, ADDR ohms
        ; amperes = volts / ohms
        mov     eax,volts   ; load volts into eax
        cdq                 ; extend the sign bit
        idiv    ohms        ; divide eax by ohms
        mov     amperes,eax ; store eax in amperes
        INVOKE  printf, ADDR msg3fmt, ADDR msg3, amperes
        ret
main    endp
        end
