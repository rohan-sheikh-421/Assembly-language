[org 0x100]
call cls
call delay
call delay
call delay
call delay
call delay
mov ax, 30
push ax
mov ax, 5
push ax
mov ax, 3
push ax
mov ax, string1
push ax
call print
call delay
call delay
call delay
call delay
call delay
mov ax, 30
push ax
mov ax, 7
push ax
mov ax, 3
push ax
mov ax, string2
push ax
call print
call delay
call delay
call delay
call delay
call delay
mov ax, 30
push ax
mov ax, 9
push ax
mov ax, 5
push ax
mov ax, string3
push ax
call print
call delay
call delay
call delay
call delay
call delay
mov ax, 30
push ax
mov ax, 11
push ax
mov ax, 5
push ax
mov ax, string4
push ax
call print
call delay
call delay
call delay
call delay
call delay
mov ax, 30
push ax
mov ax, 13
push ax
mov ax, 8
push ax
mov ax, string5
push ax
call print
call delay
call delay
call delay

call delay
call delay
mov ax, 30
push ax
mov ax, 15
push ax
mov ax, 8
push ax
mov ax, string6
push ax
call print
mov ax, 0x4c00
int 21h


cls: push es
push ax
push cx
push di
mov ax, 0xb800
mov es, ax
xor di, di
mov ax, 0x0720
mov cx, 2000
cld
rep stosw
pop di
pop cx
pop ax
pop es
ret


delay: push cx
push ax
push dx
mov dx, 65535
mov cx, 65535

del:cmp dx, 0
je end
mov ax, 0
sub dx, 1
loop del

end: pop dx
pop ax
pop cx
ret

print: push bp
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
mov al, [null]
repne scasb
mov ax, 0xffff
sub ax, cx
dec ax
jz exit
mov cx, ax ; load string length in cx
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

nextchar: lodsb
stosw
loop nextchar

exit: pop di
pop si
pop cx
pop ax
pop es
pop bp
ret 8
ret
null: db '_'
string1: db 'Name: Rohan Javed _'
string2: db 'Roll #: 5625_'
string3: db 'Email: 21L5625@lhr.nu.edu.pk_'
string4: db 'Batch: 2021_'
string5: db 'Address: lahore, pakistan_'
string6: db 'Features: kind, friendly_'