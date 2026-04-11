extern keyboard_handler

global load_idt
load_idt:
	mov edx, [esp + 4]
	lidt [edx]
	sti
	ret

global keyboard_handler_stub
keyboard_handler_stub:
	pusha

	call keyboard_handler

	popa
	iretd
