;program to print first 10 terms of fibonacci series
[org 0x0100]
jmp start
fib_nums : dw 0,0,0,0,0,0,0,0,0,0  ;terms to be saved at index locations
start:
mov bx,0
mov ax,0
l1:mov[fib_nums+bx],ax
add bx,2
add ax,1
cmp bx,4
jne l1
mov si,0
mov ax,[fib_nums + si]
add si,2
mov dx,[fib_nums + si]
l2:
add ax,dx
mov [fib_nums+bx],ax
mov dx,[fib_nums + si]
add si,2
add bx,2
cmp bx,16
jne l2
mov ax,0x4c00
int 0x21