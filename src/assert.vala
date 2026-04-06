void kernel_panic(string message) {
	for (uint i = 0; i < Vga.WIDTH * Vga.HEIGHT; i++) {
		uint16 c;
		if (i % 2 == 1)
			c = ' ' | Color.pack(LIGHT_RED, RED) << 8;
		else
			c = ' ' | Color.pack(RED, LIGHT_RED) << 8;
		Screen.buffer[i] = c;
	}

	const string kernel_panic_text = "KERNEL PANIC!";
	Screen.print(kernel_panic_text, Color.pack(BLACK, WHITE), Vga.WIDTH * (Vga.HEIGHT - 2) / 2 - kernel_panic_text.size / 2);
	Screen.print(message, Color.pack(WHITE, BLACK), Vga.WIDTH * Vga.HEIGHT / 2 - message.size / 2);
}