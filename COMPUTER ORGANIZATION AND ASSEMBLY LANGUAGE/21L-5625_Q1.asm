[org 0x0100]
jmp start
msg1: db 'Hi! I',0x27,'m Umer',0
msg2: db 'I',0x27,'m Sad',0
msg3: db 'I Study at FAST',0
msg4: db 'My Roll No is 21L-7696',0
clr_scr:
    push es
    push ax
    push di

    mov ax,0xb800
    mov es,ax
    mov di,0

    l1:
        mov word[es:di],0x0720
        add di,2
        cmp di,4000
        jne l1
    
    pop di
    pop ax
    pop di
    ret
printstr: 
    push bp
    mov bp, sp
    push es
    push ax
    push cx
    push si
    push di
    push ds
    pop es

    mov di, [bp+4] 
    mov cx, 0xffff 
    xor al, al 
    repne scasb
    mov ax, 0xffff 
    sub ax, cx 
    dec ax 
    jz exit 

    mov cx, ax 
    mov ax, 0xb800
    mov es, ax 
    mov al, 80 
    mul byte [bp+8] 
    add ax, [bp+10] 
    shl ax, 1 
    mov di,ax 
    mov si, [bp+4] 
    mov ah, [bp+6] 
    cld 
    nextchar: 
        lodsb 
        stosw 
        loop nextchar 
    exit: 
        pop di
        pop si
        pop cx
        pop ax
        pop es
        pop bp
        ret 8
start:
    call clr_scr
    mov ah,00h
    int 16h
    push word 20
    push word 4
    push word 0x07
    push msg1
    call printstr
    mov ah,00h
    int 16h
    push word 20
    push word 5
    push word 0x07
    push msg2
    call printstr
    mov ah,00h
    int 16h
    push word 20
    push word 6
    push word 0x07
    push msg3
    call printstr
    mov ah,00h
    int 16h
    push word 20
    push word 7
    push word 0x07
    push msg4
    call printstr
mov ax,0x4c00
int 21h