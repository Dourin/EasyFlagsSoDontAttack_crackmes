section .data
    correct_hex db '4D354A68764676754A74664F51773748', 0
    prompt db 'Enter password: ', 0
    fail db 'Bad Password!', 10, 0
    success db 'Good Job!', 10, 0

section .bss
    input resb 17
    input_hex resb 33  ; 16 bytes * 2 hex digits per byte + null terminator

section .text
    global _start

_start:
    ; Print the prompt
    mov rax, 1                ; syscall: write
    mov rdi, 1                ; file descriptor: stdout
    mov rsi, prompt           ; message to write
    mov rdx, 15               ; message length
    syscall

    ; Read the user input
    mov rax, 0                ; syscall: read
    mov rdi, 0                ; file descriptor: stdin
    mov rsi, input            ; buffer to store input
    mov rdx, 16               ; max number of bytes to read
    syscall

    ; Ensure the input string is null-terminated
    mov byte [rsi+16], 0

    ; Convert input to hex
    mov rdi, input            ; input string
    mov rsi, input_hex        ; buffer to store hex representation
    call to_hex

    ; Compare the input hex with the correct hex
    mov rdi, input_hex        ; first string
    mov rsi, correct_hex      ; second string
    call strcmp

    ; Check the result of strcmp
    test rax, rax
    jz .success

.fail:
    ; Print fail message
    mov rax, 1                ; syscall: write
    mov rdi, 1                ; file descriptor: stdout
    mov rsi, fail             ; message to write
    mov rdx, 14               ; message length
    syscall

    ; Exit with code 1
    mov rax, 60               ; syscall: exit
    mov rdi, 1                ; exit code
    syscall

.success:
    ; Print success message
    mov rax, 1                ; syscall: write
    mov rdi, 1                ; file descriptor: stdout
    mov rsi, success          ; message to write
    mov rdx, 10               ; message length
    syscall

    ; Exit with code 0
    mov rax, 60               ; syscall: exit
    mov rdi, 0                ; exit code
    syscall

to_hex:
    ; Convert string at rdi to hex string at rsi
    push rbx                  ; save rbx
    mov rcx, 16               ; process up to 16 characters
    .convert_loop:
        mov al, [rdi]         ; load character
        test al, al           ; check for null terminator
        jz .done
        call byte_to_hex      ; convert character to hex
        add rdi, 1            ; move to next character
        add rsi, 2            ; move to next hex pair
        loop .convert_loop
    .done:
        mov byte [rsi], 0     ; null terminate the hex string
        pop rbx               ; restore rbx
        ret

byte_to_hex:
    ; Convert byte in al to two hex digits at [rsi]
    mov bl, al                ; save al in bl
    shr al, 4                 ; high nibble
    call nibble_to_hex
    mov [rsi], al
    mov al, bl                ; restore original byte
    and al, 0x0F              ; low nibble
    call nibble_to_hex
    mov [rsi+1], al
    ret

nibble_to_hex:
    ; Convert nibble in al to hex digit
    cmp al, 9
    jbe .digit
    add al, 'A'-10
    ret
    .digit:
    add al, '0'
    ret

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
