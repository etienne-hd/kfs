#include "libft.h"

size_t	strlen(const char *s)
{
	const char	*p = s;
	size_t		w;

	while ((uintptr_t)p & (sizeof(size_t) - 1))
	{
		if (!*p)
			return (p - s);
		++p;
	}
	while (1)
	{
		w = *(const size_t *)p;
		if ((w - (size_t)-1 / 255) & ~w & high_mask())
			break ;
		p += sizeof(size_t);
	}
	while (*p)
		++p;
	return (p - s);
}
