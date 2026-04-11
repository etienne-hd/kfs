namespace Vga {
	public const uint16 WIDTH = 80;
	public const uint16 HEIGHT = 25;
	private const size_t MEMORY = 0xB8000; 

	namespace Cursor {
		public const uint16 REGISTER = 0x3D4;
		public const uint16 VALUE = 0x3D5;

		public static void set_position (uint16 pos) {
			Cpu.outb (REGISTER, 0x0F);
			Cpu.outb (VALUE, (uint8)(pos & 0xFF));
		
			Cpu.outb (REGISTER, 0x0E);
			Cpu.outb (VALUE, (uint8)((pos >> 8) & 0xFF));
		}

		public static uint16 get_position () {
			uint16 pos = 0;

			Cpu.outb (REGISTER, 0x0F);
			pos |= Cpu.inb(VALUE);
			Cpu.outb (REGISTER, 0x0E);
			pos |= ((uint16)Cpu.inb(VALUE)) << 8;
			return pos;
		}

		public static void enable (uint8 cursor_start = 14, uint8 cursor_end = 15)
		{
			Cpu.outb(REGISTER, 0x0A);
			Cpu.outb(VALUE, (Cpu.inb(0x3D5) & 0xC0) | cursor_start);
		
			Cpu.outb(REGISTER, 0x0B);
			Cpu.outb(VALUE, (Cpu.inb(0x3D5) & 0xE0) | cursor_end);
		}

		public static void disable ()
		{
			Cpu.outb(REGISTER, 0x0A);
			Cpu.outb(VALUE, 0x20);
		}
	}

	namespace Screen {
		private uint16 *buffer = (uint16 *)Vga.MEMORY;
	
		public void put_char (uint8 c, uint16 pos = 0, Color color = Color.pack (WHITE, BLACK)) {
			buffer[pos % (Vga.WIDTH * Vga.HEIGHT)] = c | (color << 8);
		}

		public void put_string (string s, uint16 pos = 0, Color color = Color.pack (WHITE, BLACK))
		{
			foreach (char c in s)
				put_char (c, pos++, color);
		}

		public void clear () {
			uint16 c = ' ' | (Color.pack(WHITE, BLACK) << 8);
			Memory.setword(buffer, c, Vga.WIDTH * Vga.HEIGHT);
		}
	}
}
