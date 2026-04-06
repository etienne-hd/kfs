using Keyboard;

void main() {
	Profile.init_profiles();
	Profile.load_profile(0);

	uint8 current_profile = 0;
	char key = get_key();
	while (true) {
		char tmp = get_key();
		if (tmp == key)
			continue;
		key = tmp;

		// Check if the key is mapped to a profile
		for (uint8 profile = 0; profile < PROFILE_COUNT; profile++) {
			if (PROFILES[profile] == key) {
				Profile.save_profile(current_profile);
				Profile.load_profile(profile);
				current_profile = profile;
				break;
			}
		}

		// Character
		char c = Keymap.get_char(key);
		if (c != 0 && key != Keymap.KEY_ENTER) {
			if (c >= 'a' && c <= 'z' && Keyboard.key_state[Keymap.KEY_SHIFT])
				Screen.put_char(c - 32, Profile.profiles_cursor[current_profile] + Vga.WIDTH, Color.pack(WHITE, BLACK));
			else
				Screen.put_char(c, Profile.profiles_cursor[current_profile] + Vga.WIDTH, Color.pack(WHITE, BLACK));
		}

		// Arrow
		if (key == Keymap.KEY_LEFT && Profile.profiles_cursor[current_profile] != 0) {
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
