namespace Serial {
	private const uint16 com1 = 0x3F8;

	public void putchar (char c) {
		while((Cpu.inb(com1 + 5) & 0x20) == 0) {} // Wait for the serial port to be ready
		Cpu.outb(com1, c);
	}

	public void print (string format, ...) {
		uint8 buffer[256];
		vsprintf(buffer, format, va_list());

		foreach (unowned var c in buffer) {
			if (c == '\0')
				break;
			putchar((char)c);
		}
	}
}
