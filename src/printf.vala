char *handle_int(char *buffer, int v) {
	int64 value = v;
	char buffer_tmp[12];
	uint index = 11;
	bool is_neg = value < 0;

	if (is_neg)
		value *= -1;
	buffer_tmp[index--] = 0;
	if (value == 0)
		buffer_tmp[index] = '0';
	else {
		while (value != 0) {
			int64 p = value / 10;
			buffer_tmp[index] = (char)(value - (p * 10)) + '0';
			value = p;
			if (value != 0)
				index--;
		}
	}
	if (is_neg)
	{
		index--;
		buffer_tmp[index] = '-';
	}
	for (; index < 11; index++)
	{
		*buffer = buffer_tmp[index];
		buffer++;
	}
	return buffer;
}

char *handle_str(char *buffer, char *s) {
	while (*s != '\0') {
		*buffer = *s;
		buffer++;
		s++;
	}
	return buffer;
}

[CCode (sentinel = "")]
void sprintf(char *buffer, char *format, ...) {
	va_list list = va_list();
	vsprintf(buffer, format, list);
}

[CCode (sentinel = "")]
void vsprintf(char *buffer, char *format, va_list list) {
	const string flags[] = {
		"%s", "%d", null
	};

	for (uint i = 0; format[i] != '\0'; i++) {
		bool is_found = false;
		if (format[i] == '%') {
			for (uint j = 0; flags[j] != null; j++) {
				if (strncmp(&format[i], flags[j], flags[j].size) == 0) {
					if (flags[j] == "%s")
						buffer = handle_str(buffer, list.arg());
					else if (flags[j] == "%d")
					buffer = handle_int(buffer, list.arg());
					i += (flags[j].size - 1);
					is_found = true;
					break;
				}
			}
		}
		if (!is_found) {
			*buffer = format[i];
			buffer++;
		}
	}
	*buffer = 0;
}
