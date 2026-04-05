struct Vga : uint16 {
	public const size_t MEMORY = 0xB8000; 
	public const uint16 WIDTH = 80;
	public const uint16 HEIGHT = 25;
}

namespace Screen {
	namespace Cursor {
		public static void set_position (uint16 pos) {
			outb (0x3D4, 0x0F);
			outb (0x3D5, (uint8)(pos & 0xFF));
		
			outb (0x3D4, 0x0E);
			outb (0x3D5, (uint8)((pos >> 8) & 0xFF));
		}
	}

	private Vga *buffer = (Vga*)Vga.MEMORY;
	private uint cursor = 0;

	void print_char (char c, Color color = Color.pack(WHITE, BLACK), uint index = -1) {
		if (c == '\n' && index == -1)
		{
			cursor = cursor - (cursor % Vga.WIDTH) + Vga.WIDTH;
			return ;
		}
		if (index == -1)
			index = cursor++;
		buffer[index] = c | (color << 8);
	}

	void print (string s, Color color = Color.pack(WHITE, BLACK), uint index = -1) {
		uint cursor_save = cursor;
		if (index != -1)
			cursor = index;
		foreach (char c in s) {
			print_char(c, color);
		}
		if (index == -1)
			Cursor.set_position ((uint16)cursor);
		if (index != -1)
			cursor = cursor_save;
	}

	void clear () {
		Cursor.set_position (0);
		for (uint16 i = 0; i < Vga.HEIGHT * Vga.WIDTH; i++) {
			print_char(' ', Color.pack(WHITE, BLACK), i);
		}
	}
}
