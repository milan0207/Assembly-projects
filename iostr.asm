;Koncsard Milan, kmim2248, 512
;LAB4, feladat 2

;ReadStr(EDI vagy ESI, ECX max. hossz):()   – C-s (bináris 0-ban végződő) stringbeolvasó eljárás, <Enter>-ig olvas
;WriteStr(ESI):()                                – stringkiíró eljárás
;ReadLnStr(EDI vagy ESI, ECX):()   – mint a ReadStr() csak újsorba is lép
;WriteLnStr(ESI):()                            – mint a WriteStr() csak újsorba is lép
;NewLine():()                                     – újsor elejére lépteti a kurzort


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
.backspace:  ;backspace kezeles
    cmp ebx,0 ;osszehasonlitom hogy hanyadik helyen vagyok, nem csinalok semmit ha mar startbol a 0dik helyen vagyok
je .beolvas
    call mio_writechar  ;kiirom a backspace karaktert, a kurzos visszaugrik eggyet
    mov al, ' ' ;kiirom egy szokkozt h torolje le a kiirt karatkert
    call mio_writechar
    mov al, 8
     call mio_writechar ;visszaleptetem a kurzort ujbol
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

mov al,[edx+ebx]  ;a nulladik helyrol sorban megyek elore egesz a binaris 0-ig
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


