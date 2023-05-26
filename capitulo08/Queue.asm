;
;   Building Instructions:
;   ml /Cx /coff Queue.asm /link /SUBSYSTEM:console  /out:Queue.exe kernel32.lib legacy_stdio_definitions.lib msvcrt.lib
;   
          .686
          .model  flat, c
          .stack  100h
printf    PROTO   arg1:Ptr Byte, printlist:VARARG
scanf     PROTO   arg2:Ptr Byte, inputlist:VARARG
          .data
in1fmt    byte    "%s", 0
in2fmt    byte    "%d", 0
msg1fmt   byte    0Ah, "%s", 0
msg3fmt   byte    0Ah, "%s%d", 0Ah, 0
msg4fmt   byte    0Ah, 0
errfmt    byte    0Ah, "%s", 0Ah, 0
msg1      byte    "Enter a command, e, d, or s: ", 0
msg2      byte    "Enter a positive integer: ", 0
msg3      byte    "The integer is: ", 0
errmsg1   byte    "Error: Invalid entry, try again", 0
errmsg2   byte    "Error: Queue is full", 0
errmsg3   byte    "Error: Queue is empty", 0
queue     sdword  3 dup(?)
command   sdword  ?
number    sdword  ?
count     sdword  0
          .code
enqueue   macro
          .if count < lengthof queue
          inc count             ; increment count
          mov  eax, number      ; load eax with number
          mov [edi], eax        ; store eax in rear
          mov eax, edi          ; copy edi (rear) to eax
          sub eax, offset queue ; subtract address of queue
          add eax, 4            ; increment eax by 4
          cdq                   ; convert double to quad
          mov ecx, sizeof queue ; get the size of queue (bytes)
          idiv ecx              ; divide
          mov edi, offset queue ; load address in rear
          add edi, edx          ; add remainder to rear
          .else
          INVOKE printf, ADDR errfmt, ADDR errmsg2
          .endif
          endm
dequeue   macro
          .if count > 0
          dec count             ; decrement count
          mov eax, [esi]        ; load eax from front
          mov number, eax       ; store eax in number
          mov eax, esi          ; copy esi (front) to eax
          sub eax, offset queue ; subtract address of queue
          add eax, 4            ; increment eax by 4
          cdq                   ; convert double to quad
          mov ecx, sizeof queue ; get size of queue (bytes)
          idiv ecx              ; divide
          mov esi, offset queue ; load address in front
          add esi, edx          ; add remainder to front
          .else
          INVOKE printf, ADDR errfmt, ADDR errmsg3
          mov number, -1        ; store -1 (flag) in number
          .endif
          endm
main      proc
          mov edi, offset queue+0 ; use edi as front of queue
          mov esi, offset queue+0 ; use esi as rear of queue
          INVOKE printf, ADDR msg1fmt, ADDR msg1  ; priming
          INVOKE scanf, ADDR in1fmt, ADDR command ; read
          .while command != "s"  ; while not stop
          .if command == "e"     ; enqueue?
          INVOKE printf, ADDR msg1fmt, ADDR msg2
          INVOKE scanf, ADDR in2fmt, ADDR number
          enqueue                ; enqueue
          .elseif command == "d" ; dequeue?
          dequeue                ; deque number
          .if number > 0         ; not -1 (flag)?
          INVOKE printf, ADDR msg3fmt, ADDR msg3, number
          .endif
          .else
          INVOKE printf, ADDR errfmt, ADDR errmsg1
          .endif
          INVOKE printf, ADDR msg1fmt, ADDR msg1
          INVOKE scanf, ADDR in1fmt, ADDR command
          .endw
          INVOKE printf, ADDR msg4fmt
          ret
main      endp
          end