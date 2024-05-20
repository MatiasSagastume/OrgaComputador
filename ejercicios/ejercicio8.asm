global main
extern printf

%macro mPrintf 0
    sub    rsp,8
    call   printf
    add    rsp,8
%endmacro

%macro transformarAxRax 0
    cwd
    cwde
    cdq
%endmacro

section .data   
    matriz dw 112,213,13,1,123,6234,1,322,2344,1,3234,2345,1,323,445,123 ;diagonal inversa vale 4
    columna dw 3
    fila dw 0
    longElem dw 2
    longFila dw 8
    filaMax dw 4
    msgFinal db "La diagonal inversa es: %hi",10,0
    resultado dw 0

section .bss
    

section .text
main:
    call calcularDiagonalInversa
    mov rdi, msgFinal
    mov rsi, [resultado]
    mPrintf
ret
calcularDiagonalInvers:
    mov ax, [fila]
    cmp ax, [filaMax]
    je terminarLoop
    imul ax, [longFila]
    mov cx, [columna]
    imul cx, [longElem]
    add ax, cx
    transformarAxRax
    mov rbx, matriz
    add rbx, rax
    mov ax, [rbx]
    add [resultado], ax
    jmp continuarLoop

continuarLoop:
    sub word[columna], 1
    add word[fila], 1
    call calcularDiagonalInversa

terminarLoop:
    ret