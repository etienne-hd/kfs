using Keyboard;

const uint PROFILE_COUNT = 4; 
const uint8 PROFILES[] = {
	Keymap.KEY_F1,
	Keymap.KEY_F2,
	Keymap.KEY_F3,
	Keymap.KEY_F4,
};

struct Profile {
	uint id;
	uint16 buffer[Vga.HEIGHT * Vga.WIDTH];
	uint16 cursor;

	public Profile(uint id) {
		this.id = id;
		this.cursor = 0;
		
		memsetw(this.buffer, ' ' | Color.pack(WHITE, BLACK) << 8 , Vga.HEIGHT * Vga.WIDTH);
		for (uint i = 0; i < Vga.WIDTH; i++) {
			this.buffer[Vga.HEIGHT * Vga.WIDTH + i] = ' ' | Color.pack(WHITE, LIGHT_RED) << 8;
		}
		uint8 fortnite[32];
		sprintf(fortnite, "42 - Screen #%d", (int)id);
		for (uint i = 0; buffer[i] != '\0'; i++) {
			this.buffer[Vga.HEIGHT * Vga.WIDTH + i + (Vga.WIDTH / 2 - ((string)fortnite).length / 2)] = buffer[i] | Color.pack(WHITE, LIGHT_RED) << 8;
		}
	}

	public void update_cursor(uint16 position) {
		this.cursor = position;
		Screen.Cursor.set_position(position + Vga.WIDTH);
	}

	public void load() {
		update_cursor(this.cursor);
		Memory.cpy(Screen.buffer,  &this.buffer, Vga.HEIGHT * Vga.WIDTH * 2);
	}

	public void save() {
		Memory.cpy(&this.buffer,  Screen.buffer, Vga.HEIGHT * Vga.WIDTH * 2);
	}
}
