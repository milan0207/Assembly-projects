;Koncsard Milan, kmim2248, 512
;LAB4, feladat 1

;ReadInt():(EAX)                  – 32 bites előjeles egész beolvasása
;WriteInt(EAX):()                  – 32 bites előjeles egész kiírása
;ReadInt64():(EDX:EAX)      – 64 bites előjeles egész beolvasása
;WriteInt64(EDX:EAX):()      – 64 bites előjeles egész kiírása
;ReadBin():(EAX)                 – 32 bites bináris pozitív egész beolvasása
;WriteBin(EAX):()                 –                    - || -                   kiírása
;ReadBin64():(EDX:EAX)     – 64 bites bináris pozitív egész beolvasása
;WriteBin64(EDX:EAX):()     –                    - || -                   kiírása
;ReadHex():(EAX)                – 32 bites pozitív hexa beolvasása
;WriteHex(EAX):()                –                    - || -                   kiírása
;ReadHex64():(EDX:EAX)     – 64 bites pozitív hexa beolvasása
;WriteHex64(EDX:EAX):()     –                    - || -                   kiírása




;.\nasm.exe -f win32 iostr.asm
;.\nasm.exe -f win32 ionum.asm
;.\nlink.exe iostr.obj ionum.obj -lmio -o ionum.exe
; .\ionum.exe

%include 'mio.inc'
%include 'iostr.inc'

global ReadInt
global WriteInt
global WriteInt
global ReadBin
global WriteBin
global ReadHex
global WriteHex

global ReadInt64
global WriteInt64
global WriteInt64
global ReadBin64
global WriteBin64
global ReadHex64
global WriteHex64

section .text~

ReadInt:        ;32 bites beolvasas
    push ebx
    push ecx
    push edx
    xor edx,edx
    xor eax,eax
    xor ebx,ebx
    mov esi,stra  
    mov ecx, 255
    call ReadStr
    xor ecx,ecx
    mov edi,1 ;ez a valtozo -1 re valtozik ha a szam negativ
    mov bl, [esi]
    cmp bl, '-'
    je .minus
    .felepit:
        mov bl, [esi+ecx]
        inc ecx
        cmp bl,0
            je .vege
        cmp bl,'0'
             jl .hiba
        cmp bl, '9'
            jg .hiba
        sub bl,48
        imul eax,10
        jo .hiba
        
        add eax,ebx
        jo .hiba
        jmp .felepit
    
jmp .vege
.minus:
    mov edi,-1 ;ha a szam negativ akkor -1 el szorzom be a felepites utan
    inc ecx
    jmp .felepit
    jmp .vege
.hiba:
STC
jmp .end
.vege:
    imul eax,edi
.end:
pop edx
    pop ecx
     pop ebx

ret

WriteInt:
    push ebx
    push ecx   
    push edx
    xor ecx,ecx
cmp eax,0
    jl .minus
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
        add eax,48  ;at alakitjuk szamjeggye a karaktert
        call mio_writechar
        dec ecx
        cmp ecx, 0
        jne .kiiras

jmp .vege
.minus:
mov ebx,eax
mov al, '-' ;kiirjuk a - karaktert
call mio_writechar
mov eax,ebx
imul eax,-1  
  jmp .verembe   
.vege:
    pop edx
    pop ecx
    pop ebx
ret

ReadBin:
    xor eax,eax
    push ebx
    push ecx
    push edx
    mov ecx,256
    mov esi,stra

    call ReadStr
    xor ecx,ecx
    .beolvas:
        mov bl,[esi+ecx]    
        inc ecx
        cmp bl, 0
            je .vege
        cmp bl,'0'
            jne .hiba
        .folytat:
        sub bl,48
       
        shl eax,1  
        
        add al,bl
       cmp ecx,32
       jg .hiba2
    jmp .beolvas


jmp .vege
.hiba:
cmp bl, '1'
     je .folytat
.hiba2:
STC
.vege:
pop edx
pop ecx
pop ebx
ret

WriteBin:
push ebx
push ecx
push edx

mov ebx,eax
xor eax,eax
mov ecx, 8

.cimke:
	SHL ebx,1
	adc eax,48
	
	call mio_writechar
	xor eax,eax
	SHL ebx,1
	adc eax,48
	
	call mio_writechar
	xor eax,eax
	SHL ebx,1
	adc eax,48
	
	call mio_writechar
	xor eax,eax
	SHL ebx,1
	adc eax,48
	
	call mio_writechar
	xor eax,eax
    mov eax, ' '
    call mio_writechar
	xor eax,eax
loop .cimke


pop edx
pop ecx
pop ebx
ret

ReadHex:
push ebx
push ecx
push edx

xor eax,eax
mov ecx,256
mov esi,stra
call ReadStr
xor ecx,ecx
.beolvas:
    mov bl, [esi+ecx]
    inc ecx
        cmp bl, 0
    je .vege
    
    cmp bl, '0'
    jl .hiba

    cmp bl, '9'
    jg .kerdes
