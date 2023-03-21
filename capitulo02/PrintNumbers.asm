;
;   Building Instructions:
;   ml /Cx /coff PrintNumbers.asm /link /SUBSYSTEM:console /out:PrintNumbers.exe kernel32.lib legacy_stdio_definitions.lib msvcrt.lib
;
        .686
        .model  flat, c 
        .stack  100h
printf  PROTO arg1:Ptr Byte, printlist:VARARG 
        .data
msg1fmt byte    0Ah,"%d%s%d",0Ah,0Ah,0
msg1    byte    " is not equal to ",0
num1    sdword  5
num2    sdword  7
        .code
main    proc
        INVOKE printf, ADDR msg1fmt, num1, ADDR msg1, num2
        ret 
main    endp
end