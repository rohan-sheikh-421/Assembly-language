[org 0x0100]

jmp start

f: dd 0
answer: dd 0
multiplicand: dd 0
multiplier: dw 0

start:
mov si,0x7696
mov di,si
not di
mov cl, 16 
mov dx, 1 
checkbit: test dx, [multiplier] 
jz skip 
mov ax, [multiplicand]
add [answer], ax 
mov ax, [multiplicand+2]
adc [answer+2], ax 
skip: shl word [multiplicand], 1
rcl word [multiplicand+2], 1 
shl dx, 1 
dec cl 
jnz checkbit
add [answer],di
add [answer + 2],si
mov ax,0x4c00
int 0x21

