;
;   Building Instructions:
;   ml /c /Fl"Addacc.lst" /Cx /coff Addacc.asm /link /SUBSYSTEM:console  /out:Addacc.exe kernel32.lib legacy_stdio_definitions.lib msvcrt.lib
;
          .686
          .model  flat, c
          .stack  100h
printf    PROTO   arg1:Ptr Byte, printlist:VARARG
scanf     PROTO   arg2:Ptr Byte, inputlist:VARARG
          .data
num       sdword  7
          .code
addacc    macro parm
          ifb <parm>
          inc eax
          else
          add eax, parm
          endif
          endm
main      proc
          mov eax, 0
          addacc
          addacc 5
          mov edx, 6
          addacc edx
          addacc num
          ret
main      endp
          end