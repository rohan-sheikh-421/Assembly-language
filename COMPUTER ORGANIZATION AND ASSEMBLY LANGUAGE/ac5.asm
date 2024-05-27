[org 0x0100]

jmp start

sum:
mov ax,0
mov ax,[n1]
mov ax,[n2]
mov ax,[n2]

mov ax,[n2]

shr ax,2
mov[r],ax
add ax,2
mov[l],ax

ret

sep:
mov cx,12
mov ax,5625
mov dx,0xF000
AND ax,dx

l1:shr ax,1
loop l1
mov [n1],ax

mov cx,8
mov ax,5625
mov dx,0x0F00
AND ax,dx
l2:shr ax,1
loop l2
mov[n2],ax

mov cx,4
mov ax,5625
mov dx,0x00F0
AND ax,dx
l3:shr ax,1
loop l3
mov[n3],ax
mov ax,5625
mov dx,0x000F
AND ax,dx
mov[n4],ax

end:ret

add:

mov ax,[F]
mov bx,word[result]
add bx,ax
mov[reres],bx
mov bx,word[result+2]
mov ax,[F+2]
add bx,ax
mov[reres+2],bx

ret

start:
mov ax,0x5625
call sep
call sum

mov ax,0x4c00
int 21h