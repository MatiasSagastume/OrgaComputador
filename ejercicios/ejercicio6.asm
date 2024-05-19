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
    vector dw 1,2,3,4,5,6,7,8,9,10
    medio dw 5
    msgPrueba db "%hi",10,0
    posActual dw 0
    desplazamiento dw 2
    cantElementos dw 10
    auxiliar1 dw 0
    auxiliar2 dw 0
section .text
main:
    mov rdi, msgPrueba
    mov rbx, vector ;apunto al 1er elemento del vector
    mov rsi, [rbx] 
    mPrintf ;se tiene que imprimir el primero
    call invertirVector
    mov rdi, msgPrueba
    mov rbx, vector ;apunto al 1er elemento del vector
    mov rsi, [rbx] 
    mPrintf ;se tiene que imprimir el originalmente ultimo
ret

invertirVector:
    mov ax, [posActual]
    add ax, 1
    cmp ax, [medio]
    je finalizarLoop
    mov rbx, vector
    mov ax, [desplazamiento]
    imul ax, [posActual]
    transformarAxRax
    add rbx, rax ;apunto a la pos actual
    mov ax, [rbx]
    mov [auxiliar1], ax ;tengo elemento actual guardado
    mov ax, [cantElementos]
    sub ax, 1
    sub ax, [posActual]
    imul ax, [desplazamiento]
    transformarAxRax
    mov rbx, vector
    add rbx, rax ;apunto a la pos a invertir
    mov ax, [rbx]
    mov [auxiliar2], ax ;tengo elemento a invertir guardado
    mov ax, [auxiliar1]
    mov [rbx], ax ;cambio el elemento
    mov rbx, vector
    mov ax, [desplazamiento]
    imul ax, [posActual]
    transformarAxRax
    add rbx, rax ;apunto a la pos actual
    mov ax, [auxiliar2]
    mov [rbx], ax ;completo la inversion
    jmp continuarInversion

continuarInversion:
    add word[posActual], 1
    call invertirVector

finalizarLoop:
    ret


