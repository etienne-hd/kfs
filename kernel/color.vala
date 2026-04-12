public enum Color {
	BLACK,
	BLUE,
	GREEN,
	CYAN,
	RED,
	MAGENTA,
	BROWN,
	GRAY,
	DARK_GRAY,
	LIGHT_BLUE,
	LIGHT_GREEN,
	LIGHT_CYAN,
	LIGHT_RED,
	LIGHT_MAGENTA,
	YELLOW,
	WHITE;

	public inline static Color pack (Color fg, Color bg) {
		// return (fg | bg << 4);
		return (fg | (bg & 0x07) << 4);
	}
}
