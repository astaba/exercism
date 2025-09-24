section .text
global square_of_sum
square_of_sum:
    ; Provide your implementation here
    mov r8d, edi     ; Stash N
    xor eax, eax
.loop:              ; Compute the sum from N to 1
    add eax, r8d
    dec r8d
    jnz .loop
    mul eax
    ret

global sum_of_squares
sum_of_squares:
    ; Provide your implementation here
    mov r8d, edi     ; Stash N
    xor r9d, r9d
.loop:               ; Compute the sum from N to 1
    mov eax, r8d
    mul eax
    add r9d, eax
    dec r8d
    jnz .loop
    mov eax, r9d
    ret

global difference_of_squares
difference_of_squares:
    ; Provide your implementation here
    call square_of_sum
    mov r10d, eax
    call sum_of_squares
    sub r10d, eax
    mov eax, r10d
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
