void main() {
	Screen.clear();
	const string text = "kfs #1 - 42";
	Screen.print(text, Color.pack(WHITE, CYAN), Vga.HEIGHT * Vga.WIDTH / 2 - text.size / 2);
	Screen.Cursor.set_position(Vga.HEIGHT * Vga.WIDTH / 2 + text.size / 2 + 1);
}
