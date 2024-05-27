[org 0x0100]
jmp start
seq: dw 1100110010100000b
patt: dw 0010b
loc: dw 0  ; found
pattern: 
   push bp
   mov bp,sp
   push si
   push bx
   push ax
   mov ax,[bp+6]
   mov bx,[bp+4]
   mov si,16 ;total bits in ax
   sub si,[bp+2] ;how many time we can shift
   push si
   mov si,0
   l1:
   cmp si,[bp-10]
   je notfound
   and ax,bx
   rol bx,1
   add si,1
   push si

   innerloop:
   ror ax,1
   sub si,1
   cmp si,1
   ja innerloop
   pop si
   cmp ax,[bp-6]
   je found
   mov ax,[bp-8]
   jmp l1

   notfound:
   mov word[loc],-1
   jmp exit

   found:
   sub word[bp-10],si
   pop si
   mov word[loc],si

   exit:
   pop ax
   pop bx
   pop si
   pop bp
   ret 6


start:
mov ax,[seq]  ; 16 bit number
push ax
mov bx,[patt] ;pattern to be found
push 4
push bx
call pattern
mov ax,0x4c00
int 21h