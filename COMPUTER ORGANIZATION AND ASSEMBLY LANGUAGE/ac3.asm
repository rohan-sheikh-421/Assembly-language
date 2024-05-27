[org 0x0100]

jmp start

arr: db 0,0,0,0
larr: dw 4
rnum: dw 0x5625
s1: db 'My name is Rohan'
l1: dw 21
s2: db 'COAL lab is tough' 
l2: dw 26

clrscr:
push es
push ax
push di

mov ax, 0xb800
mov es,ax
mov di,0

nextloc:
mov word[es:di],0x5625
add di,2
cmp di,4000
jne nextloc

pop di
pop ax
pop es

ret

ascii_convert:
mov si,3
mov ax,[rnum]
mov bl,al

shl bx,4
shl bl,4
add bx,3030h
mov byte[arr+si],bl
sub si,1
mov byte[arr+si],bh
sub si,1

mov bx,0
mov bl,ah
shl bx,4
shr bl,4

add bx,3030h
mov byte[arr + si],bl
sub si,1
mov byte[arr +si],bh

ret

print:
mov si,0
mov si,o
mov bp,sp 
mov di,0
mov ax,0xb800
mov es,ax
mov bx,s1
mov cx,[l1]
mov ah,0x07

loop1:
mov al[bx+si]
mov[es:di],ax
add di,2
add si,1
add bx,1
cmp si,cx
jb loop1

mov si,0
mov bx,arr
mov cx,[larr]

loop2:
mov al,[bx+si]
mov[es:di],ax
add di,2
add si,1
add bx,1
cmp si,cx
jb loop2

mov si,0
mov bx,s2
mov cx,[l2]

loop3:
mov al,[bx+si]
mov[es:di],ax
add di,2
add si,1
add bx,1
cmp si,cx
jb loop3

ret

start:

call clrscr
call ascii_convert

mov ax,s1
push ax
push word[l1]

mov ax,arr
push ax
push word[larr]
mov ax,s2
push ax
push word[l2]

call print

mov ax,0x4c00
int 21h
