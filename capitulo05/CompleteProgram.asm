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
msg3fmt byte    "%s%d",0Ah,0Ah,0
errfmt  byte    "%s",0Ah,0Ah,0
errmsg1 byte    "Error: Negative x and/or y",0
errmsg2 byte    "Error: Undefined answer",0
msg1    byte    "Enter x: ",0
msg2    byte    "Enter n: ",0
msg3    byte    0Ah, "The answer is: ",0
x       sdword  ? 
n       sdword  ? 
ans     sdword  ? 
i       sdword  ?
        .code   
main    proc
        INVOKE printf, ADDR msg1fmt, ADDR msg1
        INVOKE scanf, ADDR in1fmt, ADDR x
        INVOKE printf, ADDR msg1fmt, ADDR msg2
        INVOKE scanf, ADDR in1fmt, ADDR n
        .if x < 0 || n < 0
        INVOKE printf, ADDR errfmt, ADDR errmsg1
        .else
        .if x == 0 && n == 0
        INVOKE printf, ADDR errfmt, ADDR errmsg2
        .else
        mov ecx,1
        mov ans,1
        .while ecx <= n
        mov eax,ans
        imul x
        mov ans,eax
        inc ecx 
        .endw 
        mov i,ecx
        INVOKE printf, ADDR msg3fmt, ADDR msg3, ans
        .endif
        .endif
        ret
main    endp
        end

