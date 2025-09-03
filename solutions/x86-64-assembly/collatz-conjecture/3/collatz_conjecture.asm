section .text
global steps
steps:
    ; Provide your implementation here

	; Based on the assumption the positive integer was passed to this 
	; routine through RDI accoording to System V ABI standard
;====================================================================
	push rbx
	; save it:
	mov rbx, rdi
	; set operation counter = 0
	xor rcx, rcx
	
IfEquals1:	; Before starting make sure > 1
	cmp rbx, 1
	je Done

Modulo2:	; Check eveness: with modulo %2
	xor rdx, rdx
	xor r8, r8
	mov rax, rbx
	mov r8, 2
	div r8
	cmp rdx, 0
	jz Even

; if odd:
	lea rbx, [rbx+rbx*2]
	inc rbx

	inc rcx           ; update operation counter
	jmp Modulo2

Even:                 ; if even:
	shr rbx, 1        ; divide by 2

	inc rcx           ; update operation counter
	jmp IfEquals1

Done:
	mov rax, rcx

	pop rbx
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif


