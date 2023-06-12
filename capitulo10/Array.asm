          .686
          .model flat, c
          .stack 100h
printf    PROTO arg1:Ptr Byte, printlist:VARARG
          .data
          msg1fmt  byte 0Ah,"%s",0Ah,0Ah,0
          msg2fmt  byte " %3.1f",0Ah,0
          msg1     byte "Array",0
          n        sdword 5
          array    real8 1.0, 2.3, 3.7, 4.9, 5.1
          .code
main      proc
          INVOKE printf, ADDR msg1fmt, ADDR msg1
          lea esi,array
          mov ecx,n
          .repeat
          push ecx
          INVOKE printf, ADDR msg2fmt, real8 ptr [esi]
          pop ecx
          add esi,8
          .untilcxz
          INVOKE printf, ADDR msg1fmt, ADDR msg1
          mov ebx,0
          mov ecx,n
          .repeat
          push ecx
          INVOKE printf, ADDR msg2fmt, array[ebx]
          pop ecx
          add ebx,8
          .untilcxz
          ret 
main      endp
          end
