extern timer_handler
extern keyboard_handler
extern mouse_handler
extern divide_handler

global mouse_handler_stub
mouse_handler_stub:
	pusha

	call mouse_handler

	popa
	iretd

global keyboard_handler_stub
keyboard_handler_stub:
	pusha

	call keyboard_handler

	popa
	iretd

global timer_handler_stub
timer_handler_stub:
	pusha

	call timer_handler

	popa
	iretd

global divide_handler_stub
divide_handler_stub:
	pusha

	call divide_handler

	popa
	iretd