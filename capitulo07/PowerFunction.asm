;
;   Building Instructions:
;   ml /Cx /coff PowerFunction.asm /link /SUBSYSTEM:console /out:PowerFunction.exe kernel32.lib legacy_stdio_definitions.lib msvcrt.lib
;
          .686
          .model  flat, c
          .stack  100h
printf    PROTO   arg1:Ptr Byte, printlist:VARARG
scanf     PROTO   arg2:Ptr Byte, inputlist:VARARG
          .data
in1fmt    byte  "%d", 0
msg1fmt   byte  "%s", 0
msg3fmt   byte  "%s%d", 0Ah, 0Ah, 0
errfmt    byte  "%s", 0Ah, 0
errmsg1   byte  0Ah, "Error: Negative x and/or y", 0
errmsg2   byte  0Ah, "Error: Undefined answer", 0
msg1      byte  "Enter x: ", 0
msg2      byte  "Enter n: ", 0
msg3      byte  0Ah, "The answer is: ", 0
x         sdword ?
n         sdword ?
ans       sdword ?
          .code
main      proc
          INVOKE printf, ADDR msg1fmt, ADDR msg1
          INVOKE scanf, ADDR in1fmt, ADDR x
          INVOKE printf, ADDR msg1fmt, ADDR msg2
          INVOKE scanf, ADDR in1fmt, ADDR n
          call power
          INVOKE printf, ADDR msg3fmt, ADDR msg3, ans
          ret
main      endp
power     proc
          push eax ; save registers
          push ecx 
          push edx
          mov ans, -1 ; default value for ans
          .if x < 0 || n < 0
          INVOKE printf, ADDR errfmt, ADDR errmsg1
          .else
          .if x == 0 && n == 0
          INVOKE printf, ADDR errfmt, ADDR errmsg2
          .else
          mov ecx, 1  ; initialize ecx loop counter
          mov ans, 1  ; initialize ans
          .while ecx <= n
          mov eax, ans ; load eax with ans
          imul x       ; multiply eax by x
          mov ans, eax ; store eax in ans
          inc ecx      ; increment eax loop counter
          .endw
          .endif
          .endif
          pop edx      ; restore registers
          pop ecx
          pop eax
          ret
power     endp 
          end

