;
;   Building Instructions:
;   ml /Cx /coff Array.asm /link /SUBSYSTEM:console  /out:Array.exe kernel32.lib legacy_stdio_definitions.lib msvcrt.lib
;   
          .686
          .model  flat, c
          .stack  100h
printf    PROTO   arg1:Ptr Byte, printlist:VARARG
scanf     PROTO   arg2:Ptr Byte, inputlist:VARARG
          .data
msg1fmt   byte    0Ah, "%s", 0
msg2fmt   byte    0Ah, "%s", 0Ah, 0Ah, 0
msg3fmt   byte    "   %d", 0Ah, 0Ah, 0
in1fmt    byte    "%d", 0
msg1      byte    "Enter the number of integers to be input: ", 0
msg2      byte    "Enter an integer: ", 0
msg3      byte    "Reversed", 0
msg4      byte    "No data entered."
n         sdword  ?
array     sdword  20 dup (?)          
          .code
main      proc
          INVOKE printf, ADDR msg1fmt, ADDR msg1
          INVOKE scanf, ADDR in1fmt, ADDR n
          mov ecx, n    ; initialize ecx to n
          mov ebx, 0    ; initialize ebx to 0
          .if ecx > 0
          .repeat
          push ecx      ; save ecx
          INVOKE printf, ADDR msg1fmt, ADDR msg2
          INVOKE scanf, ADDR in1fmt, ADDR array[ebx]
          pop ecx       ; restore ecx
          add ebx, 4    ; increment ebx by 4
          .untilcxz
          INVOKE printf, ADDR msg2fmt, ADDR msg3
          mov ecx, n    ; initialize ecx to n
          sub ebx, 4    ; subtract 4 from ebx
          .repeat
          push ecx      ; save ecx
          INVOKE printf, ADDR msg3fmt, array[ebx]
          pop ecx       ; restore ecx
          sub ebx, 4    ; decrement ebx by 4
          .untilcxz
          .else
          INVOKE printf, ADDR msg2fmt, ADDR msg4          
          .endif
          ret
main      endp
          end

