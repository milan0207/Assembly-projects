; StrLen(ESI):(EAX)              – Returns the length of the string pointed to by ESI in EAX, excluding the binary 0
; StrCat(EDI, ESI):()             – Concatenates the strings pointed to by ESI and EDI (copies ESI after EDI)
; StrUpper(ESI):()                 – Converts the string pointed to by ESI to uppercase
; StrLower(ESI):()                 – Converts the string pointed to by ESI to lowercase
; StrCompact(ESI, EDI):()      – Copies the string pointed to by ESI to EDI, excluding space, tab (9), carriage return (13), and line feed (10) characters

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
cmp bl,0   ; I go through the string until the value in EAX, which represents the length of the string
    jne .szamol
    pop ebx
    dec eax ; I need to subtract one because it currently includes the binary 0 in its length

ret

StrCat:
    push eax
    push ebx
    push ecx
    xchg esi,edi
    xor ebx,ebx
    xor eax,eax
    call StrLen ; I call the strlen function to get its length in EAX, so I know where to start copying

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
cmp al,'z' ; If greater than 'z', no need to convert to uppercase
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
        je .torol ; Compare with the characters to be deleted, if they match, erase them
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
