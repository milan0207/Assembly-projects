; After printing the appropriate message, we read a string;
; Print its length;
; Print its compact form;
; Print its compact form converted to lowercase;
; After printing the appropriate message, we read a second string;
; Print its length;
; Print its compact form;
; Print its compact form converted to uppercase;
; Create a new string in memory: concatenate the uppercase version of the first string with the lowercase version of the second string;
; Print the created string;
; Print the length of the created string;
; Finish the program.

;Koncsard Milan, kmim2248, 512
;LAB4, feladat 4

;.\nasm.exe -f win32 iostr.asm
;.\nasm.exe -f win32 strings.asm
;.\nasm.exe -f win32 strpelda.asm
;.\nlink iostr.obj strings.obj strpelda.obj -lmio -o strpelda.exe

;.\actest L4b strpelda.exe;.\strpelda.exe
%include 'iostr.inc'
%include 'strings.inc'
%include 'mio.inc'

;OK

global main

section .text

masolas:
    xor ebx,ebx
    xor ecx,ecx
.masol:

    mov edx,0
    mov al, [esi+ebx]      
    mov [edi+ecx],al
    inc ebx
    inc ecx
    cmp al,0
    jne .masol
    mov al,0
    mov [edi+ecx],al
ret

kiir_szam:
xor ecx,ecx
    .verembe:
        mov ebx,10
        cdq
        idiv ebx   
        push edx
        inc ecx
        cmp eax,0
        jne .verembe

    .kiiras:
        xor eax,eax
        pop eax
        add eax,48
        call mio_writechar
        dec ecx
        cmp ecx,0
        jne .kiiras
ret


main:
mov ecx,256
mov esi,elso
call WriteStr

mov esi, stra
call ReadLnStr

mov esi,karakter
call WriteLnStr
mov esi,stra
call StrLen
call kiir_szam

call NewLine

mov esi,tomoritett
call WriteLnStr
mov esi,stra
mov edi,stra_2
call StrCompact

mov esi,stra_2
call WriteLnStr

mov esi,kisbetu
call WriteLnStr
mov esi,stra_2
call StrLower

mov esi,stra_2
call WriteLnStr

mov esi, masodik
call WriteStr

mov ecx,256
mov esi,strb
call ReadLnStr


mov esi,karakter
call WriteLnStr
mov esi,strb
call StrLen
call kiir_szam
call NewLine

mov esi,tomoritett
call WriteLnStr
mov esi,strb
mov edi, strb_2
call StrCompact

mov esi,strb_2
call WriteLnStr

mov esi,nagybetu
call WriteLnStr
mov esi,strb_2
call StrUpper

mov esi, strb_2
call WriteLnStr



mov edi,strc
mov esi,stra
call masolas

mov esi,strc

call StrUpper

mov esi,strb
call StrLower


mov edi, strc
mov esi, strb
call StrCat

mov esi,strc
call WriteLnStr

mov esi,strc
call StrLen
call kiir_szam
ret

section .bss
stra resb 256
stra_2 resb 256
strb resb 256
strb_2 resb 256
strc resb 256

section .data
elso db "Read the first string: ", 0
masodik db "Read the second string: ", 0
karakter db "It consists of this many characters: ", 0
tomoritett db "Compact form: ", 0
kisbetu db "Converted to lowercase: ", 0
nagybetu db "Converted to uppercase: ", 0
