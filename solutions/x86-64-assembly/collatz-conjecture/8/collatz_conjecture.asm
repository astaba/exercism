section .text
global steps
steps:
	; Set the return register to -1 from the start ensures:
	; 0 is return in case of 1 and
	; an idiomatic -1 is return in case of invalid input
	mov eax, -1
	cmp edi, 0
	jle Done
loop:
	inc eax
	cmp edi, 1
	je Done
	; All odd numbers have the LSB set
	test edi, 1     ; TEST masks with 0..001 and discards result
	jz Even
	lea edi, [edi*3+1]
	jmp loop
Even:               ; Divide by 2 with SAR (Shift Arithmetic Right)
	sar edi, 1      ; SAR keeps the MSB as is.
	jmp loop
Done:
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
