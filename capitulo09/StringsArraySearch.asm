;
;   Building Instructions:
;   ml /Cx /coff StringsArraySearch.asm /link /SUBSYSTEM:console  /out:StringsArraySearch.exe kernel32.lib legacy_stdio_definitions.lib msvcrt.lib
;   
          .686
          .model  flat, c
          .stack  100h
printf    PROTO   arg1:Ptr Byte, printlist:VARARG
scanf     PROTO   arg2:Ptr Byte, inputlist:VARARG
          .data
msg1fmt   byte    "%s", 0
msg2fmt   byte    0Ah, "%s", 0Ah, 0Ah, 0
in1fmt    byte    "%s", 0
msg1      byte    "Enter the state to be found: ", 0
msg2      byte    "The state was found", 0
msg3      byte    "The state was not found.", 0
arraystr  byte    "Illinois  ", "Michigan  ", "Iowa      ",
                  "Missouri  ", "Arkansas  ", "Tennessee ",
                  "Louisiana ", "Arizona   ", "Montana   ",
                  "Ohio     "
n         sdword  10
string    byte    10 dup(?)
found     sdword  ?
          .code 
main      proc
          INVOKE printf, ADDR msg1fmt, ADDR msg1
          INVOKE scanf, ADDR in1fmt, ADDR string
          mov ecx, 0                   ; initialize ecx to 0
          mov found, 0                 ; initialize found to 0
          lea edi, arraystr + 0        ; load edi with address
          .while (ecx < n && found != -1)
          push ecx                     ; save ecx
          lea esi, string + 0          ; load address of string
          cld                          ; clear direction
          mov ecx, lengthof string     ; load length of string
          repe cmpsb                   ; compare while equal
          dec esi                      ; decrement esi
          dec edi                      ; decrement edi
          mov al, [esi]                ; load al with [esi]
          mov ah, [edi]                ; load ah with [edi]
          .if (al == 0) && (ah == " ") ; compare for 0 and space 
          mov found, -1                ; if yes, found 
          .endif
          inc edi                      ; increment edi back
          add edi, ecx                 ; adjust edi to next string
          pop ecx                      ; restore ecx
          inc ecx                      ; increment ecx
          .endw
          .if (found == -1)
          INVOKE printf, ADDR msg2fmt, ADDR msg2
          .else 
          INVOKE printf, ADDR msg2fmt, ADDR msg3
          .endif
          ret
main      endp
          end