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
	Screen.put_string("42", 0);
	Screen.Cursor.set_position(2);
}