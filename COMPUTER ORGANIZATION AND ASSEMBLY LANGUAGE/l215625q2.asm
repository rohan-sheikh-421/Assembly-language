[org 0x0100]
jmp start
message: db 'hello world' 
length: dw 11 
message1: db 'salaam world' 
length1: dw 12
message2: db 'bye world' 
length2: dw 9 

clrscr: push es
push ax
push di


mov ax, 0xb800
mov es, ax 
mov di, 0 
nextloc: mov word [es:di], 0x0720
add di, 2 
cmp di, 4000 
jne nextloc 
pop di
pop ax
pop es
ret

printstr: push bp
mov bp, sp
push es
push ax
push cx
push si
push di
mov ax, 0xb800
mov es, ax
mov di, 0 
mov si, [bp+6]
mov cx, [bp+4] 
mov ah, 0x07 
nextchar: mov al, [si] 
mov [es:di], ax 
add di, 2 
add si, 1 
loop nextchar 
pop di
pop si
pop cx
pop ax
pop es
pop bp
ret 4

printstr1: push bp
mov bp, sp
push es
push ax
push cx
push si
push di
mov ax, 0xb800
mov es, ax
mov di, 400
mov si, [bp+6]
mov cx, [bp+4] 
mov ah, 0x08
nextchar1:
mov al, [si] 
mov [es:di], ax 
add di, 2
add si, 1
loop nextchar 
pop di
pop si
pop cx
pop ax
pop es
pop bp
ret 4

printstr2: push bp
mov bp, sp
push es
push ax
push cx
push si
push di
mov ax, 0xb800
mov es, ax
mov di, 800 
mov si, [bp+6]
mov cx, [bp+4] 
mov ah, 0x09 
nextchar2:
mov al, [si] 
mov [es:di], ax 
add di, 2
add si, 1
loop nextchar 
pop di
pop si
pop cx
pop ax
pop es
pop bp
ret 4

start: 
call clrscr 
mov ax, message
push ax 
push word [length]
call printstr

mov ax, message1
push ax 
push word [length1]

call printstr1

mov ax, message2
push ax 
push word [length2]
call printstr2

mov ax, 0x4c00 
int 0x21