
private inline void	*ft_memchr_one(uchar *p, int byte, size_t n)
{
	while (n > 0)
	{
		if (*p == (uchar)byte)
			return (p);
		p += 1;
		--n;
	}
	return (null);
}

public void	*memchr(void *mem, int byte, size_t n)
{
	size_t	test = repeat_byte(byte);
	uchar	*p;
	size_t			word;

	p = (uchar *)mem;
	while (n > 0 && ((uintptr)p & (sizeof(size_t) - 1)) != 0)
	{
		if (*p == (uchar)byte)
			return (p);
		p += 1;
		--n;
	}
	while (n >= sizeof(size_t))
	{
		word = *(size_t *)p;
		word = word ^ test;
		if (((word - low_mask()) & ~word & high_mask()) != 0)
			break ;
		p += sizeof(size_t);
		n -= sizeof(size_t);
	}
	return (ft_memchr_one(p, byte, n));
}
