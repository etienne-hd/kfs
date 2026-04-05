#include "libft.h"

static inline void	*ft_memchr_one(unsigned char *p, int byte, size_t n)
{
	while (n > 0)
	{
		if (*p == (unsigned char)byte)
			return (p);
		++p;
		--n;
	}
	return (NULL);
}

void	*memchr(const void *mem, int byte, size_t n)
{
	const size_t	test = repeat_byte(byte);
	unsigned char	*p;
	size_t			word;

	p = (unsigned char *)mem;
	while (n > 0 && ((uintptr_t)p & (sizeof(size_t) - 1)))
	{
		if (*p == (unsigned char)byte)
			return (p);
		++p;
		--n;
	}
	while (n >= sizeof(size_t))
	{
		word = *(size_t *)p;
		word = word ^ test;
		if ((word - low_mask()) & ~word & high_mask())
			break ;
		p += sizeof(size_t);
		n -= sizeof(size_t);
	}
	return (ft_memchr_one(p, byte, n));
}
