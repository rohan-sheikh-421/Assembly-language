[org 0x0100]

mov     ax, 0x0013
int     10h             ; set graphics video mode.
call    printGameGraphics ; to print graphics in graphic mode
call    gameScenario    ; to implement game rules
mov     ax, 4C00h
int     21h            ; terminate program


;*****************************************************************************
;                   Data Variables
;*****************************************************************************
isTurnX:        db 1    ; [1 == XPlayer], [2 == OPlayer]
isWinX:         db 0
isWinO:         db 0
isTie:          db 0
winAlert:       db 'Player _ wins'
TieAlert:       db '!!Game Is Drawn!!'
gameFrame:      db '0', '0', '0', '0', '0', '0', '0', '0', '0','0','0','0','0','0','0','0'; matrix of game


;*****************************************************************************
;                   Game Graphics part
;*****************************************************************************

; to print background frame
;**************     Parameters      **********************
; x position
; y position
; color of pixel
; length of frame
; width of frame
printRectShape:
push    bp
mov     bp, sp
push    ax
push    bx
push    cx
push    dx
push    si
push    di
push    ds
push    es
mov     al, [bp + 8]
mov     dx, [bp + 10]

printRectShapeL1:
mov     cx, [bp + 12] ; column number
printRectShapeL2:
mov     ah, 0Ch ; change to pixel color
int     10h ; interrupt to set pixel
add     cx, 1
mov     di, [bp + 12]
add     di, [bp + 4]
cmp     cx, di
jne     printRectShapeL2
add     dx, 1
; to get correct location
mov     di, [bp + 10]
add     di, [bp + 6]
cmp     dx, di
jne     printRectShapeL1
pop     es
pop     ds
pop     di
pop     si
pop     dx
pop     cx
pop     bx
pop     ax
pop     bp
ret     10  ; 5-parameters


; to print border of frame
;**************     Parameters      **********************
; x position
; y position
; color of pixel
; length of frame
; width of frame
printBorder:
push    bp
mov     bp, sp
push    ax
push    bx
push    cx
push    dx
push    si
push    di
push    ds
push    es
mov     ah, 0Ch ; to change pixel color
mov     dx, [bp + 10]
printBorderL1:
mov     cx, [bp + 12]
printBorderL2:
mov     si, [bp + 12]
add     si, 2
cmp     cx, si
jb      printBorderPixel
mov     si, [bp + 12]
add     si, [bp + 4]
sub     si, 2
cmp     cx, si
jge     printBorderPixel
mov     si, [bp + 10]
add     si, 2
cmp     dx, si
jb      printBorderPixel
mov     si, [bp + 10]
add     si, [bp + 6]
sub     si, 2
cmp     dx, si
jl      skipPrintingBorderPixel
printBorderPixel:
mov     al, [bp + 8]
int     10h
jmp     skipPrintingBorderPixel
skipPrintingBorderPixel:
inc     cx
mov     di, [bp + 12]
add     di, [bp + 4]
cmp     cx, di
jne     printBorderL2
inc     dx
mov     di, [bp + 10]
add     di, [bp + 6]
cmp     dx, di
jne     printBorderL1
pop     es
pop     ds
pop     di
pop     si
pop     dx
pop     cx
pop     bx
pop     ax
pop    bp
ret    10   ; 5 - paramters


; to display O using mid-point algorithm
;**************     Parameters      **********************
; (dx, di)  == (x, y) coordinates of center
; bx == radius of circle
; al == colour of pixel
printO:
mov     bp,0                ; x-coord
mov     si,bx               ; y-coord
OL1:
call    setEightPixels
sub     bx,bp              
inc     bp                 
sub     bx,bp              
jg      OL2                
add     bx,si              
dec     si                 
add     bx,si             
OL2:
cmp     si,bp
jae     OL1
ret
setEightPixels:
call    setFourPixels
setFourPixels:
xchg    bp,si
call    setTwoPixels
setTwoPixels:
neg     si
push    di
add     di,si
imul    di,320
add     di,dx
mov     BYTE [es:di+bp], al
sub     di,bp
stosb
pop     di
ret


