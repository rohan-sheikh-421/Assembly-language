[org 0x0100]

jmp start
fr:dd 0
dn:dd 0
rn:dw 1774

homo:
mov word ax, [rn]
mov bx, ax
not bx
mov [dn], al
mov [dn + 1],ah
mov [dn+2],bl
mov [dn+3],bh
mul bx
mov [fr],ax
mov bx, [dn]
add [fr],bx
mov bx, [dn + 2]
add [fr+2],bx
ret

start: 
call homo
mov ax,0x04c00
int 21h
