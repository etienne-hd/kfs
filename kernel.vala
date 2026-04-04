
public const int VGA_WIDTH  = 80;
public const int VGA_HEIGHT = 25;
public const size_t VGA_MEMORY = 0xB8000; 
uint16* terminal_buffer = (uint16*)VGA_MEMORY;
// public const KEYBOARD_DATA_PORT 0x60

void main() {
	terminal_buffer[0] = (uint16)('H' | 0x0F00);
}
