;
;   Building Instructions:
;   ml /Cx /coff FirstProgram.asm /link /SUBSYSTEM:console /out:FirstProgram.exe kernel32.lib legacy_stdio_definitions.lib msvcrt.lib
;

        .686
        .model  flat, c 
        .stack  100h 
        .data
num1    sdword ?            ; first number
num2    sdword ?            ; second number
        .code
main    proc
        mov     num1,5      ; initialize num1 with 5
        mov     eax,num1    ; load eax with contents of num1
        mov     num2,eax    ; store eax in num2
        ret
main    endp 
        end