; to print background area of the game
;**************     Parameters      **********************
; color of pixel
printBg:
push    bp
mov     bp, sp
push    ax
push    bx
push    cx
push    dx
push    si
push    di
push    ds
push    es
push    WORD 0 ; column number
push    WORD 0 ; row number
push    WORD [bp + 4] ; change to pixel color
push    WORD 200 ; length
push    WORD 320 ; width
call    printRectShape
pop     es
pop     ds
pop     di
pop     si
pop     dx
pop     cx
pop     bx
pop     ax
pop     bp
ret     2 ; 1-paramter


; to print background of frame(matrix of 4x4)
;**************     Parameters      **********************
; color of pixel
printGameAreaBg:
push    bp
mov     bp, sp
push    ax
push    bx
push    cx
push    dx
push    si
push    di
push    ds
push    es
push    WORD 115; column
push    WORD 30; row
push    WORD [bp + 4]; pixel color
push    WORD 90 ; length;----->60
push    WORD 120 ; width;----->90
call    printRectShape
pop     es
pop     ds
pop     di
pop     si
pop     dx
pop     cx
pop     bx
pop     ax
pop     bp
ret     2 ; 1-parameter

; to print 4x4 frame of the game
;**************     Parameters      **********************
; color of pixel
printGameMatrix:
push    bp
mov     bp, sp
push    ax
push    bx
push    cx
push    dx
push    si
push    di
push    ds
push    es
; line along x-axis
mov     si, 30
mov     cx, 3
xLoop:
add     si, 20
push    WORD 115
push    si
push    WORD [bp + 4]
push    WORD 2
push    WORD 120
call    printRectShape
loop    xLoop
; line along y-axis
mov     si, 115
mov     cx, 3
yLoop:
add     si, 30
push    si
push    WORD 30
push    WORD [bp + 4]
push    WORD 90
push    WORD 2
call    printRectShape
loop    yLoop
pop     es
pop     ds
pop     di
pop     si
pop     dx
pop     cx
pop     bx
pop     ax
pop     bp
ret     2 ; 1-parameter


; to print winint cut line segments on main diagonal
;**************     Parameters      **********************
; no paramter 
winFDiagCut:
push    bp
mov     bp, sp
push    ax
push    bx
push    cx
push    dx
push    si
push    di
push    ds
push    es
push    WORD 120
push    WORD 39
push    WORD 0006h
push    WORD 2
push    WORD 20
call    printRectShape ; draw cut line in block 1
push    WORD 180;---
push    WORD 59
push    WORD 0006h
push    WORD 2
push    WORD 20
call    printRectShape ; draw cut line in block 6
push    WORD 210;---180
push    WORD 79
push    WORD 0006h
push    WORD 2
push    WORD 20
call    printRectShape ; draw cut line in block 11
push    WORD 240
push    WORD 99
push    WORD 0006h
push    WORD 2
push    WORD 20
call    printRectShape ; draw cut line in block 16
pop     es
pop     ds
pop     di
pop     si
pop     dx
pop     cx
pop     bx
pop     ax
pop     bp
ret

; to print winint cut line segments on opposite to main diagonal
;**************     Parameters      **********************
; no paramter
winBDiagCut:
push    bp
mov     bp, sp
push    ax
push    bx
push    cx
push    dx
push    si
push    di
push    ds
push    es
push    WORD 210
push    WORD 39
push    WORD 0006h
push    WORD 2
push    WORD 20
call    printRectShape ; draw cut line in block 4
push    WORD 180
push    WORD 59
push    WORD 0006h
push    WORD 2
push    WORD 20
call    printRectShape ; draw cut line in block 7
push    WORD 150
push    WORD 79
push    WORD 0006h
push    WORD 2
push    WORD 20
call    printRectShape ; draw cut line in block 10
push    WORD 120
push    WORD 99
push    WORD 0006h
push    WORD 2
push    WORD 20
call    printRectShape ; draw cut line in block 13
pop     es
pop     ds
pop     di
pop     si
pop     dx
pop     cx
pop     bx
pop     ax
pop     bp
ret

