using Keyboard;

const uint profile_count = 4;
const uint profiles[] = {
	Keymap.KEY_F1,
	Keymap.KEY_F2,
	Keymap.KEY_F3,
	Keymap.KEY_F4,
	0
};


void main() {
	Screen.clear();
	const string text = "kfs #1 - 42";
	Screen.print(text, Color.pack(WHITE, CYAN), Vga.HEIGHT * Vga.WIDTH / 2 - text.size / 2);
	Screen.print_int(6767, Color.pack(RED, WHITE), 123);

	Keyboard.Keymap value = Keyboard.get_key();

	uint current_profile = 0;
	uint16 profile_buffer[Vga.WIDTH * Vga.HEIGHT * profile_count];
	Memory.setword(profile_buffer, ' ' | Color.pack(WHITE, BLACK) << 8, Vga.WIDTH * Vga.HEIGHT * profile_count);
	uint profile_cursor[profile_count];

	while (true)
	{
		if (value != Keyboard.get_key())
		{
			value = Keyboard.get_key();
			char repr = Keymap.get_char(value);
			if (repr != 0) {
				if (Keyboard.key_state[Keymap.KEY_SHIFT] && repr >= 'a' && repr <= 'z')
					Screen.print_char(Keymap.get_char(value) - 32);
				else
					Screen.print_char(Keymap.get_char(value));
			}
			if (value == Keymap.KEY_BACKSPACE)
			{
				Screen.print_char(' ', Color.pack(WHITE, BLACK), Screen.cursor - 1);
				Screen.cursor -= 1;
				Screen.Cursor.set_position((uint16)Screen.cursor);
			}
			uint new_profile = current_profile;
			for (uint i = 0; profiles[i] != 0; i++)
			{
				if (profiles[i] == value)
				{
					new_profile = i;
					break;
				}
			}
			
			if (new_profile != current_profile)
			{
				// Save current profile
				Memory.cpy(&profile_buffer[Vga.WIDTH * Vga.HEIGHT * current_profile], Screen.buffer, Vga.WIDTH * Vga.HEIGHT * 2);
				profile_cursor[current_profile] = Screen.cursor;

				Memory.cpy(Screen.buffer, &profile_buffer[Vga.WIDTH * Vga.HEIGHT * new_profile], Vga.WIDTH * Vga.HEIGHT * 2);
				Screen.cursor = profile_cursor[new_profile];

				Screen.Cursor.set_position((uint16)Screen.cursor);
				current_profile = new_profile;
			}
		}
	}
}