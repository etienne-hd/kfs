Idt.Entry idt_table[256];
Idt.Pointer idt_ptr;

void load_idt_entry(int isr_number, uint32 b, int16 selector, uint8 flags)
{
    idt_table[isr_number].offset_lowerbits = (uint16)(b & 0xFFFF);
    idt_table[isr_number].offset_higherbits = (uint16)((b >> 16) & 0xFFFF);
    idt_table[isr_number].selector = selector;
    idt_table[isr_number].flags = flags;
    idt_table[isr_number].zero = 0;
}

static void initialize_idt_pointer()
{
    idt_ptr.limit = (uint16)((sizeof(Idt.Entry) * 256) - 1);
    idt_ptr.base = (uint32)&idt_table;
}

static void initialize_pic()
{
    /* ICW1 - begin initialization */
    Cpu.outb(0x20, 0x11);
    Cpu.outb(0xA0, 0x11);

    /* ICW2 - remap offset address of idt_table */
    /*
    * In x86 protected mode, we have to remap the PICs beyond 0x20 because
    * Intel have designated the first 32 interrupts as "reserved" for cpu exceptions
    */
    Cpu.outb(0x21, 0x20);
    Cpu.outb(0xA1, 0x28);

    /* ICW3 - setup cascading */
    Cpu.outb(0x21, 0x04);
    Cpu.outb(0xA1, 0x02);

    /* ICW4 - environment info */
    Cpu.outb(0x21, 0x01);
    Cpu.outb(0xA1, 0x01);
    /* Initialization finished */

    /* mask interrupts */
    Cpu.outb(0x21 , 0xff);
    Cpu.outb(0xA1 , 0xff);
}

void idt_init()
{
    initialize_pic();
    initialize_idt_pointer();
    Idt.load_idt(&idt_ptr);
}