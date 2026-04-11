extern keyboard_handler
extern div_handler

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

global div_handler_stub
div_handler_stub:
	pusha

	call div_handler

	popa
	iretd