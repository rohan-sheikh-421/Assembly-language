[org 0x0100]

jmp start
av: dw 0
array : dw 0
max: dw 0
min: dw 0
median: dw 0
size: dw 4
bubblesort:
push bp
mov bp,sp
sub sp,2
push ax
push bx
push cx
push si
mov bx,[bp+6]
mov cx,[bp+4]
dec cx
shl cx,1

mainloop:
mov si,0
mov word[bp-2],0

innerloop:
mov ax,[bx+si]
cmp ax,[bx+si+2]
jbe noswap

mov [av],ax
mov ax,[bx+si+2]
mov dx,[av]
mov [bx+si+2],dx
mov[bx+si],ax
mov word[bp-2],1

noswap:
add si,2
cmp si,cx
jne innerloop
cmp word[bp-2],1
je mainloop

pop si
pop cx
pop bx
pop ax
mov ax,bp
pop bp
ret 4

stats:
push bp
mov bp,sp
push ax
push bx
push cx
push si
push di
mov bx,[bp+6]
mov cx,[bp+4]
mov di,cx
dec di
shl di,1

;min
mov ax,[bx]
mov word[min],ax

;max
mov ax,[bx+di]
mov word[max],ax

;median
mov ax,cx
mov bx,2
div bx
cmp bx,0
jne odd
je even

odd:
mov bx,[bp+6]
mov di,ax
add di,2
mov ax,[bx+si]
mov word[median],ax
jmp exit

even:
mov bx,[bp+6]
mov di,ax
mov si,ax
add si,2
mov dx,[bx+di]
add dx,[bx+si]
mov ax,dx
mov dx,0
mov bx,2
div bx
mov word[median],ax

exit:

pop di
pop si
pop cx
pop bx
pop ax
pop bp

ret 4

start:
mov ax,[array]
push ax
mov ax,[size]
push ax
call bubblesort
mov ax,[array]
push ax
mov ax,[size]
push ax
call stats

mov ax,0x4c00
int 21h