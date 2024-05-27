[org 0x0100]

mov ax, 200h
mov bx, 150h
mov cx, [0x200]
mov dx, [0x250]

mov cx,cx
mov dx,dx

mov dx, 50h
mov cx, 25h

mov ax, cx
mov cx, dx

mov ax, 0x4c00
int 0x21



