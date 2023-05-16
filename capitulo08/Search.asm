;
;   Building Instructions:
;   ml /Cx /coff Search.asm /link /SUBSYSTEM:console  /out:Search.exe kernel32.lib legacy_stdio_definitions.lib msvcrt.lib
;   
          .686
          .model  flat, c
          .stack  100h
printf    PROTO   arg1:Ptr Byte, printlist:VARARG
scanf     PROTO   arg2:Ptr Byte, inputlist:VARARG
          .data
msg1fmt   byte    "%s", 0
msg2fmt   byte    0Ah, "%s", 0Ah, 0Ah, 0
in1fmt    byte    "%d", 0
msg1      byte    "Enter the integer to be found: ", 0
msg2      byte    "The integer was found ", 0
msg3      byte    "The integer was not found", 0
array     sdword  20,19,18,17,16,15,14,13,12,11,1,2,3,4,5,6,7,8,9          
n         sdword  20
number    sdword  ?
found     sbyte   ?
          .code
main      proc
          INVOKE printf, ADDR msg1fmt, ADDR msg1
          INVOKE scanf, ADDR in1fmt, ADDR number
          mov ebx, 0        ; initialize ebx to 0
          mov ecx, 0        ; initialize ecx to 0
          mov edx, number   ; load edx with number
          mov found, 0      ; initialize found to 0 
          .while (ecx < n && !found)
          .if (edx == array[ebx])
          mov found, -1     ; set found to -1
          .else
          add ebx, 4        ; increment ebx by 4
          .endif
          inc ecx           ; increment ecx by 1
          .endw
          .if (found)
          INVOKE printf, ADDR msg2fmt, ADDR msg2
          .else
          INVOKE printf, ADDR msg2fmt, ADDR msg3
          .endif
          ret
main      endp
          end

