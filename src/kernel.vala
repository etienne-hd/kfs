using Keyboard;

void main() {
	Profile.init_profiles();
	uint8 current_profile = 0;
	Profile.load_profile(current_profile);

	char key = get_key();
	while (true) {
		char tmp_key = get_key();
		if (tmp_key == key)
			continue;
		key = tmp_key;

		// Check if the key is mapped to a profile
		for (uint8 profile = 0; profile < PROFILE_COUNT; profile++) {
			if (PROFILES[profile] == key) {
				Profile.save_profile(current_profile);
				Profile.load_profile(profile);
				current_profile = profile;
				break;
			}
		}

		// CTRL + L
		if (Keyboard.key_state[Keymap.KEY_CTRL]) {
			if (key == Keymap.KEY_L) {
				Memory.setword(Screen.buffer + Vga.WIDTH, ' ' | Color.pack(WHITE, BLACK) << 8, Vga.WIDTH * (Vga.HEIGHT - 1));
				Profile.update_cursor(current_profile, 0);
				continue;
			}
			else if (key == Keymap.KEY_X) {
				uint16 begin_line = Profile.profiles_cursor[current_profile] - Profile.profiles_cursor[current_profile] % Vga.WIDTH;
				Profile.update_cursor(current_profile, begin_line);
				Memory.setword(Screen.buffer + begin_line + Vga.WIDTH, ' ' | Color.pack(WHITE, BLACK) << 8, Vga.WIDTH);
				continue;
			}
			else if (key == Keymap.KEY_LEFT) {
				bool found = false;
				for (uint16 i = Profile.profiles_cursor[current_profile] + Vga.WIDTH - 1; i > Vga.WIDTH; i--) {
					uint8 c = (uint8)(Screen.buffer[i]);
					if (c != ' ')
					{
						Profile.update_cursor(current_profile, i - Vga.WIDTH);
						found = true;
						break;
					}
				}
				if (!found)
					Profile.update_cursor(current_profile, 0);
				continue;
			}
			else if (key == Keymap.KEY_RIGHT) {
				bool found = false;
				for (uint16 i = Profile.profiles_cursor[current_profile] + Vga.WIDTH + 1; i < Vga.WIDTH * Vga.HEIGHT; i++) {
					uint8 c = (uint8)(Screen.buffer[i]);
					if (c != ' ')
					{
						Profile.update_cursor(current_profile, i - Vga.WIDTH);
						found = true;
						break;
					}
				}
				if (!found)
					Profile.update_cursor(current_profile, Vga.WIDTH * (Vga.HEIGHT - 1) - 1);
				continue;
			}
		}

		// Character
		char c = Keymap.get_char(key);
		if (c != 0 && key != Keymap.KEY_ENTER) {
			if (c >= 'a' && c <= 'z' && Keyboard.key_state[Keymap.KEY_SHIFT])
				Screen.put_char(c - 32, Profile.profiles_cursor[current_profile] + Vga.WIDTH);
			else
				Screen.put_char(c, Profile.profiles_cursor[current_profile] + Vga.WIDTH);
		}

		// Backspace / Delete
		if (key == Keymap.KEY_BACKSPACE && Profile.profiles_cursor[current_profile] != 0) {
			Screen.put_char(' ', Profile.profiles_cursor[current_profile] + Vga.WIDTH - 1);
		}
		else if (key == Keymap.KEY_DELETE) {
			Screen.put_char(' ', Profile.profiles_cursor[current_profile] + Vga.WIDTH);
		}

		// Arrow
		if ((key == Keymap.KEY_BACKSPACE || key == Keymap.KEY_LEFT) && Profile.profiles_cursor[current_profile] != 0) {
			Profile.update_cursor(current_profile, Profile.profiles_cursor[current_profile] - 1);
		}
		else if ((c != 0 || key == Keymap.KEY_RIGHT) && Profile.profiles_cursor[current_profile] + 1 < (Vga.HEIGHT - 1) * Vga.WIDTH) {
			Profile.update_cursor(current_profile, Profile.profiles_cursor[current_profile] + 1);
		}
		else if ((key == Keymap.KEY_PAGE_DOWN || key == Keymap.KEY_UP) && Profile.profiles_cursor[current_profile] >= Vga.WIDTH) {
			Profile.update_cursor(current_profile, Profile.profiles_cursor[current_profile] - Vga.WIDTH);
		}
		else if (key == Keymap.KEY_DOWN && Profile.profiles_cursor[current_profile] + Vga.WIDTH < (Vga.HEIGHT - 1) * Vga.WIDTH) {
			Profile.update_cursor(current_profile, Profile.profiles_cursor[current_profile] + Vga.WIDTH);
		}

		// Page Down
		if (key == Keymap.KEY_PAGE_DOWN) {
			Memory.cpy(Screen.buffer + Vga.WIDTH, Screen.buffer + Vga.WIDTH * 2,  Vga.WIDTH * (Vga.HEIGHT - 2) * 2);
			Memory.setword(Screen.buffer + Vga.WIDTH * (Vga.HEIGHT - 1), ' ' | Color.pack(WHITE, BLACK) << 8, Vga.WIDTH);
		}
	}
}
