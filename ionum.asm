;Koncsard Milan, kmim2248, 512
;LAB4, task 1

;ReadInt():(EAX)                  – Read a 32-bit signed integer
;WriteInt(EAX):()                  – Write a 32-bit signed integer
;ReadInt64():(EDX:EAX)      – Read a 64-bit signed integer
;WriteInt64(EDX:EAX):()      – Write a 64-bit signed integer
;ReadBin():(EAX)                 – Read a 32-bit positive binary integer
;WriteBin(EAX):()                 – Write a 32-bit positive binary integer
;ReadBin64():(EDX:EAX)     – Read a 64-bit positive binary integer
;WriteBin64(EDX:EAX):()     – Write a 64-bit positive binary integer
;ReadHex():(EAX)                – Read a 32-bit positive hexadecimal integer
;WriteHex(EAX):()                – Write a 32-bit positive hexadecimal integer
;ReadHex64():(EDX:EAX)     – Read a 64-bit positive hexadecimal integer
;WriteHex64(EDX:EAX):()     – Write a 64-bit positive hexadecimal integer




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

ReadInt:            ;Reads a 32 bit number
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
    mov edi,1      ;This register changes to -1 if the number is negative
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
    mov edi,-1      ;If the number is negative, then I multiply it by -1 after the construction.
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
        add eax,48  ;We convert the character to its digit.
        call mio_writechar
        dec ecx
        cmp ecx, 0
        jne .kiiras

jmp .vege
.minus:
mov ebx,eax
mov al, '-' ;We print the '-' (negative sign) character.
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
sub bl,7  ;We always subtract enough so that after subtracting 48, the value of the number remains.
jmp .folytat

jmp .vege
.kerdes2:
cmp bl, 'a'
jl .hiba
cmp bl, 'f'
jg .hiba
sub bl, 39  ;We always subtract enough so that after subtracting 48, the value of the number remains.
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
        mov cl,[esi+edi]  ;I put my characters into the CL register because the other registers are occupied.
        inc edi
        mov ebx,10
        cmp cl,0
            je .vege
        cmp cl,'0'
             jl .hiba
        cmp cl, '9'
            jg .hiba
        sub cl,48     ;We subtract the character to obtain the numerical value.
        imul edx, 10  ; Multiply edx by 10
        jo .hiba      ; Jump to .hiba if there is an overflow in this register
        push edx      ; Save the current content of edx
        xor edx, edx  ; Clear edx
        mul ebx       ; Multiply by 10 (value of 10 is in ebx)
        add eax, ecx  ; Add the read number to the current value in eax
        adc edx, 0    ; Add the carry bit to edx if there is one
        pop ecx       ; Retrieve the saved number
        add edx, ecx  ; Add the overflowed number to the previous content of edx
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
NOT edx ; Perform these operations if a negative number is read
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
    mov [a], eax   ; Save the content of eax
    mov eax, edx   ; Move the content of edx to eax
    xor edx, edx   ; Clear edx
    mov ebx, 10    
    div ebx        ; Divide eax by 10
    mov [b], eax   ; Save the result in [b]
    mov eax, [a]   ; Restore the original content of eax
    div ebx        ; Divide eax by 10
    push edx       ; Push the digits onto the stack
    mov edx, [b]   ; Restore the content of edx
    inc ecx
cmp eax,0
jne .verembe

.kiir:
    .kiiras: ;Simple write out with help of the stack
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
mov al, '-' ; If the number is negative, print '-' and negate the number
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
            jne .hiba ; If not 0 or 1, the character is an error
        .folytat:
        sub bl,48 
       shl edx,1
        shl eax,1
        adc edx,0  ; Simple: always add the carry bit to edx
        
        add al,bl
        adc edx,0
       cmp ecx,64 ; If more than one character is read, it's an error
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
mov ecx, 64 ; Print something 64 times, whether it's zero or one

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
   shl eax,1 ; Shift eax left and add it to the content of edx, representing a digit in base-16
        ; To shift all parts, it needs to be shifted four times for a digit in base-16

   adc edx,0
   ;1x
   shl edx,1
   
   shl eax,1
   adc edx,0
   ;2x
   shl edx,1
   
   shl eax,1
   adc edx,0
   ;3x
   shl edx,1
   
   shl eax,1
   adc edx,0
;4x
    add eax,ebx ; Add the read digit to eax
   adc edx,0
   cmp ecx,16
       jg .hiba
    jmp .beolvas

jmp .vege
.kerdes:            ; This part is the same as in the 32-bit version
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
mov ecx, 16 ; Because we need to print 16 digits

.kiir:
xor eax,eax
shl edx,1
adc eax,0
shl eax,1
               ; The basic idea is the same as during input. However, I shift the register content to the left and construct the first 4 bits.
shl ebx, 1      ; Shift ebx left
; Another register will be used to build the appropriate data by applying the corresponding algorithm, and then I will print it.

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
jle .szam_ki ; If the digit is 48, add it to the content
cmp al,15
	jle .nagybetu_ki    ; If the digit is represented by a letter, add 55 to the content
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

