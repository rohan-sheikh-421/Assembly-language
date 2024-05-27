[org 0x0100]
mov ax, 0101011000100101b
mov bx, 1100110011001100b
mov dx, 0011001100110011b
mov bx,ax
mov dx,ax
shr bx,2
shl dx,2
OR bx,dx
mov ax,bx

mov ax,0x4c00
int 0x21
