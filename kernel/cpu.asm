global outb
outb:
    mov dx, [esp + 4]   ; port
    mov al, [esp + 8]   ; value
    out dx, al
    ret

global inb
inb:
    mov dx, [esp + 4]
    xor eax, eax
    in al, dx
    ret
