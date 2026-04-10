#ifndef IDT_H
# define IDT_H

typedef struct s_idt_entry
{
    unsigned short int offset_lowerbits;
    unsigned short int selector;
    unsigned char zero;
    unsigned char flags;
    unsigned short int offset_higherbits;
} idt_entry __attribute__((packed));

typedef struct s_idt_pointer
{
    unsigned short limit;
    unsigned int base;
} idt_pointer __attribute__((packed));

#endif
