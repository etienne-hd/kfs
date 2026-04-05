
public const int VGA_WIDTH  = 80;
public const int VGA_HEIGHT = 25;
public const size_t VGA_MEMORY = 0xB8000; 
uint16* terminal_buffer = (uint16*)VGA_MEMORY;
uint cursor_position = 0;

void terminal_clear()
{
	for (size_t y = 0; y < VGA_HEIGHT; y++)
	{
		for (size_t x = 0; x < VGA_WIDTH; x++)
		{
			size_t index = y * VGA_WIDTH + x;
			terminal_buffer[index] = (uint16)(' ' | ((0xF | 0x0 << 4) << 8));
		}
	}
	cursor_position = 0;	
}

void print(string s, int color)
{
	foreach (char c in s)
	{
		if (c == '\n')
		{
			cursor_position -= cursor_position % VGA_WIDTH;
			cursor_position += VGA_WIDTH;
			continue;
		}
		terminal_buffer[cursor_position] = (uint16)(c | color);
		cursor_position++;
	}
}

void main() {
	terminal_clear();
	print("Hello, World!\n", 0x3F00);
	print("Hello, World!\n", 0x3F00);
	print("Hello, World!\n", 0x3F00);
	print("Hello, World!\n", 0x3F00);
	print("\n\n\n\n", 0x3F00);
	print("Hello, World!\n", 0x3F00);
	print("Hello, World!\n", 0x3F00);
	print("Hello, World!\n", 0x3F00);
	print("Hello, World!\n", 0x3F00);
	print("FELIS NAVIDAD\n", 0x3F00);

}
