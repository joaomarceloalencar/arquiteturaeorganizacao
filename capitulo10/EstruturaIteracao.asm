         .686
         .model flat,c
         .stack 100h

printf   PROTO arg1:Ptr Byte, printlist:VARARG
scanf    PROTO arg2:Ptr Byte, inputlist:VARARG

         .data
in1fmt   byte "%lf", 0
msg0fmt  byte 0Ah,"%s",0
msg1fmt  byte 0Ah,"%s%6.1f",0Ah,0
msg0     byte "Enter a positive double for x: ",0
msg1     byte "The sum is: ",0

x        real8 ?
sum      real8 ?
zero     real8 0.0

         .code
main     proc
         ;sum = 0.0
         fld zero
         fstp sum
    
         INVOKE printf, ADDR msg0fmt, ADDR msg0
    
         INVOKE scanf, ADDR in1fmt, ADDR x
         ;while x > 0.0
while01: fld zero
         fld x
         fcomip st(0), st(1)
         jbe endw01
         ;sum = sum + x
         fld sum
         fadd x
         fstp sum
         INVOKE printf, ADDR msg0fmt, ADDR msg0
         INVOKE scanf, ADDR in1fmt, ADDR x
         jmp while01
 endw01: nop
         INVOKE printf, ADDR msg1fmt, ADDR msg1, sum
         ret 
main     endp
         end