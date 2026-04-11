private inline char	*simple_strchr (char *s, int c) {
	uint8	*pc;

	pc = (uint8 *)s;
	while (*pc != (uint8)c)
	{
		if (*pc == '\0')
			return (null);
		pc++;
	}
	return ((char *)pc);
}

public char	*strchr (char *s, int c) {
	uint8	*pc;
	size_t	xw;
	size_t	w;

	if (c == '\0')
		return ((char *)s + strlen(s));
	pc = (uint8 *)s;
	while (((size_t)pc & (sizeof(size_t) - 1)) != 0)
	{
		if (*pc == (uint8)c)
			return ((char *)pc);
		if (*pc == '\0')
			return (null);
		pc++;
	}
	while (true)
	{
		w = *(size_t *)pc;
		xw = w ^ repeat_byte((uint8) c);
		if ((((w - low_mask()) & ~w & high_mask()) != 0) || (((xw - low_mask()) & ~xw & high_mask()) != 0))
			break;
		pc += sizeof(size_t);
	}
	return (simple_strchr((char *)pc, c));
}
