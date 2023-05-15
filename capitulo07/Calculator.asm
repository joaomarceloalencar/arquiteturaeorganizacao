;
;   Building Instructions:
;   ml /c /Fl"Calculator.lst" /Cx /coff Calculator.asm /link /SUBSYSTEM:console  /out:Calculator.exe kernel32.lib legacy_stdio_definitions.lib msvcrt.lib
;
          .686
          .model  flat, c
          .stack  100h
printf    PROTO   arg1:Ptr Byte, printlist:VARARG
scanf     PROTO   arg2:Ptr Byte, inputlist:VARARG
          .data
msg1fmt   byte   0Ah, "%s%d", 0Ah, 0Ah, 0
msg1      byte   "The contents of the accumulator are: ", 0
temp      sdword ?
three     sdword 3
          .code
LOADACC   macro operand
          mov eax, operand   ;; load eax with the operand
          endm
ADDACC    macro operand
          add eax, operand   ;; add the operand to eax 
          endm
MULTACC   macro operand
	      push ebx           ;; save ebx and ecx
          push ecx
          mov ebx, eax       ;; mov eax to ebx
          mov eax, 0         ;; clear accumulator to zero
          mov ecx, operand   ;; load ecx with operand
          if operand LT 0    ;; if operand is negative
          neg ecx            ;; make ecx positive for loop
          endif   
          .while ecx > 0
          add eax, ebx       ;; repetitively add 
          dec ecx            ;; decrement ecx
          .endw    
          if operand LT 0    ;; if operand is negative
          neg eax            ;; negate accumulator, eax
          endif
          pop ecx            ;; restore ecx and ebx
          pop ebx 
          endm
main      proc 
          LOADACC 1
          ADDACC  2
          ADDACC  three
          MULTACC 4
          MULTACC -3
          CALL    OUTACC
          ret
main      endp
OUTACC    proc
	      push eax           ;; save ebx and ecx, and edx
          push ecx
          push edx
          mov temp, eax
          INVOKE printf, ADDR msg1fmt, ADDR msg1, temp
	      pop edx            ;; save ebx and ecx, and edx
          pop ecx
          pop eax
          ret       
OUTACC    endp
          end          