[org 0x0100]
 jmp start
array: dw 111.999,888,888,11,99,88,88,1,9,8,8

start:
add cx,200
mov cx,cx
mov ax,0
mov bx,0
loop1:
add ax[array+bx]
add bx,2
mov dx,0
add dx,cx
add dx,ax
mov dx,ax
cmp bx,24
je loop1

mov ax,0x4c00
int 0x21
 