global main
extern puts

section .data
mensaje db  "Organización del Computador"
prueba db 80

section .text
main:
    mov rdi, mensaje
    sub     rsp,8
    call puts
    add     rsp,8
    ret