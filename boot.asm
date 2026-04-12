[BITS 32]

extern kmain
global _start

; --- Header Multiboot ---
section .multiboot
    align 4
    MULTIBOOT_MAGIC    equ 0x1BADB002
    MULTIBOOT_FLAGS    equ 0x00000003
    MULTIBOOT_CHECKSUM equ -(0x1BADB002 + 0x00000003)

    dd MULTIBOOT_MAGIC
    dd MULTIBOOT_FLAGS
    dd MULTIBOOT_CHECKSUM

section .text

_start:
    cli
    mov esp, stack_space + 65536

    lgdt [gdt_ptr]
    jmp 0x08:flush_now

flush_now:
    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax

    call kmain

kernel_loop:
    hlt
    jmp kernel_loop

; --- GDT ---
section .data
    align 4
gdt_start:
    dq 0x0000000000000000
    dq 0x00CF9A000000FFFF
    dq 0x00CF92000000FFFF
gdt_end:

gdt_ptr:
    dw gdt_end - gdt_start - 1
    dd gdt_start

; --- Stack ---
section .bss
    align 16
    stack_space: resb 65536
