[org 0x0100]

jmp start
nig: dw 5625h
count: dw 0

c1:		mov ax, [nig]
		mov bx, 0
		mov cx, 0
	
loop1:	add cx, 1
		shl ax, 1
		jnc next
		add bx, 1
	
next:		cmp cx, 16
		jne loop1
		
		mov [count], bx
		ret
	
start:	call c1
		mov ax, [count]
		mov ax, 0x4c00
		int 0x21
	