
public const int VGA_WIDTH  = 80;
public const int VGA_HEIGHT = 25;
public const size_t VGA_MEMORY = 0xB8000; 
uint16* terminal_buffer = (uint16*)VGA_MEMORY;
// public const KEYBOARD_DATA_PORT 0x60


void terminal_initialize() 
{
	size_t terminal_row;
	size_t terminal_column;
	uint8 terminal_color;
	uint16* terminal_buffer = (uint16*)VGA_MEMORY;
	terminal_row = 0;
	terminal_column = 0;
	terminal_color = 0x0F; // White on black
	
	for (size_t y = 0; y < VGA_HEIGHT; y++)
	{
		for (size_t x = 0; x < VGA_WIDTH; x++) {
			size_t index = y * VGA_WIDTH + x;
			terminal_buffer[index] = (uint16)(' ' | (terminal_color << 8));
		}
	}
}
void main() {
	terminal_initialize();
	terminal_buffer[0] = (uint16)('H' | 0x0F00);
}
