;
;   Building Instructions:
;   ml /Cx /coff NumbersComplete.asm /link /SUBSYSTEM:console /out:NumbersComplete.exe kernel32.lib legacy_stdio_definitions.lib msvcrt.lib
;
        .686
        .model  flat, c 
        .stack  100h
printf  PROTO arg1:Ptr Byte, printlist:VARARG 
scanf   PROTO arg2:Ptr Byte, inputlist:VARARG
        .data
in1fmt  byte    "%d", 0
msg0fmt byte    0Ah,"%s",0
msg1fmt byte    0Ah,"%s%d",0Ah,0Ah,0
msg0    byte    "Enter an integer for num1: ",0
msg1    byte    "The integer in num2 is: ",0
num1    sdword  ?   ; first number
num2    sdword  ?   ; second number
        .code
main    proc
        INVOKE printf, ADDR msg0fmt, ADDR msg0
        INVOKE scanf, ADDR in1fmt, ADDR num1
        mov eax, num1   ; load eax with the content of num1
        mov num2, eax   ; store the contents of eax in num2
        INVOKE printf, ADDR msg1fmt, ADDR msg1, num2
        ret 
main    endp
end