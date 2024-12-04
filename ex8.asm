global _start

_start:
	push 21
	push 11
	call addition
	mov ebx, eax
	mov eax, 1
	int 0x80

addition:
	push ebp
	mov ebp, esp
	
	mov eax, [ebp+8]
	mov ebx, [ebp+12]

	add eax, ebx
	mov esp, ebp
	pop ebp
	ret
