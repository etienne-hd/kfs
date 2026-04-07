using Keyboard;

const uint PROFILE_COUNT = 4; 
const uint8 PROFILES[] = {
	Keymap.KEY_F1,
	Keymap.KEY_F2,
	Keymap.KEY_F3,
	Keymap.KEY_F4,
};

void main() {
	Profile profiles[PROFILE_COUNT];
	for (uint profile = 0; profile < 4; profile++) {
		profiles[profile].init(profile);
	}
	uint8 current_profile = 0;
	profiles[0].load();

	char key = get_key();
	while (true) {
		char tmp_key = get_key();
		if (tmp_key == key)
			continue;
		key = tmp_key;

		// Check if the key is mapped to a profile
		for (uint8 profile = 0; profile < PROFILE_COUNT; profile++) {
			if (PROFILES[profile] == key) {
				profiles[current_profile].save();
				profiles[profile].load();
				current_profile = profile;
				break;
			}
		}

		// CTRL + L
		if (Keyboard.key_state[Keymap.KEY_CTRL]) {
			if (key == Keymap.KEY_L) {
				Memory.setword(Screen.buffer + Vga.WIDTH, ' ' | Color.pack(WHITE, BLACK) << 8, Vga.WIDTH * (Vga.HEIGHT - 1));
				profiles[current_profile].update_cursor(0);
				continue;
			}
			else if (key == Keymap.KEY_X) {
				uint16 begin_line = profiles[current_profile].cursor - profiles[current_profile].cursor % Vga.WIDTH;
				profiles[current_profile].update_cursor(begin_line);
				Memory.setword(Screen.buffer + begin_line + Vga.WIDTH, ' ' | Color.pack(WHITE, BLACK) << 8, Vga.WIDTH);
				continue;
			}
			else if (key == Keymap.KEY_LEFT) {
				bool found = false;
				for (uint16 i = profiles[current_profile].cursor + Vga.WIDTH - 1; i > Vga.WIDTH; i--) {
					uint8 c = (uint8)(Screen.buffer[i]);
					if (c != ' ')
					{
						profiles[current_profile].update_cursor(i - Vga.WIDTH);
						found = true;
						break;
					}
				}
				if (!found)
					profiles[current_profile].update_cursor(0);
				continue;
			}
			else if (key == Keymap.KEY_RIGHT) {
				bool found = false;
				for (uint16 i = profiles[current_profile].cursor + Vga.WIDTH + 1; i < Vga.WIDTH * Vga.HEIGHT; i++) {
					uint8 c = (uint8)(Screen.buffer[i]);
					if (c != ' ')
					{
						profiles[current_profile].update_cursor(i - Vga.WIDTH);
						found = true;
						break;
					}
				}
				if (!found)
					profiles[current_profile].update_cursor(Vga.WIDTH * (Vga.HEIGHT - 1) - 1);
				continue;
			}
		}

		// Character
		char c = Keymap.get_char(key);
		if (c != 0 && key != Keymap.KEY_ENTER) {
			if (c >= 'a' && c <= 'z' && Keyboard.key_state[Keymap.KEY_SHIFT])
				Screen.put_char(c - 32, profiles[current_profile].cursor + Vga.WIDTH);
			else
				Screen.put_char(c, profiles[current_profile].cursor + Vga.WIDTH);
		}

		// Backspace / Delete
		if (key == Keymap.KEY_BACKSPACE && profiles[current_profile].cursor != 0) {
			Screen.put_char(' ', profiles[current_profile].cursor + Vga.WIDTH - 1);
		}
		else if (key == Keymap.KEY_DELETE) {
			Screen.put_char(' ', profiles[current_profile].cursor + Vga.WIDTH);
		}

		// Arrow
		if ((key == Keymap.KEY_BACKSPACE || key == Keymap.KEY_LEFT) && profiles[current_profile].cursor != 0) {
			profiles[current_profile].update_cursor(profiles[current_profile].cursor - 1);
		}
		else if ((c != 0 || key == Keymap.KEY_RIGHT) && profiles[current_profile].cursor + 1 < (Vga.HEIGHT - 1) * Vga.WIDTH) {
			profiles[current_profile].update_cursor(profiles[current_profile].cursor + 1);
		}
		else if ((key == Keymap.KEY_PAGE_DOWN || key == Keymap.KEY_UP) && profiles[current_profile].cursor >= Vga.WIDTH) {
			profiles[current_profile].update_cursor(profiles[current_profile].cursor - Vga.WIDTH);
		}
		else if (key == Keymap.KEY_DOWN && profiles[current_profile].cursor + Vga.WIDTH < (Vga.HEIGHT - 1) * Vga.WIDTH) {
			profiles[current_profile].update_cursor(profiles[current_profile].cursor + Vga.WIDTH);
		}

		// Page Down
		if (key == Keymap.KEY_PAGE_DOWN) {
			Memory.cpy(Screen.buffer + Vga.WIDTH, Screen.buffer + Vga.WIDTH * 2,  Vga.WIDTH * (Vga.HEIGHT - 2) * 2);
			Memory.setword(Screen.buffer + Vga.WIDTH * (Vga.HEIGHT - 1), ' ' | Color.pack(WHITE, BLACK) << 8, Vga.WIDTH);
		}
	}
}
