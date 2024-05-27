[org 0x0100]

jmp start

arr: db 0,0,0,0
rnum: dw 5625

sep:
mov si,3
mov ax,[rnum]
mov bl,al
ahl bx,4
shr bl,4
mov byte[arr+si],bl
sub si,1
mov byte[arr+si],bh
sub si,1
mov bx,0
mov bl,ah
shl bx,4
shr bl,4
mov bytle[arr+si],bl
sub si,1
mov byte[arr+si],bh
ret

r:
loop1:
add bx,[arr+si]
add si,1
cmp,4
jb r

shr bx,2
ret

l:
add bx,2
ret

start:
call sep
mov bx,0
mov si,0
call r
call l

mov ax,0x4c00
int 21h