using Keyboard;

const uint PROFILE_COUNT = 4; 
const uint8 PROFILES[] = {
	Keymap.KEY_F1,
	Keymap.KEY_F2,
	Keymap.KEY_F3,
	Keymap.KEY_F4,
};

public void kmain() {
	Serial.print ("Kernel started\n");
	Idt.init();
	Vga.Cursor.enable();
	Profile profiles[PROFILE_COUNT];
	for (uint profile = 0; profile < 4; profile++) {
		profiles[profile].init(profile);
	}
	uint8 current_profile = 0;
	profiles[current_profile].load();

	while (true) {
		Cpu.hlt();

		Profile* current = &profiles[current_profile];

		// Mouse
		Mouse.Event mouse_event;
		while ((mouse_event = Mouse.get_event()).initialized == true) {
			uint16 new_cursor = current->cursor;
			int16 new_x = mouse_event.x / 2;
			int16 new_y = (mouse_event.y / 2) * Vga.WIDTH;

			if ((Vga.WIDTH + new_cursor + new_x) / Vga.WIDTH == (Vga.WIDTH + new_cursor) / Vga.WIDTH)
				new_cursor += new_x;
			if (new_cursor - new_y < Vga.WIDTH * (Vga.HEIGHT - 1) && (Vga.WIDTH + new_cursor - new_y >= Vga.WIDTH))
				new_cursor -= new_y;

			if (mouse_event.right_click == true && Mouse.previous_event.right_click == false)
				current->color = (current->color + 1) % 16;
			if (mouse_event.left_click)
				Vga.Screen.put_char(' ', new_cursor + Vga.WIDTH, Color.pack(WHITE, current->color));
			current->update_cursor(new_cursor);
		}

		// Keyboard
		uint8 scancode;
		while ((scancode = Keyboard.queue.pop()) != 0) {
			// Ignore when a key is unpressed
			if ((scancode & 0x80) != 0)
				continue;


			// Check if the scancode is mapped to a profile
			for (uint8 profile = 0; profile < PROFILE_COUNT; profile++) {
				if (PROFILES[profile] == scancode) {
					current.save();
					profiles[profile].load();
					current_profile = profile;
					break;
				}
			}

			// CTRL + ?
			if (Keyboard.key_state[Keymap.KEY_CTRL]) {
				switch (scancode)
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
			char c = Keymap.get_char(scancode);
			if (c != 0 && scancode != Keymap.KEY_ENTER) {
				if (c >= 'a' && c <= 'z' && Keyboard.key_state[Keymap.KEY_SHIFT])
					Vga.Screen.put_char(c - 32, current.cursor + Vga.WIDTH);
				else
					Vga.Screen.put_char(c, current.cursor + Vga.WIDTH);
			}

			// Backspace / Delete
			if (scancode == Keymap.KEY_BACKSPACE && current.cursor != 0) {
				Vga.Screen.put_char(' ', current.cursor + Vga.WIDTH - 1);
			}
			else if (scancode == Keymap.KEY_DELETE) {
				Vga.Screen.put_char(' ', current.cursor + Vga.WIDTH);
			}

			// Arrow
			if ((scancode == Keymap.KEY_BACKSPACE || scancode == Keymap.KEY_LEFT) && current.cursor != 0) {
				current.update_cursor(current.cursor - 1);
			}
			else if (c != 0 || scancode == Keymap.KEY_RIGHT) {
				if (current.cursor + 1 >= (Vga.HEIGHT - 1) * Vga.WIDTH)
				{
					// Auto scroll if the cursor is at the bottom right
					uint16 begin_line = current.cursor - current.cursor % Vga.WIDTH;
					current.update_cursor(begin_line);
					current->scroll_down();
				}
				else
					current.update_cursor(current.cursor + 1);
			}
			else if ((scancode == Keymap.KEY_PAGE_DOWN || scancode == Keymap.KEY_UP) && current.cursor >= Vga.WIDTH) {
				current.update_cursor(current.cursor - Vga.WIDTH);
			}
			else if (scancode == Keymap.KEY_DOWN && current.cursor + Vga.WIDTH < (Vga.HEIGHT - 1) * Vga.WIDTH) {
				current.update_cursor(current.cursor + Vga.WIDTH);
			}

			// Page Down
			if (scancode == Keymap.KEY_PAGE_DOWN) {
				current.scroll_down();
			}
		}
	}
}
