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
    vector dw 21,1,3,4,53,9,1,0,4,63,21,9,76,21,4,7,98,43,27,2
    cantElementos dq 20
    posActual dw 0
    desplazamiento dw 2
    msgFinal db "El maximo es: %hi, el minimo es: %hi y el promedio es: %hi",10,0
section .bss
    maximo resw 1
    minimo resw 1
    promedio resw 1
    resPromedio resq 1
section .text
main:
    mov ax,[vector]
    mov [maximo], ax
    mov [minimo], ax
    call calcularMaximo
    mov word[posActual], 0
    call calcularMinimo
    mov word[posActual], 0
    call calcularPromedio
    mov rdi,msgFinal
    mov rsi,[maximo]
    mov rdx,[minimo]
    mov rcx,[resPromedio]
    mPrintf
ret

calcularMaximo:
    mov ax, [posActual]
    add ax, 1
    cmp ax, [cantElementos]
    je finalizarLoop
    mov rbx, vector
    mov ax, [desplazamiento]
    imul ax, [posActual]
    transformarAxRax
    add rbx, rax
    mov ax, [rbx]
    cmp ax, [maximo]
    jle continuarProxMax
    mov [maximo], ax
    jmp continuarProxMax

continuarProxMax:
    add word[posActual], 1
    call calcularMaximo
finalizarLoop:
    ret

calcularMinimo:
    mov ax, [posActual]
    add ax, 1
    cmp ax, [cantElementos]
    je finalizarLoop
    mov rbx, vector
    mov ax, [desplazamiento]
    imul ax, [posActual]
    transformarAxRax
    add rbx, rax
    mov ax, [rbx]
    cmp ax, [minimo]
    jge continuarProxMin
    mov [minimo], ax
    jmp continuarProxMin

continuarProxMin:
    add word[posActual], 1
    call calcularMinimo

calcularPromedio:
    mov ax, [posActual]
    add ax, 1
    cmp ax, [cantElementos]
    je finalizarLoopProm
    mov rbx, vector
    mov ax, [desplazamiento]
    imul ax, [posActual]
    transformarAxRax
    add rbx, rax
    mov ax, [rbx]
    add [promedio], ax
    jmp continuarProxProm
    

continuarProxProm:
    add word[posActual], 1
    call calcularPromedio

finalizarLoopProm:
    mov ax, [promedio]
    transformarAxRax
    idiv qword[cantElementos]
    mov [resPromedio], rax
    ret