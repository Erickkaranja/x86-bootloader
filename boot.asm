; a simple x86 bootloader
; when you turn on comp the processor looks for address 0xFFFFFFF0 for bios code
; which is in a ROM secrion in the computer
; The bios posts in search of a boot medium a medium is said to be bootable if the
; the first 512bytes are readable and ends exactly with 0x55AA
; if the bios deems a given drive bootable it loads the first 512bytes in memory address
; 0x007C00 and transfers controll to this address through a jump instruction to the processor.
; check on MBR(master boot record)

; processor will be running in real mode rather than protected mode
; in real mode memory is addressed as logical address rather than physical address therefore
; we will use segment registers(which are used to store the beggining of a 64k segment of memory.)

bits 16

mov ax, 0x7C0
mov ds, ax ; data segment of our BL will begin at address 0x7C0

mov ax, 0x7E0 ; end of the data segment i.e 0x7C0 + 512bytes
mov ss, ax ; want our stack segment to begin below the data segment
mov sp, 0x2000 ; create an 8k stack segment

call clearscreen

push 0x0000
call movecursor
add sp, 2

push msg
call print
add sp, 2

cli
hlt

clearscreen:
	push bp
	mov bp, sp
	pusha

	mov ah, 0x07 ;tell bios to scroll down window
	mov al, 0x00 ; tell bios to clear window
	mov bh, 0x07 ; white on black
	mov cx, 0x00 ; specify top left of screen (0, 0)
	mov dh, 0x18 ; 18h = 24 rows of char
	mov dl, 0x4f ; 4fh = 79 columns of char
	int 0x10 ; call vedio interrupt

	popa
	mov sp, bp
	pop bp
	ret

movecursor:
	push bp
	mov bp, sp
	pusha

	mov dx, [bp+4] ;get argument from the stack
	mov ah, 0x02 ; set cursor position
	mov bh, 0x00 ; set page to 0
	int 0x10 ; call vedio interrupt

	popa
	mov sp, bp
	pop bp
	ret
print:
	push bp
	mov bp, sp
	pusha

	mov si, [bp+4] ; get pointer of the data
	mov bh, 0x00 ; set page number 0
	mov bl, 0x00 ; fore ground color - irrerevant
	mov ah, 0x0E ; print to TTY
.char:
	mov al, [si]
	add si, 1
	or al, 0
	je .return ; end if the string is done
	int 0x10 ; else print
	jmp .char ; continue looping
.return:
	popa
	mov sp, bp
	pop bp
	ret
msg: db "Simple bootloader written!!", 0

times (510-($-$$)) db 0
dw 0xAA55
