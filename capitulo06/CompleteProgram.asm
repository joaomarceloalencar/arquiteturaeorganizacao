;
;   Building Instructions:
;   ml /Cx /coff CompleteProgram.asm /link /SUBSYSTEM:console /out:CompleteProgram.exe kernel32.lib legacy_stdio_definitions.lib msvcrt.lib
;

          .686
          .model  flat, c
          .stack  100h
printf    PROTO   arg1:Ptr Byte, printlist:VARARG
scanf     PROTO   arg2:Ptr Byte, inputlist:VARARG
          .data
msg1fmt   byte  "%s", 0
in1fmt    byte  "%x", 0
msg2fmt   byte  "%s%x", 0Ah, 0Ah, 0
msg1      byte  0Ah, "Enter a hexadecimal number: ", 0
msg2      byte  "The hexadecimal number is ", 0
msgshort  byte  "SHORT DOCUMENT", 0Ah, 0    
msglong   byte  "LONG DOCUMENT", 0Ah, 0    
msgclose  byte  "CLOSE FEED", 0Ah, 0    
msgmult   byte  "MULTIPLE FEED", 0Ah, 0    
msgskew   byte  "EXCESSIVE SKEW", 0Ah, 0    
msgfeed   byte  "DOCUMENT MISFEED", 0Ah, 0    
msgjam    byte  "DOCUMENT JAM", 0Ah, 0    
msgerror  byte  "UNSPECIFIED ERROR", 0Ah, 0
dsb       dword ?
          .code 
main      proc 
          INVOKE printf, ADDR msg1fmt, ADDR msg1
          INVOKE scanf, ADDR in1fmt, ADDR dsb
          INVOKE printf, ADDR msg2fmt, ADDR msg2, dsb
          .while dsb <= 0ffh

          test dsb, 00000001b
          .if !ZERO?                ; if bit0 = 1 then
          INVOKE printf, ADDR msg1fmt, ADDR msgshort
          .endif

          test dsb, 00000010b
          .if !ZERO?                ; if bit1 = 1 then
          INVOKE printf, ADDR msg1fmt, ADDR msglong
          .endif

          test dsb, 00000100b
          .if !ZERO?                ; if bit2 = 1 then
          INVOKE printf, ADDR msg1fmt, ADDR msgclose
          .endif

          test dsb, 00001000b
          .if !ZERO?                ; if bit3 = 1 then
          INVOKE printf, ADDR msg1fmt, ADDR msgmult
          .endif
  
          test dsb, 00010000b
          .if !ZERO?                ; if bit4 = 1 then
          INVOKE printf, ADDR msg1fmt, ADDR msgskew
          .endif

          test dsb, 00100000b
          .if !ZERO?                ; if bit5 = 1 then
          INVOKE printf, ADDR msg1fmt, ADDR msgfeed
          .endif

          test dsb, 01000000b
          .if !ZERO?                ; if bit6 = 1 then
          INVOKE printf, ADDR msg1fmt, ADDR msgjam
          .endif

          test dsb, 10000000b
          .if !ZERO?                ; if bit7 = 1 then
          INVOKE printf, ADDR msg1fmt, ADDR msgerror
          .endif

          INVOKE printf, ADDR msg1fmt, ADDR msg1
          INVOKE scanf, ADDR in1fmt, ADDR dsb
          INVOKE printf, ADDR msg2fmt, ADDR msg2, dsb

          .endw
          ret
main      endp
          end