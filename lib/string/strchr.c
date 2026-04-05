#include "libft.h"

inline static size_t	make_size_t(t_uchar byte)
{
	return (byte * ((size_t)-1 / 0xFF));
}

inline static size_t	low(void)
{
	return ((size_t)-1 / 255);
}

inline static size_t	high(void)
{
	return ((size_t)-1 / 255 << 7);
}

static inline char	*simple_strchr(const char *s, int c)
{
	t_uchar	*pc;

	pc = (t_uchar *)s;
	while (*pc != (t_uchar)c)
	{
		if (*pc == '\0')
			return (NULL);
		pc++;
	}
	return ((char *)pc);
}

char	*strchr(const char *s, int c)
{
	t_uchar	*pc;
	size_t	xw;
	size_t	w;

	if (c == '\0')
		return ((char *)s + strlen(s));
	pc = (t_uchar *)s;
	while ((uintptr_t)s & (sizeof(size_t) - 1))
	{
		if (*pc == (t_uchar)c)
			return ((char *)pc);
		if (*pc == '\0')
			return (NULL);
		pc++;
	}
	while (1)
	{
		w = *(size_t *)pc;
		xw = w ^ make_size_t((t_uchar) c);
		if (((w - low()) & ~w & high()) || ((xw - low()) & ~xw & high()))
			break ;
		pc += sizeof(size_t);
	}
	return (simple_strchr((const char *)pc, c));
}
