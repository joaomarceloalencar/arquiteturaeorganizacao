;
;   Building Instructions:
;   ml /Cx /coff InputOutput01.asm /link /SUBSYSTEM:console /out:InputOutput01.exe kernel32.lib legacy_stdio_definitions.lib msvcrt.lib
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
msg1    byte    "Enter an integer: ", 0
msg2    byte    "The sum is ", 0
sum     sdword  ?
num     sdword  ?
temp    sdword  ?
        .code
main    proc
        mov sum, 0
        mov ecx, 10
        .repeat
        mov temp, ecx
        INVOKE printf, ADDR msg1fmt, ADDR msg1
        INVOKE scanf, ADDR in1fmt, ADDR num
        mov eax, sum
        add eax, num
        mov sum, eax
        mov ecx, temp
        .untilcxz
        INVOKE printf, ADDR msg2fmt, ADDR msg2, sum
main    endp
        end