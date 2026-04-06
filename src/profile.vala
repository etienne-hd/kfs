using Keyboard;

const uint PROFILE_COUNT = 4; 
const uint8 PROFILES[] = {
	Keymap.KEY_F1,
	Keymap.KEY_F2,
	Keymap.KEY_F3,
	Keymap.KEY_F4,
};

namespace Profile {
	uint16 profiles_buffer[Vga.HEIGHT * Vga.WIDTH * PROFILE_COUNT];
	uint16 profiles_cursor[PROFILE_COUNT];

	void init_profiles() {
		char buffer[64];
		memsetw(profiles_buffer, ' ' | Color.pack(WHITE, BLACK) << 8 , Vga.HEIGHT * Vga.WIDTH * PROFILE_COUNT);
		for (uint profile = 0; profile < PROFILE_COUNT; profile++) {
			profiles_cursor[profile] = 0;
			for (uint i = 0; i < Vga.WIDTH; i++) {
				profiles_buffer[Vga.HEIGHT * Vga.WIDTH * profile + i] = ' ' | Color.pack(WHITE, LIGHT_RED) << 8;
			}
			sprintf(buffer, "42 - Screen #%d", profile);
			for (uint i = 0; buffer[i] != '\0'; i++) {
				profiles_buffer[Vga.HEIGHT * Vga.WIDTH * profile + i  + (Vga.WIDTH / 2 - ((string)buffer).length / 2)] = buffer[i] | Color.pack(WHITE, LIGHT_RED) << 8;
			}
		}
	}

	void load_profile(uint8 profile) {
		update_cursor(profile, profiles_cursor[profile]);
		Memory.cpy(Screen.buffer,  &profiles_buffer[Vga.HEIGHT * Vga.WIDTH * profile], Vga.HEIGHT * Vga.WIDTH * 2);
	}

	void save_profile(uint8 profile) {
		Memory.cpy(&profiles_buffer[Vga.HEIGHT * Vga.WIDTH * profile], Screen.buffer, Vga.HEIGHT * Vga.WIDTH * 2);
	}

	void update_cursor(uint8 profile, uint16 position) {
		profiles_cursor[profile] = position;
		Screen.Cursor.set_position(position + Vga.WIDTH);
	}

}