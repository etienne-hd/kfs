struct Vga : uint16 {
	public const size_t MEMORY = 0xB8000; 
	public const uint16 WIDTH = 80;
	public const uint16 HEIGHT = 25;
}

namespace Screen {
	namespace Cursor {
		public static void set_position (uint16 pos) {
			Cpu.outb (0x3D4, 0x0F);
			Cpu.outb (0x3D5, (uint8)(pos & 0xFF));
		
			Cpu.outb (0x3D4, 0x0E);
			Cpu.outb (0x3D5, (uint8)((pos >> 8) & 0xFF));
		}

		public static uint16 get_position () {
			uint16 pos = 0;

			Cpu.outb (0x3D4, 0x0F);
			pos |= Cpu.inb(0x3D5);
			Cpu.outb (0x3D4, 0x0E);
			pos |= ((uint16)Cpu.inb(0x3D5)) << 8;
			return pos;
		}

		public static void enable(uint8 cursor_start = 14, uint8 cursor_end = 15)
		{
			Cpu.outb(0x3D4, 0x0A);
			Cpu.outb(0x3D5, (Cpu.inb(0x3D5) & 0xC0) | cursor_start);
		
			Cpu.outb(0x3D4, 0x0B);
			Cpu.outb(0x3D5, (Cpu.inb(0x3D5) & 0xE0) | cursor_end);
		}

		public static void disable()
		{
			Cpu.outb(0x3D4, 0x0A);
			Cpu.outb(0x3D5, 0x20);
		}
	}

	private Vga *buffer = (Vga*)Vga.MEMORY;
	
	void put_char(uint8 c, uint16 pos = 0, Color color = Color.pack (WHITE, BLACK)) {
		buffer[pos % (Vga.WIDTH * Vga.HEIGHT)] = c | (color << 8);
	}

	void put_string(string s, uint16 pos = 0, Color color = Color.pack (WHITE, BLACK))
	{
		foreach (char c in s)
			put_char (c, pos++, color);
	}

	public void clear () {
		uint16 c = ' ' | (Color.pack(WHITE, BLACK) << 8);
		Memory.setword(buffer, c, Vga.WIDTH * Vga.HEIGHT);
	}
}
