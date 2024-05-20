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
    matriz dw 1,2,3,4,5,6,7,8,9
    columna dw 0
    fila dw 0
    longElem dw 2
    longFila dw 6
    filaMax dw 3
    msgFinal db "La traza es: %hi",10,0
    resultado dw 0

section .bss
    

section .text
main:
    call calcularTraza
    mov rdi, msgFinal
    mov rsi, [resultado]
    mPrintf
ret
calcularTraza:
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
    add word[columna], 1
    add word[fila], 1
    call calcularTraza

terminarLoop:
    ret