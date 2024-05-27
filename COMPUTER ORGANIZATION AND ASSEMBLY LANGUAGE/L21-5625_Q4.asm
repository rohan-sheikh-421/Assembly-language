; 16bit multiplication using test for bit testing
[org 0x0100]

jmp start
    num: db 6; 16bit multiplicand 
    fact: dw 0 ; 32bit result
start:
    mov ax,1 ; current number
    mov bx,1 ; second number
    mov dx,0 ; result register
    mov cx,8 ; current multiplication counter
    mov si,0 ; factorial multiplication counter
l1:
    shr bx,1
    jnc l2

    add dx,ax

l2:
    shl ax,1
    dec cx
    jnz l1 


l3:
    mov ax,dx
    inc si 
    mov bx,si
    mov cx,8
    cmp si,[num]
    jne l1

mov [fact],dx

mov ax, 0x4c00 
int 0x21