void main() {
	Screen.clear();
	const string center_value = "KFS #1 - 42";
	Screen.print(center_value, Color.pack(WHITE, CYAN), Vga.HEIGHT * Vga.WIDTH / 2 - center_value.size / 2);
}
