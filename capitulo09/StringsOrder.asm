;
;   Building Instructions:
;   ml /Cx /coff StringsOrder.asm /link /SUBSYSTEM:console  /out:StringsOrder.exe kernel32.lib legacy_stdio_definitions.lib msvcrt.lib
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
msg1      byte    "Enter a first name: ", 0
msg2      byte    "Enter another first name: ", 0
msg3      byte    "The names are the same.", 0
msg4      byte    "The first name is less than the second.", 0
msg5      byte    "The first name is greater than the second.", 0
name1     byte    6 dup(" ")
name2     byte    6 dup(" ")
          .code 
main      proc
          INVOKE printf, ADDR msg1fmt, ADDR msg1
          INVOKE scanf, ADDR in1fmt, ADDR name1
          INVOKE printf, ADDR msg1fmt, ADDR msg2
          INVOKE scanf, ADDR in1fmt, ADDR name2
          mov ecx, lengthof name1 ; load ecx with length
          lea esi, name1          ; load address of name1
          lea edi, name2          ; load address of name2
          cld                     ; clear direction flag
          repe cmpsb              ; compare while equal 
          dec esi                 ; backup esi one position
          dec edi                 ; backup edi one position
          mov al, [esi]           ; load al with [esi]
          .if al == [edi]         ; if equal
          INVOKE printf, ADDR msg2fmt, ADDR msg3
          .else
          .if al < [edi]          ; if less than
          INVOKE printf, ADDR msg2fmt, ADDR msg4
          .else
          INVOKE printf, ADDR msg2fmt, ADDR msg5
          .endif
          .endif
          ret
main      endp
          end