private Idt.Entry idt_table[256];
private Idt.Pointer idt_ptr;

[CCode (cname = "timer_handler_stub")]
extern void timer_handler_stub ();

[CCode (cname = "keyboard_handler_stub")]
extern void keyboard_handler_stub ();

[CCode (cname = "mouse_handler_stub")]
extern void mouse_handler_stub ();

[CCode (cname = "divide_handler_stub")]
extern void divide_handler_stub ();

namespace Idt {
	private void load_idt_entry(int isr_number, uint32 func, int16 selector, uint8 flags) {
		idt_table[isr_number].offset_lowerbits = (uint16)(func & 0xFFFF);
		idt_table[isr_number].offset_higherbits = (uint16)((func >> 16) & 0xFFFF);
		idt_table[isr_number].selector = selector;
		idt_table[isr_number].flags = flags;
		idt_table[isr_number].zero = 0;
	}
	
	private void initialize_idt_pointer () {
		idt_ptr.limit = (uint16)((sizeof(Idt.Entry) * 256) - 1);
		idt_ptr.base = (uint32)&idt_table;
	}
	
	private void initialize_pic () {
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
	
		Cpu.outb(0x21, 0x00);
		Cpu.outb(0xA1, 0x00);
	}

	private void initialize_ps2_mouse() {
		Cpu.outb(0x64, 0xA8); // enable aux device
		Cpu.outb(0x64, 0x20); // read cmd byte

		uint8 status = Cpu.inb(0x60);
		Cpu.outb(0x64, 0x60);
		Cpu.outb(0x60, status | 0x02);

		Cpu.outb(0x64, 0xD4);
		Cpu.outb(0x60, 0xF4); // enable data reporting
	}

	public void init ()
	{
		initialize_pic();
		initialize_idt_pointer();

		load_idt_entry(0x00, (uint32)divide_handler_stub, 0x08, 0x8E);

		// IRQ
		load_idt_entry(0x20, (uint32)timer_handler_stub, 0x08, 0x8E);
		load_idt_entry(0x21, (uint32)keyboard_handler_stub, 0x08, 0x8E);
		load_idt_entry(0x2C, (uint32)mouse_handler_stub, 0x08, 0x8E);

		Idt.load((uint32)&idt_ptr);

		initialize_ps2_mouse();

		Cpu.sti ();
	}
}
