[org 0x0100]
mov ax,0x5625
mov bx,ax
OR bx,ax
XOR ax,0x1BCD
AND bx,ax
mov [f],bx
mov ax,0x4c00
int 0x21

f: dw 0