; to print X
;**************     Parameters      **********************
; color of pixel
; x cordinate
; y coordinate
printX:
push    bp
mov     bp, sp
push    ax
push    bx
push    cx
push    dx
push    si
push    di
push    ds
push    es
; print main-diagonal line
mov     si, 0
mov     cx, [bp + 6]    ; x-coord
mov     dx, [bp + 4]    ; y-coord
mov     al, [bp + 8]    ; color of pixel
mov     ah, 0Ch         ; sub-service to change pixel
xFLoop:
int     10h
inc     cx
inc     dx
inc     si
cmp     si, 11
jne     xFLoop
; print opposite to main-diagonal line
mov     si, 0
mov     cx, [bp + 6]    ; x-coord
add     cx, 10
mov     dx, [bp + 4]    ; y-coord
mov     al, [bp + 8]    ; color of pixel
mov     ah, 0Ch         ; sub-service to change pixel
xBLoop:
int     10h
dec     cx
inc     dx
inc     si
cmp     si, 11
jne     xBLoop
pop     es
pop     ds
pop     di
pop     si
pop     dx
pop     cx
pop     bx
pop     ax
pop     bp
ret     6 ; 3-paramters


; to print status of game
;**************     Parameters      **********************
; no parameter
printGameStatus:
push    bp
mov     bp, sp
push    ax
push    bx
push    cx
push    dx
push    si
push    di
push    ds
push    es
push    WORD 70
push    WORD 140
push    WORD 0x8
push    WORD 30
push    WORD 180
call    printRectShape ; background of dialog box
push    WORD 68
push    WORD 138
push    WORD 0
push    WORD 34
push    WORD 184
call    printBorder ; border of dialog box
pop     es
pop     ds
pop     di
pop     si
pop     dx
pop     cx
pop     bx
pop     ax
pop     bp
ret


; to print graphics of game
;**************     Parameters      **********************
; no parameter
printGameGraphics:
push    bp
mov     bp, sp
push    ax
push    bx
push    cx
push    dx
push    si
push    di
push    ds
push    es
push    WORD 0x0E
call    printBg ; to print background of game
push    WORD 5
push    WORD 5
push    WORD 2
push    WORD 190
push    WORD 310
call    printBorder ; to print background border
push    WORD 0x0C
call    printGameAreaBg ; to print background of game area
push    WORD 113
push    WORD 28
push    WORD 2
push    WORD 94;--->64
push    WORD 124;---->94
call    printBorder ; to print border of game area
push    WORD 2
call    printGameMatrix ; to print frame of game
call    printGameStatus ; to print status of game
pop     es
pop     ds
pop     di
pop     si
pop     dx
pop     cx
pop     bx
pop     ax
pop     bp
ret
;*****************************************************************************
;               Graphics part is completed
;*****************************************************************************




;*****************************************************************************
;               Game Scenario Implementation
;*****************************************************************************

; to check either game is tie or not
;**************     Parameters      **********************
; no parameter
TieCond:
push    bp
push    ax
push    bx
push    cx
push    dx
push    si
push    di
push    ds
push    es
mov     si, 0
TieLoop:
cmp     BYTE [gameFrame + si], '0'
je      notTie
inc     si
cmp     si, 16
jne     TieLoop
mov     BYTE [isTie], 1
jmp     leaveTie
notTie:
mov     BYTE [isTie], 0
jmp     leaveTie
leaveTie:
pop     es
pop     ds
pop     di
pop     si
pop     dx
pop     cx
pop     bx
pop     ax
pop    bp
ret

