global main
extern puts
extern gets
extern printf
%macro mPuts 1
    mov    rdi,%1 
    sub    rsp,8
    call   puts
    add    rsp,8
%endmacro

%macro mGets 1
    mov    rdi,%1
    sub    rsp,8
    call   gets
    add    rsp,8
%endmacro

%macro mPrintf 0
    sub    rsp,8
    call   printf
    add    rsp,8
%endmacro

section .data
    pedirNombre db "Por favor ingrese su nombre y apellido:",0
    pedirPadron db "Por favor ingrese su padron:",0
    pedirEdad db "Por favor ingrese su Edad:",0
    msgFinal db "El alumno %s de Padrón N° %s tiene %s años", 10,0
section .bss
    nombre resb 100
    padron resb 100
    edad resb 100
section .text
main:
    mPuts pedirNombre
    mGets nombre
    mPuts pedirPadron
    mGets padron
    mPuts pedirEdad
    mGets edad
    mov rdi,msgFinal
    mov rsi,nombre
    mov rdx,padron
    mov rcx,edad
    mPrintf
    ret
