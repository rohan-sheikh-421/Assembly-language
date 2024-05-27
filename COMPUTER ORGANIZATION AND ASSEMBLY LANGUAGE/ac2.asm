[org 0x0100]
jmp start
arr:db 0,0,0,0
rnum: dw 0x5625
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

start:

call ascii_convert
mov ax,0x4c00
int 21h 


start:
call clrscr

mov ax,5625h
push ax
call printnum

mov ax,0x4c00
int 0x21