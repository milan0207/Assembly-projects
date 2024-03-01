; Koncsard Milan, kmim2248, 512
; LAB4, task 2

; ReadStr(EDI or ESI, max length ECX):()   – C-style (null-terminated binary) string input procedure, reads until <Enter>
; WriteStr(ESI):()                                – string output procedure
; ReadLnStr(EDI or ESI, ECX):()   – similar to ReadStr() but also moves to a new line
; WriteLnStr(ESI):()                            – similar to WriteStr() but also moves to a new line
; NewLine():()                                     – moves the cursor to the beginning of a new line


%include 'mio.inc'

global ReadStr
global WriteStr
global ReadLnStr
global WriteLnStr
global NewLine

section .text

ReadStr:

    push eax
    push ebx

    xor eax,eax
    xor ebx,ebx
mov ebx, 0
.beolvas:
    call mio_readchar
    cmp al,13
        je .vege
    cmp al,8
        je .backspace
    call mio_writechar
    mov [esi+ebx],al
      inc ebx
jmp .beolvas

jmp .vege
.backspace:  ; Backspace handling
    cmp ebx, 0 ; Compare to check if I'm at position 0, do nothing if at the starting position
    je .beolvas
    call mio_writechar  ; Write the backspace character, the cursor moves back one position
    mov al, ' ' ; Write a space to erase the displayed character
    call mio_writechar
    mov al, 8
    call mio_writechar ; Move the cursor back again
    dec ebx
jmp .beolvas


.vege:
    mov al,0
    
cmp ebx,ecx
jg .hosszu
mov [esi+ebx],al

jmp .end
.hosszu:
mov [esi+ecx],al
   
.end: 
    pop ebx
    pop eax



ret


WriteStr:
mov edx,esi
push ebx    
push ecx
xor ecx,ecx
xor ebx,ebx

.kiiras:

mov al,[edx+ebx]  ; Move forward from the zeroth position in the line until reaching the binary 0
call mio_writechar
inc ebx
cmp al,0
jne .kiiras

pop ebx
pop ecx

ret

ReadLnStr:
    push eax
    push ebx

    xor eax,eax
    xor ebx,ebx
mov ebx, 0
.beolvas:
    call mio_readchar
    cmp al,13
        je .vege
    cmp al,8
        je .backspace
    call mio_writechar
    mov [esi+ebx],al
      inc ebx
jmp .beolvas

jmp .vege
.backspace:
    cmp ebx,0
je .beolvas
    call mio_writechar
    mov al, ' '
    call mio_writechar
    mov al, 8
     call mio_writechar
    dec ebx
jmp .beolvas

.vege:
    mov al,0
cmp ebx,ecx
jg .hosszu
mov [esi+ebx],al

jmp .end
.hosszu:
mov [esi+ecx],al
   
.end: 
     mov     al, 13             
    call    mio_writechar
    mov     al, 10              
    call    mio_writechar
    pop eax
    pop ebx
    


ret

WriteLnStr:

mov edx,esi
push ebx
push ecx
xor ecx,ecx
xor ebx,ebx

.kiiras:

mov al,[edx+ebx]
call mio_writechar
inc ebx
cmp al,0
jne .kiiras

 mov     al, 13             
    call    mio_writechar
    mov     al, 10              
    call    mio_writechar   
pop ebx
pop ecx

ret

NewLine:
    push eax
    mov     al, 13             
    call    mio_writechar
    mov     al, 10              
    call    mio_writechar  
    pop eax
    ret