.folytat:
    sub bl, 48
   SHL eax,4
   jo .hiba
    add al,bl
    jo .hiba
    jmp .beolvas

jmp .vege
.kerdes:
cmp bl,'A'
jl .hiba
cmp bl, 'F'
jg .kerdes2
sub bl,7  ;mindig annyit vonok ki, hogy a 48 kivonasa utan legyen meg a szamos erteke
jmp .folytat

jmp .vege
.kerdes2:
cmp bl, 'a'
jl .hiba
cmp bl, 'f'
jg .hiba
sub bl, 39  ;mindig annyit vonok ki, hogy a 48 kivonasa utan legyen meg a szamos erteke
jmp .folytat 

jmp .vege
.hiba:
stc


.vege:
pop edx
pop ecx
pop ebx
ret

WriteHex:
push ebx
push ecx
push edx

mov ebx,eax
cmp eax,0
	je .vege
	mov eax,'0'
	call mio_writechar
	mov eax, 'x'
	call mio_writechar
	xor ecx,ecx
    mov eax,ebx
.verembe:
    mov ebx,eax
    AND ebx, 15
    push ebx
    shr eax,4
    add ecx,1
    cmp ecx, 8
    jne .verembe

.kiiras:	
	
	xor eax,eax
	pop eax
	cmp al, 9
	jle .szam_ki
	cmp al,15
	jle .nagybetu_ki
	
	.muv:
	call mio_writechar
	sub ecx,1
	cmp ecx, 0
	jne .kiiras
	jmp .vege
	
	jmp .vege
	
	.szam_ki:
	add eax,48
	jmp .muv
	
	.kisbetu_ki:
	add eax,87
	jmp .muv
	
	.nagybetu_ki:
	add eax, 55
	jmp .muv
	jmp .vege


.vege:
pop edx
pop ecx
pop ebx
ret


ReadInt64:
push ebx
push ecx
push edi
xor eax,eax
mov ecx,256
mov esi, stra
call ReadStr
xor ecx,ecx
xor edi,edi
xor ebx,ebx
xor edx,edx
    
    mov cl, [esi]
    cmp cl, '-'
    je .minus2
    .felepit2:
    xor ecx,ecx
        mov cl,[esi+edi]  ;cl be rakom a karaktereimet mert a tobbi regiszter foglalt
        inc edi
        mov ebx,10
        cmp cl,0
            je .vege
        cmp cl,'0'
             jl .hiba
        cmp cl, '9'
            jg .hiba
        sub cl,48 ;kivonjuk a karaktert hogy a szam ertek legyen benne
        imul edx,10 ;beszorozzuk az edx- et 10-el
        jo .hiba  ;ha ez a regiszter is tulcsordul abban az esetben van csak overflow
        push edx  ;elmentjuk az edx jelenlegi tartalmat
        xor edx,edx ;lenulazzuk
        mul ebx ;beszorozzuk 10-el, ebx-ben a 10 talalhato itt
        add eax,ecx ;osszeadom a beolvasott szamot az eax tartalmaval
        adc edx,0  ;ha van kifuto bit hozza adom az edx-hez
        pop ecx ;kiszedem az elmentett szamomat
        add edx,ecx ;osszeadom a tucsordult szamot az edx elozo tartalmaval
        jo .hiba    
        jmp .felepit2
    
jmp .vege
.minus2:
    inc edi
    mov ebx,-1
    mov [elojel],ebx
    jmp .felepit2
jmp .vege
.hiba:
STC
jmp .end
.vege:
mov ecx, [elojel]
cmp ecx, -1
je .negalas
clc
jmp .end
.negalas:
NOT edx ;ha negativ szamot olvasok be ezek a muveletek hajtodnak vegre
NOT eax 
add eax,1
adc edx, 0
.end:
pop edi
pop ecx
pop ebx
ret

WriteInt64:
push ebx
push ecx
push edi
xor ecx,ecx
xor edi,edi
xor ebx,ebx

cmp edx,0
    jl .minus3


.verembe:
mov [a],eax ;elmentem az eax tartalmat
mov eax,edx ;atkoltoztetem az edx et az eax-be
xor edx,edx
mov ebx,10 
div ebx ;oszom az eax-et 10-el 
mov [b],eax 
mov eax,[a]
div ebx
push edx ;a verembe hajitom a szamjegyeimet
mov edx,[b]
inc ecx
cmp eax,0
jne .verembe

.kiir:
    .kiiras: ;innen pedig mar csak egy egyszeru vere-kiiras
        xor eax,eax
        pop eax
        add eax,48
        call mio_writechar
        dec ecx
        cmp ecx, 0
        jne .kiiras

jmp .vege
.minus3:
mov ebx,eax
mov al, '-' ;ha negativ a szamom akkor kiirom a - t es negalom a szamomat
call mio_writechar
mov eax,ebx
NOT edx
NOT eax
add eax,1
adc edx,0
  jmp .verembe 
