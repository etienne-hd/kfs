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
	private uint cursor = 0;

	void print_char (char c, Color color = Color.pack(WHITE, BLACK), uint cursor_index = -1) {
		if (c == '\n' && cursor_index == -1)
		{
			cursor = cursor - (cursor % Vga.WIDTH) + Vga.WIDTH;
			Cursor.set_position ((uint16)cursor);
			return ;
		}
		if (cursor_index == -1) {
			cursor_index = cursor++;
			Cursor.set_position ((uint16)cursor);
		}
		buffer[cursor_index] = c | (color << 8);
	}

	void print (string s, Color color = Color.pack(WHITE, BLACK), uint cursor_index = -1) {
		uint cursor_save = cursor;
		if (cursor_index != -1)
			cursor = cursor_index;
		foreach (char c in s) {
			print_char(c, color);
		}
		if (cursor_index == -1)
			Cursor.set_position ((uint16)cursor);
		if (cursor_index != -1)
			cursor = cursor_save;
	}

	void print_int (int value, Color color = Color.pack(WHITE, BLACK), uint cursor_index = -1) {
		char buffer[12];
		int index = 11;
		bool is_neg = value < 0;
		int res;

		uint cursor_save = cursor;
		if (cursor_index != -1)
			cursor = cursor_index;

		if (is_neg)
			value *= -1;
		buffer[index--] = 0;
		if (value == 0)
			buffer[index] = '0';
		else {
			while (value != 0) {
				res = (value / 10);
				buffer[index] = (char)((value - (res * 10)) + '0');
				value = res;
				if (value != 0)
					index--;
			}
		}
		if (is_neg) {
			index--;
			buffer[index] = '-';
		}
		print((string)&buffer[index], color);

		if (cursor_index == -1)
			Cursor.set_position ((uint16)cursor);
		if (cursor_index != -1)
			cursor = cursor_save;
	}

	void clear () {
		Cursor.set_position (0);
		var color = Color.pack(WHITE, BLACK);
		uint16 c = ' ' | (color << 8);
		Memory.setword(buffer, c, Vga.WIDTH * Vga.HEIGHT);
	}
}
