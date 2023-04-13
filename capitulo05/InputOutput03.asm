;
;   Building Instructions:
;   ml /Cx /coff InputOutput03.asm /link /SUBSYSTEM:console /out:InputOutput03.exe kernel32.lib legacy_stdio_definitions.lib msvcrt.lib
;
        .686
        .model  flat, c
        .stack  100h
printf  PROTO   arg1:Ptr Byte, printlist:VARARG
scanf   PROTO   arg2:Ptr Byte, inputlist:VARARG
        .data
msg1fmt byte    "%s",0
msg2fmt byte    0Ah,"%s%d",0Ah,0Ah,0
in1fmt  byte    "%d",0
msg1    byte    "Enter an integer or a negative integer to stop: ", 0
msg2    byte    "The sum is ", 0
sum     sdword  ?
num     sdword  ?
count   sdword  ?
        .code
main    proc
        mov sum, 0
        INVOKE printf, ADDR msg1fmt, ADDR msg1
        INVOKE scanf, ADDR in1fmt, ADDR count
        mov ecx, 1
        .while num >= 0
        mov eax, sum
        add eax, num
        mov sum, eax
        INVOKE printf, ADDR msg1fmt, ADDR msg1
        INVOKE scanf, ADDR in1fmt, ADDR num
        .endw
        INVOKE printf, ADDR msg2fmt, ADDR msg2, sum
main    endp
        end