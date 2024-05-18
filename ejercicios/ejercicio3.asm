global main
extern printf
%macro mPrintf 0
    sub    rsp,8
    call   printf
    add    rsp,8
%endmacro
section .data
    x dq 2
    y dq 3
    msgFinal db "Resultado: %li / %li",10,0
    
section .bss
    divisor resb 64
    numerador resb 64
section .text
main:
    mov rax,[x]
    mov r9,[x]
    cmp qword[y],0
    jmp calcular

calcular:
    mov rcx,[y]
    sub rcx,1
    call ciclo
    mov [numerador], rax
    mov word[divisor], 1
    mov rdi, msgFinal
    jmp imprimirResultado

ciclo:
    MUL qword[x]
    loop ciclo
    ret

imprimirResultado:
    mov rsi, [numerador]
    mov rdx,[divisor]
    mPrintf
    ret