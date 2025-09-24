section .text
global square_of_sum
square_of_sum:          ; sum of N == N(N+1)/2
    ; Provide your implementation here
    mov eax, edi        ; eax = N
    inc eax             ; eax = N+1
    mul edi             ; eax = edi * eax = N(N+1)
    shr eax, 1          ; Sum: eax = N(N+1)/2
    mul eax             ; Now square the sum: eax = eax * eax
    ret

global sum_of_squares
sum_of_squares:         ; sum of N squares == N(N+1)(2N+1)/6
    ; Provide your implementation here
    mov eax, edi        ; eax = N
    mov ecx, edi        ; ecx = N
    inc ecx             ; ecx = N+1
    mul ecx             ; eax = ecx * eax = N(N+1)
    lea ecx, [rdi*2+1]  ; ecx = 2N+1
    mul ecx             ; eax = N(N+1)(2N+1)
    mov ecx, 6
    cdq                 ; Make eax sign extension on the whole edx
    idiv ecx            ; eax = N(N+1)(2N+1)/6
    ret

global difference_of_squares
difference_of_squares:
    ; Provide your implementation here
    call sum_of_squares
    mov r8d, eax
    call square_of_sum
    sub eax, r8d
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
