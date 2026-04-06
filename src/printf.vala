private enum FormatFlag {
	NONE,
	PERCENT,
	String,
	Integer;


	public static FormatFlag from_string(string s) {
		char c1 = s[0];
		switch (c1) {
			case 's':
				return FormatFlag.String;
			case 'd':
				return FormatFlag.Integer;
			default:
				return FormatFlag.NONE;
		}
	}
}

private int handle_int (uint8* dest, int v) {
	uint8 buffer_tmp[11];
	int index = 10;
	uint value;
	uint nbr;
	bool is_neg;

	// Handle negative value
	if (v < 0) {
		is_neg = true;
		nbr = (uint)(-v);
	}
	else {
		is_neg = false;
		nbr = (uint)v;
	}

	// Handle number
	do {
		uint q = nbr / 10;
		buffer_tmp[index] = (char)((nbr - q * 10) + '0');
		nbr = q;
		--index;
	} while (nbr > 0);

	if (is_neg)
		buffer_tmp[index--] = '-';

	int start = index + 1;
	int size = 11 - start;
	Memory.cpy(dest, (uint8*)buffer_tmp + start, size);
	return size;
}

[PrintfFormat]
public void sprintf(uint8[] buffer, string format, ...) {
	va_list list = va_list();
	vsprintf(buffer, format, list);
}

public void vsprintf(uint8[] buffer, string format, va_list list) {
	uint8* base_ptr = (uint8*)buffer;
    int begin = 0;

	unowned string ptr = format;

	while (true) {
		int index = ptr.index_of_char('%');
		// No more format (end of string)
		if (index == -1) {
			Memory.cpy(((string)(buffer)).offset(begin), ptr, ptr.size);
			break;
		}
		// Format
		Memory.cpy(((string)(buffer)).offset(begin), ptr, index);
		begin += index;
		ptr = ptr.offset(index);
		FormatFlag flag = FormatFlag.from_string(ptr.offset(1));
		switch (flag) {
			case FormatFlag.String:
				unowned string s = list.arg();
				Memory.cpy(((string)(buffer)).offset(begin), s, s.size);
				begin += s.size;
				break;
			case FormatFlag.Integer:
				int v = list.arg();
				begin += handle_int((uint8[])((uint8*)buffer + begin), v);
				break;
			default:
				Memory.cpy(((string)(buffer)).offset(begin), ptr, 1);
				begin++;
				break;
			}
		ptr = ptr.offset(2); // 2 characters for format (ex: %s) TODO : handle more complex format (ex: %zu)
	}
}
