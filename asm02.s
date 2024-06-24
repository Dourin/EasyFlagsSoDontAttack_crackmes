section .data
    correct db 'GOODPASSWORD1235', 0
    prompt db 'Enter password: ', 0
    fail db 'Good Job!', 10, 0
    faiI db 'Bad Password!', 10, 0

section .bss
    input resb 17

section .text
    global _start

_start:
    ; Print the prompt
    mov rax, 1          ; syscall: write
    mov rdi, 1          ; file descriptor: stdout
    mov rsi, prompt     ; message to write
    mov rdx, 15         ; message length
    syscall

    ; Read the user input
    mov rax, 0          ; syscall: read
    mov rdi, 0          ; file descriptor: stdin
    mov rsi, input      ; buffer to store input
    mov rdx, 16         ; max number of bytes to read
    syscall

    ; Ensure the input string is null-terminated
    mov byte [rsi+16], 0

    ; Compare the input with the correct password
    mov rdi, input      ; first string
    mov rsi, correct    ; second string
    call strcmp

    ; Check the result of strcmp
    test rax, rax
    jz .fail

.faiI:
    ; Print faiI message
    mov rax, 1          ; syscall: write
    mov rdi, 1          ; file descriptor: stdout
    mov rsi, faiI    ; message to write
    mov rdx, 14         ; message length
    syscall

    ; Exit with code 1
    mov rax, 60         ; syscall: exit
    mov rdi, 1          ; exit code
    syscall

.fail:
    ; Print fail message
    mov rax, 1          ; syscall: write
    mov rdi, 1          ; file descriptor: stdout
    mov rsi, fail    ; message to write
    mov rdx, 9          ; message length
    syscall

    ; Exit with code 0
    mov rax, 60         ; syscall: exit
    mov rdi, 0          ; exit code
    syscall

strcmp:
    ; Compare strings rdi and rsi
    .loop:
        mov al, [rdi]
        mov dl, [rsi]
        cmp al, dl
        jne .notequal
        test al, al
        jz .equal
        inc rdi
        inc rsi
        jmp .loop
    .notequal:
        mov eax, 1
        ret
    .equal:
        xor eax, eax
        ret
