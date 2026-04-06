using Keyboard;

void main() {
	Screen.clear();
	char buffer[67];
	sprintf(buffer, "%d, Hello World!", 42);
	Screen.put_string((string)buffer, 0, Color.pack(LIGHT_CYAN, LIGHT_MAGENTA));
	Screen.Cursor.set_position(16);
}
