namespace Keyboard {
	public bool key_state[0x7F];
	public Queue queue;

	public enum Keymap {
		KEY_Q = 0x10, KEY_W = 0x11, KEY_E = 0x12, KEY_R = 0x13, KEY_T = 0x14,
		KEY_Y = 0x15, KEY_U = 0x16, KEY_I = 0x17, KEY_O = 0x18, KEY_P = 0x19,
		KEY_A = 0x1E, KEY_S = 0x1F, KEY_D = 0x20, KEY_F = 0x21, KEY_G = 0x22,
		KEY_H = 0x23, KEY_J = 0x24, KEY_K = 0x25, KEY_L = 0x26,
		KEY_Z = 0x2C, KEY_X = 0x2D, KEY_C = 0x2E, KEY_V = 0x2F, KEY_B = 0x30,
		KEY_N = 0x31, KEY_M = 0x32,

		KEY_1 = 0x02, KEY_2 = 0x03, KEY_3 = 0x04, KEY_4 = 0x05, KEY_5 = 0x06,
		KEY_6 = 0x07, KEY_7 = 0x08, KEY_8 = 0x09, KEY_9 = 0x0A, KEY_0 = 0x0B,

		KEY_MINUS = 0x0C, KEY_EQUAL = 0x0D, KEY_LBRACKET = 0x1A, KEY_RBRACKET = 0x1B,
		KEY_SEMICOLON = 0x27, KEY_QUOTE = 0x28, KEY_BACKSLASH = 0x2B,
		KEY_COMMA = 0x33, KEY_DOT = 0x34, KEY_SLASH = 0x35,

		KEY_SPACE = 0x39, KEY_ENTER = 0x1C, KEY_BACKSPACE = 0x0E,
		KEY_TAB = 0x0F, KEY_ESC = 0x01, KEY_CAPSLOCK = 0x3A,

		KEY_SHIFT = 0x2A, KEY_CTRL = 0x1D, KEY_ALT = 0x38,

		KEY_LEFT = 0x4B, KEY_RIGHT = 0x4D, KEY_UP = 0x48, KEY_DOWN = 0x50,
		
		KEY_F1 = 0x3B, KEY_F2 = 0x3C, KEY_F3 = 0x3D, KEY_F4 = 0x3E,
		KEY_F5 = 0x3F, KEY_F6 = 0x40, KEY_F7 = 0x41, KEY_F8 = 0x42,
		KEY_F9 = 0x43, KEY_F10 = 0x44, KEY_F11 = 0x57, KEY_F12 = 0x58,

		KEY_PAGE_DOWN = 0x51, KEY_PAGE_UP = 0x49, KEY_DELETE = 0x53;


		public static char get_char(Keymap key) {
			switch (key) {
				case KEY_Q: return 'q'; case KEY_W: return 'w'; case KEY_E: return 'e';
				case KEY_R: return 'r'; case KEY_T: return 't'; case KEY_Y: return 'y';
				case KEY_U: return 'u'; case KEY_I: return 'i'; case KEY_O: return 'o';
				case KEY_P: return 'p'; case KEY_A: return 'a'; case KEY_S: return 's';
				case KEY_D: return 'd'; case KEY_F: return 'f'; case KEY_G: return 'g';
				case KEY_H: return 'h'; case KEY_J: return 'j'; case KEY_K: return 'k';
				case KEY_L: return 'l'; case KEY_Z: return 'z'; case KEY_X: return 'x';
				case KEY_C: return 'c'; case KEY_V: return 'v'; case KEY_B: return 'b';
				case KEY_N: return 'n'; case KEY_M: return 'm';
			
				case KEY_1: return '1'; case KEY_2: return '2'; case KEY_3: return '3';
				case KEY_4: return '4'; case KEY_5: return '5'; case KEY_6: return '6';
				case KEY_7: return '7'; case KEY_8: return '8'; case KEY_9: return '9';
				case KEY_0: return '0';
			
				case KEY_MINUS: return '-'; case KEY_EQUAL: return '=';
				case KEY_LBRACKET: return '['; case KEY_RBRACKET: return ']';
				case KEY_SEMICOLON: return ';'; case KEY_QUOTE: return '\'';
				case KEY_BACKSLASH: return '\\'; case KEY_COMMA: return ',';
				case KEY_DOT: return '.'; case KEY_SLASH: return '/';
			
				case KEY_SPACE: return ' ';
			
				default: return 0;
			}
		}
	}

	[CCode (cname="keyboard_handler")]
	public void handler() {
		uint8 scancode = Cpu.inb(0x60);
		Keyboard.key_state[scancode & 0x7F] = scancode < 0x80;
		Keyboard.queue.push(scancode);
		Cpu.outb(0x20, 0x20);
	}
}
