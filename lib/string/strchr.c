#include "libft.h"

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
		xw = w ^ repeat_byte((t_uchar) c);
		if (((w - low_mask()) & ~w & high_mask()) || ((xw - low_mask()) & ~xw & high_mask()))
			break ;
		pc += sizeof(size_t);
	}
	return (simple_strchr((const char *)pc, c));
}
