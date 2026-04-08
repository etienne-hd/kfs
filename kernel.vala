using Keyboard;

const uint PROFILE_COUNT = 4; 
const uint8 PROFILES[] = {
	Keymap.KEY_F1,
	Keymap.KEY_F2,
	Keymap.KEY_F3,
	Keymap.KEY_F4,
};

void main() {
	Serial.print ("Kernel started\n");
	Vga.Cursor.enable();
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

		Profile* current = &profiles[current_profile];

		// Check if the key is mapped to a profile
		for (uint8 profile = 0; profile < PROFILE_COUNT; profile++) {
			if (PROFILES[profile] == key) {
				current.save();
				profiles[profile].load();
				current_profile = profile;
				break;
			}
		}

		// CTRL + L
		if (Keyboard.key_state[Keymap.KEY_CTRL]) {
			switch (key)
			{
				case Keymap.KEY_L:
					current.clear();
					current.update_cursor(0);
					continue;
				case Keymap.KEY_X:
					uint16 begin_line = current.cursor - current.cursor % Vga.WIDTH;
					current.update_cursor(begin_line);
					current.clear_line(begin_line);
					continue;
				case Keymap.KEY_LEFT:
					current.move_left();
					continue;
				case Keymap.KEY_RIGHT:
					current.move_right();
					continue;
			}
		}

		// Character
		char c = Keymap.get_char(key);
		if (c != 0 && key != Keymap.KEY_ENTER) {
			if (c >= 'a' && c <= 'z' && Keyboard.key_state[Keymap.KEY_SHIFT])
				Vga.Screen.put_char(c - 32, current.cursor + Vga.WIDTH);
			else
				Vga.Screen.put_char(c, current.cursor + Vga.WIDTH);
		}

		// Backspace / Delete
		if (key == Keymap.KEY_BACKSPACE && current.cursor != 0) {
			Vga.Screen.put_char(' ', current.cursor + Vga.WIDTH - 1);
		}
	
		else if (key == Keymap.KEY_DELETE) {
			Vga.Screen.put_char(' ', current.cursor + Vga.WIDTH);
		}

		// Arrow
		if ((key == Keymap.KEY_BACKSPACE || key == Keymap.KEY_LEFT) && current.cursor != 0) {
			current.update_cursor(current.cursor - 1);
		}
		else if ((c != 0 || key == Keymap.KEY_RIGHT) && current.cursor + 1 < (Vga.HEIGHT - 1) * Vga.WIDTH) {
			current.update_cursor(current.cursor + 1);
		}
		else if ((key == Keymap.KEY_PAGE_DOWN || key == Keymap.KEY_UP) && current.cursor >= Vga.WIDTH) {
			current.update_cursor(current.cursor - Vga.WIDTH);
		}
		else if (key == Keymap.KEY_DOWN && current.cursor + Vga.WIDTH < (Vga.HEIGHT - 1) * Vga.WIDTH) {
			current.update_cursor(current.cursor + Vga.WIDTH);
		}

		// Page Down
		if (key == Keymap.KEY_PAGE_DOWN) {
			current.scroll_down();
		}
	}
}
