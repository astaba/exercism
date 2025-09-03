section .text
global steps
steps:
	; Set the return register to -1 from the start ensures:
	; 0 is return in case of 1 and
	; an idiomatic -1 is return in case of invalid input
	mov rax, -1
	cmp rdi, 0
	jle Done
loop:
	inc rax
	cmp rdi, 1
	je Done
	; All odd numbers have the LSB set
	test rdi, 1     ; TEST masks with 0..001 and discards result
	jz Even
	lea rdi, [rdi*3+1]
	jmp loop
Even:               ; Divide by 2 with SAR (Shift Arithmetic Right)
	sar rdi, 1      ; SAR keeps the MSB as is.
	jmp loop
Done:
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
