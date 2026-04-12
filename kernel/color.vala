public enum Color {
	BLACK,
	BLUE,
	GREEN,
	CYAN,
	RED,
	MAGENTA,
	BROWN,
	GRAY,
	DARK_GRAY,
	LIGHT_BLUE,
	LIGHT_GREEN,
	LIGHT_CYAN,
	LIGHT_RED,
	LIGHT_MAGENTA,
	YELLOW,
	WHITE;

	public static void init () {
		Cpu.inb(0x3da);
		Cpu.outb(0x3c0, 0x30);
		uint8 config = Cpu.inb(0x3C1);
		config &= 0xF7; // Clear le bit 3 (qui contrôle le blink)
		Cpu.outb(0x3C0, config);
	}

	public inline static Color pack (Color fg, Color bg) {
		return (fg | bg << 4);
	}
}
