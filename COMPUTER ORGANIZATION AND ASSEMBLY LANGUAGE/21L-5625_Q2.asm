[org 0x0100]

jmp start

num: db 8

start:
    mov ax,0
    mov bl,[num] ;multipler
    mov cx,0
    mov dl, [num] ;multiplicand
    mov dh,0

l1:
    shr bl,1
    jnc noadd

    add ax,dx

noadd:
       shl dx,1
       add cx,1
       cmp cx,7
       jne l1


mov ax,0x4c00
int 0x21