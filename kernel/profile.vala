using Keyboard;

public struct Profile {
	uint id;
	uint16 buffer[Vga.HEIGHT * Vga.WIDTH];
	uint16 cursor;

	public void init (uint id) {
		this.id = id;
		
		// Initialize profile
		memsetw(&this.buffer[Vga.WIDTH], ' ' | Color.pack(WHITE, BLACK) << 8 , (Vga.HEIGHT - 1) * Vga.WIDTH);
		// Draw horizontal line
		memsetw(this.buffer, ' ' | Color.pack(WHITE, LIGHT_RED) << 8 , Vga.WIDTH);
		// Write title
		uint8 title[32];
		sprintf(title, "42 - Screen #%d", (int)id);
		for (uint i = 0; title[i] != '\0'; i++) {
			this.buffer[i + (Vga.WIDTH / 2 - ((string)title).length / 2)] = title[i] | Color.pack(WHITE, LIGHT_RED) << 8;
		}
	}

	public void move_left () {
		bool found = false;
		for (uint16 i = this.cursor + Vga.WIDTH - 1; i > Vga.WIDTH; i--) {
			uint8 c = (uint8)(Vga.Screen.buffer[i]);
			if (c != ' ')
			{
				this.update_cursor(i - Vga.WIDTH);
				found = true;
				break;
			}
		}
		if (!found)
			this.update_cursor(0);
	}

	public void move_right () {
		bool found = false;
		for (uint16 i = this.cursor + Vga.WIDTH + 1; i < Vga.WIDTH * Vga.HEIGHT; i++) {
			uint8 c = (uint8)(Vga.Screen.buffer[i]);
			if (c != ' ')
			{
				this.update_cursor(i - Vga.WIDTH);
				found = true;
				break;
			}
		}
		if (!found)
			this.update_cursor(Vga.WIDTH * (Vga.HEIGHT - 1) - 1);
	}

	public void clear () {
		Memory.setword(Vga.Screen.buffer + Vga.WIDTH, ' ' | Color.pack(WHITE, BLACK) << 8, Vga.WIDTH * (Vga.HEIGHT - 1));
	}

	public void clear_line (uint line) {
		Memory.setword(Vga.Screen.buffer + line + Vga.WIDTH, ' ' | Color.pack(WHITE, BLACK) << 8, Vga.WIDTH);
	}

	public void scroll_down () {
		Memory.cpy(Vga.Screen.buffer + Vga.WIDTH, Vga.Screen.buffer + Vga.WIDTH * 2,  Vga.WIDTH * (Vga.HEIGHT - 2) * 2);
		Memory.setword(Vga.Screen.buffer + Vga.WIDTH * (Vga.HEIGHT - 1), ' ' | Color.pack(WHITE, BLACK) << 8, Vga.WIDTH);
	}

	public void update_cursor (uint16 position) {
		this.cursor = position;
		Vga.Cursor.set_position(position + Vga.WIDTH);
	}

	public void load () {
		Vga.Cursor.set_position(this.cursor + Vga.WIDTH);
		Memory.cpy(Vga.Screen.buffer,  this.buffer, Vga.HEIGHT * Vga.WIDTH * 2);
	}

	public void save () {
		Memory.cpy(this.buffer,  Vga.Screen.buffer, Vga.HEIGHT * Vga.WIDTH * 2);
	}
}
