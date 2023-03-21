;
;   Building Instructions:
;   ml /Cx /coff ReadNumber.asm /link /SUBSYSTEM:console /out:ReadNumber.exe kernel32.lib legacy_stdio_definitions.lib msvcrt.lib
;
        .686
        .model  flat, c 
        .stack  100h
printf  PROTO arg1:Ptr Byte, printlist:VARARG 
scanf   PROTO arg2:Ptr Byte, inputlist:VARARG
        .data
in1fmt  byte    "%d", 0
msg1fmt byte    0Ah,"%s%d",0Ah,0Ah,0
msg1    byte    "The number is: ",0
number  sdword  ?
        .code
main    proc
        INVOKE scanf, ADDR in1fmt, ADDR number
        INVOKE printf, ADDR msg1fmt, ADDR msg1, number
        ret 
main    endp
end