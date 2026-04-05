using Keyboard;

void main() {
	Screen.clear();
	const string text = "kfs #1 - 42";
	Screen.print(text, Color.pack(WHITE, CYAN), Vga.HEIGHT * Vga.WIDTH / 2 - text.size / 2);
	Screen.print_int(6767, Color.pack(RED, WHITE), 123);

	Keyboard.Keymap value = Keyboard.get_key();
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
		}
	}
}
