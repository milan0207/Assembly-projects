;beolvas egy előjeles 32 bites egész számot 10-es számrendszerben;
;kiírja a beolvasott értéket 10-es számrendszerben előjeles egészként, komplementer kódbeli ábrázolását 16-os és kettes számrendszerben;
;beolvas egy 32 bites hexa számot;
;kiírja a beolvasott értéket 10-es számrendszerben előjeles egészként, komplementer kódbeli ábrázolását 16-os és kettes számrendszerben;
;beolvas egy 32 bites bináris számot;
;kiírja a beolvasott értéket 10-es számrendszerben előjeles egészként, komplementer kódbeli ábrázolását 16-os és kettes számrendszerben;
;kiírja a három beolvasott érték összegét 10-es számrendszerben előjeles egészként, komplementer kódbeli ábrázolását 16-os és kettes számrendszerben;
;ez előző lépéseket elvégzi 64 bites értékekre is.

    ;Koncsard Milan, kmim2248, 512
    ;LAB4, feladat 4

;.\nasm.exe -f win32 iostr.asm
;.\nasm.exe -f win32 ionum.asm
;.\nasm.exe -f win32 iopelda.asm
;.\nlink iostr.obj ionum.obj iopelda.obj -lmio -o iopelda.exe

;.\iopelda.exe ;.\actest L4a_64 iopelda.exe

;OK

%include 'iostr.inc'
%include 'ionum.inc'
%include 'mio.inc'

global main

section .text

main:
mov esi,decimalis32
call WriteStr
.ujra1:
call ReadInt
jc .hiba1
jmp .folytat1
.hiba1:
call NewLine
mov esi,hiba
call WriteStr
call NewLine
jmp .ujra1
.folytat1:

mov [a],eax
call NewLine
call WriteInt
mov eax, [a]
call NewLine
call WriteHex
mov eax, [a]
call NewLine
call WriteBin
call NewLine

mov esi,hex32
call WriteStr

.ujra2:
call ReadHex
jc .hiba2
jmp .folytat2
.hiba2:
call NewLine
mov esi,hiba
call WriteStr
call NewLine
jmp .ujra2
.folytat2:


mov [b],eax
call NewLine
call WriteInt
mov eax, [b]
call NewLine
call WriteHex
mov eax, [b]
call NewLine
call WriteBin
call NewLine
mov esi,bin32
call WriteStr

.ujra3:
call ReadBin
jc .hiba3
jmp .folytat3
.hiba3:
call NewLine
mov esi,hiba
call WriteStr
call NewLine
jmp .ujra3
.folytat3:

mov [c],eax
call NewLine
call WriteInt
mov eax, [c]
call NewLine
call WriteHex
mov eax, [c]
call NewLine
call WriteBin
call NewLine

mov eax,[a]
mov ebx, [b]
add eax,ebx
mov ebx,[c]
add eax,ebx
mov [d],eax
mov esi, osszeg
call WriteStr
mov eax, [d]
call NewLine
call WriteInt
mov eax, [d]
call NewLine
call WriteHex
mov eax, [d]
call NewLine
call WriteBin
call NewLine

;64 bites main program


mov esi,decimalis64
call WriteStr
.ujra4:
call ReadInt64
jc .hiba4
jmp .folytat4
.hiba4:
call NewLine
mov esi,hiba
call WriteStr
call NewLine
jmp .ujra4
.folytat4:

mov [a],eax
mov [a2],edx
call NewLine
call WriteInt64
mov eax, [a]
mov edx,[a2]
call NewLine
call WriteHex64
mov eax, [a]
mov edx,[a2]
call NewLine
call WriteBin64
call NewLine

mov esi,hex64
call WriteStr

.ujra5:
call ReadHex64
jc .hiba5
jmp .folytat5
.hiba5:
call NewLine
mov esi,hiba
call WriteStr
call NewLine
jmp .ujra5
.folytat5:


mov [b],eax
mov [b2],edx
call NewLine
call WriteInt64
mov eax, [b]
mov edx, [b2]
call NewLine
call WriteHex64
mov eax, [b]
mov edx, [b2]
call NewLine
call WriteBin64
call NewLine
mov esi,bin64
call WriteStr

.ujra6:
call ReadBin64
jc .hiba6
jmp .folytat6
.hiba6:
call NewLine
mov esi,hiba
call WriteStr
call NewLine
jmp .ujra6
.folytat6:

mov [c],eax
mov [c2],edx
call NewLine
call WriteInt64
mov eax, [c]
mov edx, [c2]
call NewLine
call WriteHex64
mov eax, [c]
mov edx, [c2]
call NewLine
call WriteBin64
call NewLine

mov eax,[a]
mov edx, [a2]
mov ebx, [b]
mov ecx, [b2]
add eax,ebx
adc edx,0
add edx,ecx
mov ebx,[c]
mov ecx, [c2]
add eax,ebx
adc edx,0
add edx,ecx
mov [d],eax
mov [d2],edx
mov esi, osszeg
call WriteStr
mov eax, [d]
mov edx, [d2]
call NewLine
call WriteInt64
mov eax, [d]
mov edx, [d2]
call NewLine
call WriteHex64
mov eax, [d]
mov edx, [d2]
call NewLine
call WriteBin64
call NewLine

ret

section .data
a dd 0
b dd 0
c dd 0
d dd 0
a2 dd 0
b2 dd 0
c2 dd 0
d2 dd 0

section .text
decimalis32 db "Olvass be egy 32 bites 10-es szamrendszerbeli szamot: ", 0
hex32 db "Olvass be egy 32 bites Hexa szamot: ",0
bin32 db "olvass be egy  32 bites Binaris szamot: ",0
osszeg db "az osszegek a kovetkezok: " ,0
hiba db " Hiba ", 0
decimalis64 db "Olvass be egy 64 bites 10-es szamrendszerbeli szamot: ", 0
hex64 db "Olvass be egy 64 bites Hexa szamot: ",0
bin64 db "olvass be egy  64 bites Binaris szamot: ",0