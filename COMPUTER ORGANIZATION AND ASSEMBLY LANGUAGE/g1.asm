[org 0x0100]
num db 10,25,15
mov ax,25h
mov bx,0
mov cx,0x270

mov ax,cx
mov ax,bx
mov bx,cx

mov ax,[num]
mov ax,[num+2]
mov ax,[num+4]

mov ax,[num+4]
mov ax,[num+2]
mov ax,[num]


mov ax,0x4c00
int 0x21