namespace Keyboard {
	public bool key_state[0xFF / 2];

	public enum Keymap {
		KEY_Q = 0x10,
		KEY_W = 0x11,
		KEY_E = 0x12,
		KEY_R = 0x13,
		KEY_T = 0x14,
		KEY_Y = 0x15,
		KEY_U = 0x16,
		KEY_I = 0x17,
		KEY_O = 0x18,
		KEY_P = 0x19,
		KEY_A = 0x1E,
		KEY_S = 0x1F,
		KEY_D = 0x20,
		KEY_F = 0x21,
		KEY_G = 0x22,
		KEY_H = 0x23,
		KEY_J = 0x24,
		KEY_K = 0x25,
		KEY_L = 0x26,
		KEY_Z = 0x2C,
		KEY_X = 0x2D,
		KEY_C = 0x2E,
		KEY_V = 0x2F,
		KEY_B = 0x30,
		KEY_N = 0x31,
		KEY_M = 0x32,
		KEY_SPACE = 0x39,
		KEY_BACKSPACE = 0x0E,
		KEY_SHIFT = 0x2A;

		public static char get_char(Keymap key) {
			switch (key) {
                case Keymap.KEY_Q: return 'q';
                case Keymap.KEY_W: return 'w';
                case Keymap.KEY_E: return 'e';
                case Keymap.KEY_R: return 'r';
                case Keymap.KEY_T: return 't';
                case Keymap.KEY_Y: return 'y';
                case Keymap.KEY_U: return 'u';
                case Keymap.KEY_I: return 'i';
                case Keymap.KEY_O: return 'o';
                case Keymap.KEY_P: return 'p';
                case Keymap.KEY_A: return 'a';
                case Keymap.KEY_S: return 's';
                case Keymap.KEY_D: return 'd';
                case Keymap.KEY_F: return 'f';
                case Keymap.KEY_G: return 'g';
                case Keymap.KEY_H: return 'h';
                case Keymap.KEY_J: return 'j';
                case Keymap.KEY_K: return 'k';
                case Keymap.KEY_L: return 'l';
                case Keymap.KEY_Z: return 'z';
                case Keymap.KEY_X: return 'x';
                case Keymap.KEY_C: return 'c';
                case Keymap.KEY_V: return 'v';
                case Keymap.KEY_B: return 'b';
                case Keymap.KEY_N: return 'n';
                case Keymap.KEY_M: return 'm';
				case Keymap.KEY_SPACE: return ' ';
                default: return 0;
            }
		}
	}

	public Keymap get_key()
	{
		Keymap inputdata;
		inputdata = (Keymap)inb(0x60);
		key_state[inputdata & 0x7F] = inputdata < 0x80;
		return inputdata;
	}
}