[org 0x0100]
jmp start
n1 : dw 1
n2 : dw 2
n3 : dw 3
n4 : dw 4
n5 : dw 5
n: dw 1,2,3,4,5
sum: dw 0

start:
mov ax,0
add ax,[n1]
add ax,[n2]
add ax,[n3]
add ax,[n4]
add ax,[n5]
mov [sum],ax
mov ax,0

mov ax,0x4c0
int 0x21
