public const int VGA_WIDTH  = 80;
public const int VGA_HEIGHT = 25;
public const size_t VGA_MEMORY = 0xB8000; 

namespace Screen
{
	private uint16 *buffer = (uint16*)VGA_MEMORY;
	private uint cursor = 0;

	void print_char(char c, uint8 color = 0xF0, size_t index = -1)
	{
		if (index == -1)
			index = cursor++;
		buffer[index] = c | (color << 8);
	}

	void print(string s, uint8 color = 0x0F, size_t index = -1)
	{
		foreach (char c in s)
		{
			if (index == -1)
				print_char(c, color, index);
			else
			{
				print_char(c, color, index);
				index++;
			}
		}
	}

	void clear()
	{
		for (size_t y = 0; y < VGA_HEIGHT; y++)
		{
			for (size_t x = 0; x < VGA_WIDTH; x++)
			{
				size_t index = y * VGA_WIDTH + x;
				print_char(' ', 0x0F, index);
			}
		}
	}
}