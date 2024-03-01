;StrLen(ESI):(EAX)              – EAX-ben visszatéríiti az ESI által jelölt string hosszát, kivéve a bináris 0-t
;StrCat(EDI, ESI):()             – összefűzi az ESI és EDI által jelölt stringeket (azaz az ESI által jelöltet az EDI után másolja)
;StrUpper(ESI):()                 – nagybetűssé konvertálja az ESI stringet
;StrLower(ESI):()                 – kisbetűssé konvertálja az ESI stringet
;StrCompact(ESI, EDI):()      – EDI-be másolja át az ESI stringet, kivéve a szóköz, tabulátor (9), kocsivissza (13) és soremelés (10) karaktereket

;Koncsard Milan, kmim2248, 512
;LAB4, feladat 3

;.\nasm.exe -f win32 L4_3.asm
;.\nlink.exe L4_3.obj -lmio -o L4_3.exe
; .\L4_3.exe

%include 'mio.inc'


global StrLen
global StrCat
global StrUpper
global StrLower
global StrCompact


section .text


StrLen:
push ebx
    xor eax,eax
.szamol:
    mov bl,[esi+eax]
    inc eax
cmp bl,0   ;elmegyek a string vegeig amilyen ertek lesz az eax-ben aolyan hosszu a string
    jne .szamol
    pop ebx
    dec eax ;ki kell vonnom eggyet ugyanis jelenleg a 0-at is bele szamolta a hossszaba

ret

StrCat:
    push eax
    push ebx
    push ecx
    xchg esi,edi
    xor ebx,ebx
    xor eax,eax
    call StrLen ;meghivom a strlen fuggvenyt hogy az eax -be keruljon a hosssza igy tudom hogy honnan kezdjem el masolni

.masol:
    mov cl,[edi+ebx]
    mov [esi+eax],cl
    inc ebx
    inc eax
    cmp cl,0
    jne .masol
    pop ecx
    pop ebx
    pop eax
ret

StrUpper:
    push eax
    push ebx
    push ecx
    xor ebx,ebx

.nagybetusit:
    mov al, [esi+ebx]
    cmp al,'a'
        jge .nagy 
.folytat:
    mov [esi+ebx],al
    inc ebx
cmp al,0
    jne .nagybetusit

jmp .vege
.nagy:
cmp al,'z' ;ha nagyobb mint a 'z' akkor nem kell nagybetusiteni
    jg .folytat
sub al, 32
jmp .folytat
.vege:
    pop ecx
    pop ebx
    pop eax

ret


StrLower:
    push eax
    push ebx
    push ecx
    xor ebx,ebx

.kisbetusit:
    mov al, [esi+ebx]
    cmp al,'A'
        jge .kicsi
.folytat:
    mov [esi+ebx],al
    inc ebx
cmp al,0
    jne .kisbetusit

jmp .vege
.kicsi:
cmp al,'Z'
    jg .folytat
add al, 32
jmp .folytat
.vege:
    pop ecx
    pop ebx
    pop eax

ret

StrCompact:
    push eax
    push ebx
    push ecx
    push edx
    xor ebx,ebx
    xor ecx,ecx

.masol:
    mov edx,0
    mov al, [esi+ebx]
    cmp al,' '
        je .torol ;hasonlitom a karakterekhez amiket torolni kell, ha uigy van kitiorlom
    cmp al,9
        je .torol
    cmp al,13
        je .torol
    cmp al,10
        je .torol       

    mov [edi+ecx],al
        inc ebx
    inc ecx
    
cmp al,0
    jne .masol

jmp .vege
.torol:
    inc ebx
    jmp .masol
.vege:
    mov al,0
    mov [edi+ecx],al
    pop edx
    pop ecx
    pop ebx
    pop eax

ret
