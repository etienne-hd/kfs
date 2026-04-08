namespace Serial {
	private const uint16 com1 = 0x3F8;

	public void putchar(char c) {
		// Attendre que le buffer d'émission soit vide
		// On le sais grâce au bit 5
			// 0x20 car LSR retourne un octet de flag, faut pas comparer le bit entier car ca retourn 0b00100000 et 0x20 = bit 5 en hexa
		while((Cpu.inb(com1 + 5) & 0x20) == 0) {} // Attendre
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
