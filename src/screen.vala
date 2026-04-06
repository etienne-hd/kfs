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
