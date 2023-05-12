;
;   Building Instructions:
;   ml /Cx /coff Swap.asm /link /SUBSYSTEM:console  /out:Swap.exe kernel32.lib legacy_stdio_definitions.lib msvcrt.lib
;   Create .lst
;   ml /c /Fl"Swap.lst" /Cx /coff Swap.asm 
          .686
          .model  flat, c
          .stack  100h
printf    PROTO   arg1:Ptr Byte, printlist:VARARG
scanf     PROTO   arg2:Ptr Byte, inputlist:VARARG
          .data
msg1fmt   byte   0Ah, "num1: %d, num2: %d", 0Ah, 0Ah, 0
num1      sdword  15
num2      sdword  37          
          .code
swap      macro
          mov ebx, num1
          xchg ebx, num2
          mov num1, ebx
          endm
main      proc
          INVOKE printf, ADDR msg1fmt, num1, num2
          swap
          INVOKE printf, ADDR msg1fmt, num1, num2
          swap
          INVOKE printf, ADDR msg1fmt, num1, num2
          ret
main      endp
          end