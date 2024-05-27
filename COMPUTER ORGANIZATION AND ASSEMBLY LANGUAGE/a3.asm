[org 0x0100]



jmp start

sr:
push bp
mov bp,sp
sub sp,2
mov word[bp-2],0
l1:

add word[bp-2],1
add cx,[bp-2]
cmp [bp-2],dx
jne l1
l2:
sub word[bp-2],1
cmp word[bp-2],1
jae ct
jmp here

ct:
add cx,[bp-2]
jmp l2

here:

inc bx
inc dx
mov word[bp-2],0
cmp bx,ax
jne l1
mov sp,bp
pop bp
ret 2

start:

mov ax,5
add ax,7
mov bx,1
mov cx,0
mov dx,1
add ax,1
call sr

mov ax,0x4c00
int 0x21