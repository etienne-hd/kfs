#include "libft.h"

inline static size_t	*fill_blocks(size_t *ptr, size_t *n)
{
	while (*n >= (sizeof(size_t) * 4))
	{
		ptr[0] = 0;
		ptr[1] = 0;
		ptr[2] = 0;
		ptr[3] = 0;
		ptr += 4;
		*n -= (sizeof(size_t) * 4);
	}
	while (*n >= sizeof(size_t))
	{
		*ptr++ = 0;
		*n -= sizeof(size_t);
	}
	return (ptr);
}

void	bzero(void *s, size_t n)
{
	t_uchar	*p_c;
	size_t	*p_l;

	p_c = (t_uchar *)s;
	while (((uintptr_t)p_c & (sizeof(size_t) - 1)) && n > 0)
	{
		*p_c++ = 0;
		--n;
	}
	p_l = (size_t *)p_c;
	p_l = fill_blocks(p_l, &n);
	p_c = (t_uchar *)p_l;
	while (n > 0)
	{
		*p_c++ = 0;
		--n;
	}
}