; to check winning criteria
;**************     Parameters      **********************
; no parameter
winCond:
push    ax
push    bx
push    cx
push    dx
push    si
push    di
push    ds
push    es
mov     si, 0
; to test winning condition along horizontal
winHorizontalLoop:
mov     al, [gameFrame + si]
cmp     al, '0'
je      leaveHorizontalCheck
cmp     BYTE [gameFrame + si + 1], al
jne     leaveHorizontalCheck
cmp     BYTE [gameFrame + si + 2], al
jne     leaveHorizontalCheck
cmp     BYTE [gameFrame + si + 3], al
jne     leaveHorizontalCheck
cmp     BYTE [gameFrame + si + 4], al
jne     leaveHorizontalCheck
cmp     al, 'x'
je      xPlayerWins
; to print winning line
xor     ax, ax       
mov     ax, si
add     al, 1
mov     bl, 4
div     bl
mov     ah, 0
mov     bl, 20
mul     bl
add     ax, 39
push    WORD 120
push    ax
push    WORD 0006h
push    WORD 2
push    WORD 80
call    printRectShape
mov     BYTE [isWinO], 1
jmp     exitWin
xPlayerWins: 
mov     BYTE [isWinX], 1
xor     ax, ax       
mov     ax, si
add     al, 1
mov     bl, 3;-----
div     bl
mov     ah, 0
mov     bl, 20
mul     bl
add     ax, 39
push    WORD 120
push    ax
push    WORD 0006h
push    WORD 2
push    WORD 80
call    printRectShape
jmp     exitWin
leaveHorizontalCheck:  add si, 4
cmp     si, 16
jne     winHorizontalLoop
mov     si, 0
; to test winning condition along vertical
winVerticalLoop:
mov     al, [gameFrame + si]
cmp     al, '0'
je      leaveVerticalCheck
cmp     BYTE [gameFrame + si + 1], al
jne     leaveVerticalCheck
cmp     BYTE [gameFrame + si + 5], al
jne     leaveVerticalCheck
cmp     BYTE [gameFrame + si + 9], al
jne     leaveVerticalCheck
cmp     BYTE [gameFrame + si + 13], al
jne     leaveVerticalCheck
cmp     al, 'x'
je      xPlayerWinsV
mov     ax, si
mov     ah, 0
mov     bl, 30
mul     bl
add     ax, 129
push    WORD ax
push    WORD 35
push    WORD 0006h
push    WORD 50
push    WORD 2
call    printRectShape
mov     BYTE [isWinO], 1
jmp     exitWin
xPlayerWinsV: 
mov     BYTE [isWinX], 1
mov     ax, si
mov     ah, 0
mov     bl, 30
mul     bl
add     ax, 129
push    WORD ax
push    WORD 35
push    WORD 0006h
push    WORD 50; to print vertical winning line
push    WORD 2
call    printRectShape
jmp     exitWin
; to test winning condition diagonally
leaveVerticalCheck:  add si, 1
cmp     si, 4
jne     winVerticalLoop
mov     al, [gameFrame + 0]
cmp     al, '0'
je      checkOffDiagonal
cmp     BYTE [gameFrame + 5], al
jne     checkOffDiagonal
cmp     BYTE [gameFrame + 10], al
jne     checkOffDiagonal
cmp     BYTE [gameFrame + 15], al
jne     checkOffDiagonal
cmp     al, 'x'
je      xPlayerWinsFD
call    winFDiagCut
mov     BYTE [isWinO], 1
jmp     exitWin
xPlayerWinsFD:
call    winFDiagCut
mov     BYTE [isWinX], 1
jmp     exitWin
; to test winning condition in off-diagonal
checkOffDiagonal:
mov     al, [gameFrame + 4]
cmp     al, '0'
je      exitWin
cmp     BYTE [gameFrame + 7], al
jne     exitWin
cmp     BYTE [gameFrame + 10], al
jne     exitWin
cmp     BYTE [gameFrame + 13], al
jne     exitWin
cmp     al, 'x'
je      xPlayerWinsBD
call    winBDiagCut
mov     BYTE [isWinO], 1
jmp     exitWin
xPlayerWinsBD:
call    winBDiagCut
mov     BYTE [isWinX], 1
jmp     exitWin
exitWin:
pop     es
pop     ds
pop     di
pop     si
pop     dx
pop     cx
pop     bx
pop     ax
ret


; to maintain the sequence of game
gameScenario:
push    bp
push    ax
push    bx
push    cx
push    dx
push    si
push    di
push    ds
push    es

