[org 0x0100]
jmp code
w equ 70 ; width offset
x equ 50 ; starting x coordinate of line
y equ 100
c equ 60 ; color
code: 
    mov ah, 0
    mov al, 13h
    int 10h
    ; draw diagonal 11:
    mov cx, x
    mov dx, y
    mov al, c 
    u1:
    inc dx
    mov ah, 0ch ; put pixel
    int 10h
    inc cx
    cmp cx, x+w
    jbe u1

    mov ah,0ch
    int 10h


    u2:
    inc cx
    mov ah,0ch
    int 10h
    dec dx
    cmp dx,y
    jne u2


    u3:
        dec dx
        mov ah,0ch
        int 10h
        dec cx
        cmp cx,x+w
        jne u3


    u4:
        inc dx
        mov ah,0ch
        int 10h
        dec cx
        cmp dx,y
        jne u4
;wait for keypress
mov ah,00
int 16h
mov ax,0x4c00
int 21h
