section .text
global score
; int: rax score(double x: xmm0, double y: xmm1)
score:
    ; Compute x^2
    movapd xmm2, xmm0       ; copy x
    mulsd xmm2, xmm0        ; xmm2 = x^2
    ; Compute y^2
    movapd xmm3, xmm1
    mulsd xmm3, xmm1        ; xmm3 = y^2
    ; Add them x^2 + y^2 → d^2
    addsd xmm2, xmm3        ; xmm2 = d^2
    ; Compare with 1.0
	mov edx, 1              ; load int radius as r^2
	cvtsi2sd xmm0, edx      ; Convert int to double
    ucomisd xmm2, xmm0      ; Compare d^2 - r^2
    ja  .check_mid          ; if > 1.0 → check bigger
    mov eax, 10             ; return 1O int points
    ret
.check_mid:
	mov edx, 25
	cvtsi2sd xmm0, edx
    ucomisd xmm2, xmm0
    ja  .check_outer
    mov eax, 5              ; return 5 int points
    ret
.check_outer:
	mov edx, 100
	cvtsi2sd xmm0, edx
    ucomisd xmm2, xmm0
    ja  .miss
    mov eax, 1              ; return 1 int points
    ret
.miss:
    xor eax, eax            ; return 0
    ret

; On Linux ELF64, mark stack as non-executable (security hint)
%ifidn __OUTPUT_FORMAT__,elf64
SECTION .note.GNU-stack noalloc noexec nowrite progbits
%endif
