default rel

%macro checkrange 2
    mov      eax, %1
	cvtsi2sd xmm1, [%2]
    ucomisd  xmm1, xmm0
	jae      .done
%endmacro

section .data
	radius1 dq 1
	radius2 dq 25
	radius3 dq 100

section .text
global score
; int: rax score(double x: xmm0, double y: xmm1)
score:
    ; Compute x^2
    movapd xmm2, xmm0       ; copy x
    mulsd  xmm0, xmm2       ; xmm0 = x^2
    ; Compute y^2
    movapd xmm3, xmm1
    mulsd  xmm1, xmm3       ; xmm1 = y^2
    ; Add them → d^2
    addsd  xmm0, xmm1       ; xmm0 = d^2
    ; Compare r^2 and d^2
	checkrange 10, radius1  ;   1 >= d^2 -> return 10
	checkrange  5, radius2  ;  25 >= d^2 -> return  5
	checkrange  1, radius3  ; 100 >= d^2 -> return  1
	; missed
    xor    eax, eax         ; return 0
.done:
    ret

; On Linux ELF64, mark stack as non-executable (security hint)
%ifidn __OUTPUT_FORMAT__,elf64
SECTION .note.GNU-stack noalloc noexec nowrite progbits
%endif
