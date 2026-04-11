public void kernel_panic (string message) {
	for (uint i = 0; i < Vga.WIDTH * Vga.HEIGHT; i++) {
		uint16 c;
		if (i % 2 == 1)
			c = Vga.Screen.entry (' ', Color.pack(LIGHT_RED, RED));
		else
			c = Vga.Screen.entry (' ', Color.pack(RED, LIGHT_RED));
		Vga.Screen.buffer[i] = c;
	}

	const string kernel_panic_text = "KERNEL PANIC!";
	Vga.Screen.put_string(kernel_panic_text, Vga.WIDTH * (Vga.HEIGHT - 2) / 2 - kernel_panic_text.length / 2, Color.pack(BLACK, WHITE));
	Vga.Screen.put_string(message, Vga.WIDTH * Vga.HEIGHT / 2 - message.length / 2, Color.pack(WHITE, BLACK));
	Vga.Cursor.disable();
	Cpu.cli();
	while (true) {
		Cpu.hlt();
	}
}
