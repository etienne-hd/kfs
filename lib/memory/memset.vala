private size_t	*fill_blocks(size_t* ptr, size_t byte, ref size_t n)
{
	while (n >= (sizeof(size_t) * 4))
	{
		ptr[0] = byte;
		ptr[1] = byte;
		ptr[2] = byte;
		ptr[3] = byte;
		ptr += 4;
		n -= (sizeof(size_t) * 4);
	}
	while (n >= sizeof(size_t))
	{
		*ptr++ = byte;
		n -= sizeof(size_t);
	}
	return (ptr);
}

public void	*memset(void *s, int c, size_t n)
{
	size_t	byte = repeat_byte((uchar)c);
	uchar			*ptr_c;
	size_t			*ptr;

	ptr_c = (uchar *)s;
	while (n > 0 && ((uintptr)ptr_c & (sizeof(size_t) - 1)) != 0)
	{
		*ptr_c++ = (uchar)c;
		--n;
	}
	ptr = fill_blocks((size_t *)ptr_c, byte, ref n);
	ptr_c = (uchar *)ptr;
	while (n > 0) {
		*ptr_c++ = (uchar)c;
		--n;
	}
	return (s);
}