.vege:
pop edi
pop ecx
pop ebx
ret

ReadBin64:
    xor eax,eax
    push ebx
    push ecx
    mov ecx,256
    mov esi,stra
    xor ebx,ebx
    xor edx,edx
    call ReadStr
    xor ecx,ecx
    .beolvas:
        mov bl,[esi+ecx]    
        inc ecx
        cmp bl, 0
            je .vege
        cmp bl,'0'
            jne .hiba ;ha nem 0 vagy 1 es a karakter hiba
        .folytat:
        sub bl,48 
       shl edx,1
        shl eax,1
        adc edx,0  ;egyszeru mindig a carrybe kifuto bitet hozza adom az edx-hez
        
        add al,bl
        adc edx,0
       cmp ecx,64 ;ha tobb mint karaktert olvastak be, akkor hiba
       jg .hiba2
    jmp .beolvas


jmp .vege
.hiba:
cmp bl, '1'
     je .folytat
.hiba2:
STC
.vege:
pop ecx
pop ebx
ret

WriteBin64:
push ebx
push ecx
push edi
xor edi,edi
xor ecx,ecx
xor ebx,ebx
mov ebx,eax
xor eax,eax
mov ecx, 64 ;64 szer kell kiirni valamit, ha nullas ha 1 es

.cimke:
shl edx, 1
adc eax,48
call mio_writechar
xor eax,eax
shl ebx, 1
adc edx,0
loop .cimke

pop edi
pop ecx
pop ebx
ret

ReadHex64:
push ebx
push ecx
push edi

xor eax,eax
mov ecx,256
mov esi,stra
call ReadStr
xor ecx,ecx
xor ebx,ebx
xor edx,edx
.beolvas:
    mov bl, [esi+ecx]
    inc ecx
        cmp bl, 0
    je .vege
    
    cmp bl, '0'
    jl .hiba

    cmp bl, '9'
    jg .kerdes
.folytat:
    sub bl, 48
   shl edx,1
   shl eax,1 ;egyenkent shiftelem az eax-et es hozza adoim az edx regiszter tartalmahoz egy 16-os szamrendszerbeli 
                ;szamjegyhez 4-szer kell shiftelni ahoz hogy mind az osszes reszet shifteljuk
   adc edx,0
   ;1szer
   shl edx,1
   
   shl eax,1
   adc edx,0
   ;2szer
   shl edx,1
   
   shl eax,1
   adc edx,0
   ;3szor
   shl edx,1
   
   shl eax,1
   adc edx,0
;4szer
    add eax,ebx ;hozza adom az eax-hez a beolvasott szamjegyet
   adc edx,0
   cmp ecx,16
       jg .hiba
    jmp .beolvas

jmp .vege
.kerdes:            ;ez a resze ugyanaz mint a 32 bitesnel
cmp bl,'A'
jl .hiba
cmp bl, 'F'
jg .kerdes2
sub bl,7
jmp .folytat

jmp .vege
.kerdes2:
cmp bl, 'a'
jl .hiba
cmp bl, 'f'
jg .hiba
sub bl, 39
jmp .folytat 

jmp .vege
.hiba:
stc


.vege:

pop edi
pop ecx
pop ebx
ret

WriteHex64:
push ebx
push ecx
push esi
push edi
mov ebx,eax
    mov eax,'0'
	call mio_writechar
	mov eax, 'x'
	call mio_writechar
xor esi,esi
xor edi,edi
xor eax,eax
mov ecx, 16 ;16 szamjegyet kell kiirnunk

.kiir:
xor eax,eax
shl edx,1
adc eax,0
shl eax,1
                ;az alap otlet ugyanaz mint a beolvasasnal viszont shiftelem balra a regiszter tartalmat majd felepitem az elso 4 bit 
shl ebx,1       ; et egy masik regiszterbe, amit majd a megfelelo algortimussal, hozza adva a megfelelo adatokat kiirok
adc edx,0

shl edx,1
adc eax,0
shl eax,1

shl ebx,1
adc edx,0

shl edx,1
adc eax,0
shl eax,1

shl ebx,1
adc edx,0

shl edx,1
adc eax,0

shl ebx,1
adc edx,0


cmp eax,9
jle .szam_ki ;ha szamjegy 48 at kell hozza adni
cmp al,15
	jle .nagybetu_ki    ;ha betuvel jeloljuk a szamjegyet akkor  55 -ot kell hozza adni
.muv:
call mio_writechar


loop .kiir

jmp .vege
.szam_ki:
	add eax,48  
	jmp .muv
.nagybetu_ki:
	add eax, 55
	jmp .muv
.vege:
pop edi
pop esi
pop ecx
pop ebx
ret


section .data   
mentes dd 0
elojel dd 1
a dd 0
b dd 0
section .bss

stra resb 256

