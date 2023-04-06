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
msg1fmt byte    "%s",0
msg2fmt byte    0Ah,"%s",0Ah,0
msg4fmt byte    "%s",0Ah,0
msg6fmt byte    0Ah,0
msg1    byte    "Enter an AC voltage: ",0
msg2    byte    "Voltage is Acceptable",0
msg3    byte    "Warning!",0
msg4    byte    "Voltage too Low",0
msg5    byte    "Voltage too High",0
voltage sdword  ? 
        .code
main    proc
        INVOKE printf, ADDR msg1fmt, ADDR msg1
        INVOKE scanf, ADDR in1fmt, ADDR voltage
        .if voltage >= 110 && voltage <= 120
        INVOKE printf, ADDR msg2fmt, ADDR msg2
        .else
        INVOKE printf, ADDR msg2fmt, ADDR msg3
        .if voltage < 110
        INVOKE printf, ADDR msg4fmt, ADDR msg4
        .else
        INVOKE printf, ADDR msg4fmt, ADDR msg5
        .endif
        .endif
        INVOKE printf, ADDR msg6fmt
        ret
main    endp
        end
