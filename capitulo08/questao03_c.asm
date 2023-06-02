          .686
          .model  flat, c
          .stack  100h
printf    PROTO   arg1:Ptr Byte, printlist:VARARG
          .data
msg1fmt   byte    "%d ", 0
msg2fmt   byte    0Ah, 0
num       sdword  10, 20, 30, 40, 50
n         sdword  5
i         sdword  2
          .code
pnum      macro
          pushad
          mov ecx, 5
          mov ebx, offset num + 0
          .repeat
          mov eax, [ebx]
          pushad
          INVOKE printf, ADDR msg1fmt, eax
          popad
          add ebx, 4
          .untilcxz
          INVOKE printf, ADDR msg2fmt
          popad
          endm
main      proc
   
          pnum 

          ; mov ebx, 0
          ; mov eax, num[ebx]
          ; INVOKE printf, ADDR msg1fmt, eax
          ; INVOKE printf, ADDR msg2fmt

          ; mov ebx, 4
          ; mov eax, num[ebx]
          ; INVOKE printf, ADDR msg1fmt, eax
          ; INVOKE printf, ADDR msg2fmt

          mov ebx, i
          sal ebx, 2
          mov eax, num[ebx]
          mov num + 4[ebx], eax

          pnum
          
          ret
main      endp
          end 







