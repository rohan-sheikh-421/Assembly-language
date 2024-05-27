[org 0x0100]

mov ax, 0x5625
mov cx, 0

loop1:
ror ah,1
ror al,1

add cx,1
cmp cx,4
jne loop1

mov ax,0x4c00
int 0x21