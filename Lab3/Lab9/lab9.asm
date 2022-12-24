
section .rodata
    prompt1    db "Please enter a number: ",0
    prompt2    db "Enter another number: ",0
    format_str db "The sum is: %ld.",10,0
    num_format db "%ld",0

section .text
    global main
    extern printf, scanf

main:
    push    rbp
    mov     rbp, rsp
    sub     rsp, 80

    xor rcx, rcx
    mov    rdi, dword prompt1
    xor    rax, rax
    call   printf
    lea    rsi, [rbp-8]
    mov    rdi, dword num_format
    call   scanf
    
    mov r13, [rbp-8]
    xor r12, r12
    jmp loop1

cloop2:
    mov    rdi, dword prompt2
    call   printf
    lea    rsi, [rbp-16]
    mov    rdi, dword num_format
    call   scanf
    add    r13, [rbp-16]
    add    r12, 1
    loop1:
    cmp r12, 9
    jl cloop2

    mov rsi, r13
    mov rdi, dword format_str
    call printf
exit:
    add     rsp, 80
    leave
    ret

