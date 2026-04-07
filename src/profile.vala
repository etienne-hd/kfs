using Keyboard;

struct Profile {
	uint id;
	uint16 buffer[Vga.HEIGHT * Vga.WIDTH];
	uint16 cursor;

	public void init(uint id) {
		this.id = id;
		this.cursor = 0;
		
		memsetw(&this.buffer[Vga.WIDTH], ' ' | Color.pack(WHITE, BLACK) << 8 , (Vga.HEIGHT - 1) * Vga.WIDTH);
		memsetw(this.buffer, ' ' | Color.pack(WHITE, LIGHT_RED) << 8 , Vga.WIDTH);
		uint8 title[32];
		sprintf(title, "42 - Screen #%d", (int)id);
		for (uint i = 0; title[i] != '\0'; i++) {
			this.buffer[i + (Vga.WIDTH / 2 - ((string)title).length / 2)] = title[i] | Color.pack(WHITE, LIGHT_RED) << 8;
		}
	}

	public void update_cursor(uint16 position) {
		this.cursor = position;
		Vga.Cursor.set_position(position + Vga.WIDTH);
	}

	public void load() {
		update_cursor(this.cursor);
		Memory.cpy(Vga.Screen.buffer,  this.buffer, Vga.HEIGHT * Vga.WIDTH * 2);
	}

	public void save() {
		Memory.cpy(this.buffer,  Vga.Screen.buffer, Vga.HEIGHT * Vga.WIDTH * 2);
	}
}
