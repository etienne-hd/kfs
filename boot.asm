[BITS 32]

extern kmain

; --- Header Multiboot ---
align 4
section .multiboot
    MULTIBOOT_MAGIC    equ 0x1BADB002
    MULTIBOOT_FLAGS    equ 0x00000003
    MULTIBOOT_CHECKSUM equ -(0x1BADB002 + 0x00000003)

    dd MULTIBOOT_MAGIC
    dd MULTIBOOT_FLAGS
    dd MULTIBOOT_CHECKSUM
; --------------------------

section .text

global _start
_start:
    mov esp, stack_space + 65536 ; Stack pointer initialization 
    call kmain
	.loop:
    hlt
    jmp .loop ; while (true)

; --------------------------
section .bss
	align 16
	stack_space: resb 65536 
