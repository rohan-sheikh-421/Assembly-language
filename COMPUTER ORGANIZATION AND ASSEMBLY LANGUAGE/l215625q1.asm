[org 0x0100]
jmp start
top: 	dw 10             
bottom: dw 20		     
left:	dw 10			 
right:	dw 50 
start:
call clrscr
push word [top]
push word [bottom]
push word [left]
push word [right] 
call drawrect 
end:
mov ax, 0x4c00
int 21h
clrscr:
mov ax, 0xb800
mov es, ax 
xor di,di 
mov ax,0x0720
mov cx,2000
cld
rep stosw			
ret
drawrect:
push bp
mov  bp, sp
pusha 
; bp + 4  =  right
; bp + 6  =  left
; bp + 8  =  bottom
; bp + 10 =  top
mov al, 80
mul byte [bp + 10] 
add ax,  [bp + 6]		 
shl ax, 1
mov di, ax 
push di
mov ah, 0x07
a
mov cx, [bp + 4]
sub cx, [bp + 6]
push cx 
mov al, '+'
loop1:
rep stosw 
pop bx 
pop di
push bx
dec bx	
shl bx, 1
add di, 160
mov cx, [bp + 8]
sub cx, [bp + 10] 
sub cx, 2 				
mov al, '|' 
 
loop2:
mov si, di
mov word [es:si], ax
add si, bx
mov word [es:si], ax
sub si, bx
add di, 160
loop loop2
pop cx
mov al, '-'
loop3:
rep stosw
return:	
popa
pop bp
ret 8

