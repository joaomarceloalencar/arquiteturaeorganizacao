;
;   Building Instructions:
;   ml /Cx /coff SelectionSort.asm /link /SUBSYSTEM:console  /out:SelectionSort.exe kernel32.lib legacy_stdio_definitions.lib msvcrt.lib
;   
          .686
          .model  flat, c
          .stack  100h
printf    PROTO   arg1:Ptr Byte, printlist:VARARG
scanf     PROTO   arg2:Ptr Byte, inputlist:VARARG
          .data
msg1fmt   byte    0Ah, "%s", 0
msg2fmt   byte    "%s", 0
msg3fmt   byte    0Ah, "%s", 0Ah, 0Ah, 0
msg4fmt   byte    "   %d", 0Ah, 0
msg5fmt   byte    0Ah, 0
in1fmt    byte    "%d", 0
msg1      byte    "Enter the number of integers to be input: ", 0
msg2      byte    "Enter a integer: ", 0
msg3      byte    "Sorted", 0
n         sdword  ?
array     sdword  20 dup(?)
temp      sdword  ?
          .code
main      proc
          INVOKE printf, ADDR msg1fmt, ADDR msg1
          INVOKE scanf, ADDR in1fmt, ADDR n
          INVOKE printf, ADDR msg5fmt
          .if n > 0                 ; if n <= 0, don't continue
          mov ecx, n                ; load ecx with n
          mov edi, offset array + 0 ; load address of array into edi

          .repeat
          push ecx                  ; save ecx
          INVOKE printf, ADDR msg2fmt, ADDR msg2
          INVOKE scanf, ADDR in1fmt, ADDR [edi]
          add edi, 4                ; increment edi by 4
          pop ecx                   ; restore ecx
          .untilcxz 
          
          .if n > 1                 ; check >1 elements in array
          mov ecx, n                ; load ecx with n
          dec ecx                   ; loop n-1 times
          mov esi, offset array + 0 ; load esi with address of array
          
          .repeat                   ; first loop
          push ecx                  ; save ecx
          push esi                  ; save address, esi now smallest
          mov edi, esi              ; load address of esi in edi
          add edi, 4                ; move edi to the next element
          
          .repeat                   ; second loop
          mov eax, [esi]            ; move smallest to eax to compare
          .if [edi] < eax           ; compare smallest to next
          mov esi, edi              ; save the new smallest in esi
          .endif
          add edi, 4                ; move to the next element to compare
          .untilcxz
          
          mov edi, esi              ; edi points to smallest element
          pop esi                   ; esi points to the start element
          mov eax, [esi]            ; move start element to temp
          xchg eax, [edi]           ; exchange start and smallest
          mov [esi], eax            ; move smallest back to start 
          add esi, 4                ; move start index to next
          pop ecx                   ; restore ecx to be decremented
          .untilcxz 
          .endif

          INVOKE printf, ADDR msg3fmt, ADDR msg3
          mov ecx, n                ; load ecx with n
          mov esi, offset array + 0 ; load esi with address of array
        
          .repeat
          push ecx                  ; save ecx
          mov eax, [esi]            ; load eax with element of array
          mov temp, eax             ; store eax in temp for output
          INVOKE printf, ADDR msg4fmt, temp 
          add esi, 4                ; increment esi to next element
          pop ecx                   ; restore ecx
          .untilcxz
        
          INVOKE printf, ADDR msg5fmt
        
          .endif
          ret
main      endp
          end