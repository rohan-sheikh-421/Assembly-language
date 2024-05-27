[org 0x0100]
jmp start
x24: dw 48,47,44,40,36,30,24,17,12,7,3,0,0,0,3,7,11,17,23,30,36,40,44,47,48 
y24: dw 24,30,36,40,44,47,48,47,44,40,36,30,24,17,11,7,3,0,0,0,3,7,11,17,23
counter: dw 0
radius: dw 0 ; choose radius(24, 45, 72, 120) 
xoffset: dw 50
yoffset: dw 50
draw_tri:
    push bp
    mov bp,sp
    push ax
    push bx
    push cx
    push dx
    push si
    push di

    mov cx,[bp + 16]
    mov dx,[bp + 14]
    mov ax,[bp + 4]
    mov ah,0x0c

    tl1:
        call delay
        int 10h
        sub cx,1
        add dx,1
        cmp dx,[bp + 10]
        jne tl1

    mov cx,[bp + 12]
    mov dx,[bp + 10]

    tl2:
        call delay
        int 10h
        add cx,1
        cmp cx,[bp + 8]
        jne tl2


    mov cx,[bp + 16]
    mov dx,[bp + 14]

    tl3:
        call delay
        int 10h
        add cx,1
        add dx,1
        cmp dx,[bp + 6]
        jne tl3

    

    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    pop bp
    ret 14


draw_circle:
    push bp
    mov bp,sp
    push ax
    push bx
    push cx
    push dx
    push si
    push di

    mov si, [bp + 8] ; change x array as radius
    mov di, [bp + 6] ; change y array as radius
    mov ax,[bp + 4] ; put pixel in white color 
    xor bx, bx ; page number 0
    mov cx, [si] ; first x position
    add cx, [xoffset] ; moving point along x axis
    mov dx, [di] ; first y position 
    add dx, [yoffset] ; moving point along y axis 
    l1:
        mov ax,[bp + 4]
        mov ah,0x0c
        int 0x10 ; bios video services
        add si, 2 ; next location address
        add di, 2 ; next location address
        mov cx, [si] 
        add cx, [xoffset] 
        mov dx, [di]
        add dx, [yoffset]
        inc word[counter]
        mov ax,[radius]
        cmp word[counter], ax
        jle l1

    mov word[counter],0
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    pop bp
    ret 6
delay:
    push cx
    push dx
    push ax

    MOV     CX, 00H
    MOV     DX, 1000
    MOV     AH, 86H
    INT     15H

    pop ax
    pop dx
    pop cx
    ret

draw_rect:
    push bp
    mov bp,sp
    push ax
    push bx
    push cx
    push dx
    push si
    push di

    mov cx,[bp + 12]
    mov dx,[bp + 10]
    mov ax,[bp + 4]
    mov ah,0x0c

    rl1:
        call delay
        int 10h
        add cx,1
        cmp cx,[bp + 8]
        jne rl1

    mov cx,[bp + 8]
    mov dx,[bp + 10]

    rl3:
        call delay
        int 10h
        add dx,1
        cmp dx,[bp + 6]
        jne rl3
    

    mov cx,[bp + 8]
    mov dx,[bp + 6]
    rl2:
        call delay
        int 10h
        sub cx,1
        cmp cx,[bp + 12]
        jne rl2


    mov cx,[bp + 12]
    mov dx,[bp + 6]

    rl4:
        call delay
        int 10h
        sub dx,1
        cmp dx,[bp + 10]
        jne rl4

    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    pop bp
    ret 10

start:
    mov ax,0x0010
    int 10h
    mov ah,0
    int 16h


    push word 0 
    push word 175
    push word 639 
    push word 349 
    push word 0x07
    call draw_rect

    push word 245
    push word 100
    push word 395
    push word 175
    push word 0x07
    call draw_rect

    push word 320
    push word 10
    push word 235
    push word 95
    push word 405
    push word 95
    push word 0x06
    call draw_tri

    push word 305
    push word 125
    push word 335
    push word 175
    push word 0x07
    call draw_rect

    mov cx,295
    mov dx,175
    mov si,0
    mov ax,0x0c07
    sl1:
        call delay
        int 0x10
        add si,1
        cmp si,4
        jne skip_sl1
        sub cx,1
        mov si,0
        skip_sl1:
            add dx,1
            cmp dx,350
            jne sl1

    mov cx,345
    mov dx,175
    mov si,0
    mov ax,0x0c07
    sl2:
        call delay
        int 0x10
        add si,1
        cmp si,4
        jne skip_sl2
        add cx,1
        mov si,0
        skip_sl2:
            add dx,1
            cmp dx,350
            jne sl2

    push word 255
    push word 125
    push word 275
    push word 140
    push word 0x01
    call draw_rect

    push word 365
    push word 125
    push word 385
    push word 140
    push word 0x01
    call draw_rect

    push word 75
    push word 170
    push word 90
    push word 210
    push word 0x07
    call draw_rect

    mov word[xoffset],60
    mov word[yoffset],120
    mov word[radius],24
    push x24
    push y24
    push word 0x07
    call draw_circle

    mov word[xoffset],35
    mov word[yoffset],140
    mov word[radius],24
    push x24
    push y24
    push word 0x07
    call draw_circle

    mov word[xoffset],84
    mov word[yoffset],140
    mov word[radius],24
    push x24
    push y24
    push word 0x07
    call draw_circle


    mov word[xoffset],30
    mov word[yoffset],290
    mov word[radius],24
    push x24
    push y24
    push word 0x07
    call draw_circle


    mov word[xoffset],500
    mov word[yoffset],10
    mov word[radius],24
    push x24
    push y24
    push word 0x06
    call draw_circle

    push word 595
    push word 205
    push word 605
    push word 225
    push word 0x07
    call draw_rect

    push word 600
    push word 185
    push word 580
    push word 205
    push word 620
    push word 205
    push word 0x07
    call draw_tri

    push word 600
    push word 180
    push word 580
    push word 200
    push word 620
    push word 200
    push word 0x07
    call draw_tri

    mov ah,00
    int 16h

mov ax,4c00h
int 21h