; to check is mouse clicked?
noMouseClick:
xor     ax, ax ;subservice to reset mouse
int     33h
waitForMouseClick:
mov     ax, 0001h ;to show mouse
int     33h
mov     ax,0003h
int     33h
or      bx,bx
jz      short waitForMouseClick
mov     ax, 0002h ;hide mouse after clicking
int     33h
shr     cx, 1 ;mouse position is according to 640 x 200 window
; check mouse click coordinates [click should be inside the game play area]
cmp     cx, 115;-----
jbe     waitForMouseClick
cmp     cx, 190;-----
jae     waitForMouseClick
cmp     dx, 30
jbe     waitForMouseClick
cmp     dx, 90
jae     waitForMouseClick
; to get indexes corresponding to valid mouse click corrdinates
mov     ax, dx
sub     ax, 30
mov     bl, 20
div     bl
mov     si, ax
mov     ax, cx
sub     ax, 115;----
mov     bl, 30
div     bl
mov     di, ax
mov     cx, si
mov     al, cl
mov     dh, cl
mov     bl, 3
mul     bl
mov     cx, di
mov     dl, cl
add     al, cl
adc     ax, 0
mov     di, ax
; to update blocks of frame
cmp     BYTE [gameFrame + di], '0'
jne     waitForMouseClick
xor     ax, ax
mov     al, dh
mov     ah, 20
mul     ah
add     ax, 35
mov     cx, ax
xor     ax, ax
mov     al, dl
mov     ah, 30
mul     ah
add     ax, 125
cmp     BYTE [isTurnX], 1
je      xPlayer
mov     BYTE [gameFrame + di], 'o' ; yes, print O
push    bp
push    es
push    dx
push    si
push    di
push    bx
push    ax
cli
push    WORD 0A000h
pop     es
mov     dx, ax
add     dx, 5
mov     di, cx
add     di, 5
mov     bx, 7
mov     al, 3 ; color of pixel
call    printO
sti
pop     ax
pop     bx
pop     di
pop     si
pop     dx
pop     es
pop    bp
mov     BYTE [isTurnX], 1
jmp     turnOver
xPlayer:
mov     BYTE [gameFrame + di], 'x' ; yes, print X
cli
push    WORD 1
push    ax
push    cx
call    printX
sti
mov     BYTE [isTurnX], 2
jmp     turnOver

turnOver:
; check game status and print appropriate message
call    winCond
cmp     BYTE [isWinX], 1
je      xPlayerWinMessage ; player X wins the game
cmp     BYTE [isWinO], 1
je      oPlayerWinMessage ; player O wins the game
call    TieCond
cmp     BYTE [isTie], 1
je      printTieAlert
jmp     waitForMouseClick

xPlayerWinMessage:
mov     BYTE [cs:winAlert + 7], 'X'
mov     al, 1   ; subservice 1 - update cursor
mov     bh, 0 
mov     bl, 7
mov     cx, 13
mov     dl, 14
mov     dh, 19
push    cs     
pop     es
mov     bp, winAlert
mov     ah, 0x13
int     10h
jmp     exitGame

oPlayerWinMessage:
mov     BYTE [cs:winAlert + 7], 'O'
mov     al, 1   ; subservice 1 - update cursor
mov     bh, 0
mov     bl, 7
mov     cx, 13
mov     dl, 14
mov     dh, 19
push    cs     
pop     es
mov     bp, winAlert
mov     ah, 0x13
int     10h
jmp     exitGame

printTieAlert:
mov     al, 1   ; subservice 1 - update cursor
mov     bh, 0
mov     bl, 7
mov     cx, 17
mov     dl, 12
mov     dh, 19
push    cs     
pop     es
mov     bp, TieAlert ; [es:bp] --> Tie message
mov     ah, 0x13 ; write string on console
int     10h
jmp     exitGame
exitGame:
mov     ax, 0A000h  ; hide mouse
int     0x33
pop     es
pop     ds
pop     di
pop     si
pop     dx
pop     cx
pop     bx
pop     ax
pop     bp
ret
;*****************************************************************************
;                       Game Implementation Ends!
;*****************************************************************************