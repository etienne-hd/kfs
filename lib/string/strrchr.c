#include "libft.h"

inline static char	*strrchr_generic(const char *s, int c, size_t n)
{
	const t_uchar	ch = (t_uchar)c;

	while (n > 0)
	{
		if (s[n - 1] == ch)
			return ((char *)(s + n - 1));
		n--;
	}
	return (NULL);
}

char	*strrchr(const char *s, int c)
{
	const size_t	c_mask = repeat_byte((t_uchar)c);
	size_t			n;
	size_t			xor_word;

	n = strlen(s);
	if ((t_uchar)c == '\0')
		return ((char *)(s + n));
	s += n;
	while (n > 0 && ((uintptr_t)s & 7))
	{
		if (*--s == (t_uchar)c)
			return ((char *)s);
		--n;
	}
	while (n >= 8)
	{
		xor_word = (*(size_t *)(s - 8)) ^ c_mask;
		if ((xor_word - low_mask()) & ~xor_word & high_mask())
			break ;
		s -= 8;
		n -= 8;
	}
	return (strrchr_generic(s - n, c, n));
}
