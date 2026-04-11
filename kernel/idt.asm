global load_idt

load_idt:
    mov edx, [esp + 4]
    lidt [edx]
    sti
    ret

global keyboard_handler_stub
extern keyboard_handler

keyboard_handler_stub:
    pusha

    call keyboard_handler

    popa
    iretd
