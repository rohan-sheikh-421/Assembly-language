[org 0x0100]

S1: 		dw -3, -1, 2, 5, 6, 8, 9
S2: 		dw -2, 2, 6, 7, 9
diff:		dw 0, 0, 0, 0, 0, 0, 0

jmp start

outerloop:	mov bx, 0
innerloop:	mov cx, [S2 + bx]
		cmp [S1 + si], cx
		jne iin
		je iio
		
iin:		add bx, 2
		cmp bx, 8
		je  dif
		jmp innerloop
		
iio:		add si, 2
		cmp si, 12
		je end
		jmp outerloop
		
dif:		mov di, [S1 + si]
		mov [diff + bp], di
		add bp, 2
		jmp iio
		
		
end:		ret

start:	mov ax, 0
		mov cx, 0
		mov bp, 0
		call outerloop
		mov ax, 0x4c00
		int 0x21