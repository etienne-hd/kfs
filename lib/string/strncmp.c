#include "libft.h"

inline static int	strncmp_generic(const t_uchar *c1, const t_uchar *c2,
		size_t n)
{
	while (n--)
	{
		if (*c1 != *c2 || *c1 == '\0' || *c2 == '\0')
			return (*c1 - *c2);
		c1++;
		c2++;
	}
	return (0);
}

static inline size_t	low(void)
{
	return ((size_t)-1 / 255);
}

static inline size_t	high(void)
{
	return (((size_t)-1 / 255) << 7);
}

int	strncmp(const char *s1, const char *s2, size_t n)
{
	size_t	*w1;
	size_t	*w2;

	w1 = (size_t *)s1;
	w2 = (size_t *)s2;
	while (n && ((uintptr_t)w1 & (sizeof(size_t) - 1)))
	{
		if (*(t_uchar *)w1 != *(t_uchar *)w2 || *(t_uchar *)w1 == '\0'
			|| *(t_uchar *)w2 == '\0')
			return (*(t_uchar *)w1 - *(t_uchar *)w2);
		w1 = (size_t *)((t_uchar *)w1 + 1);
		w2 = (size_t *)((t_uchar *)w2 + 1);
		n--;
	}
	while (n >= sizeof(size_t)
		&& ((*w1 != *w2 || ((*w1 - low()) & ~*w1 & high()))))
	{
		w1++;
		w2++;
		n -= sizeof(size_t);
	}
	return (strncmp_generic((t_uchar *)w1, (t_uchar *)w2, n));
}
