extern keyboard_handler
extern div_handler

global load_idt
load_idt:
	mov edx, [esp + 4]
	lidt [edx]
	sti
	ret