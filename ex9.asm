global main
extern printf

section .data
	msg db "Testing %i... ", 0x0a, 0x00

main:
	push ebp
	mov ebp, esp
	sub esp, 4
	push 123
	push msg
	call printf
	add esp, 8
	add esp, 4
	mov eax, 0
	mov esp, ebp
	pop ebp
	ret
