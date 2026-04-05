#include "libft.h"

size_t	strlcpy(char *dst, const char *src, size_t size)
{
	const size_t	src_len = strlen(src);
	size_t			copy_len;

	if (size == 0)
		return (src_len);
	if (src_len < size)
		copy_len = src_len;
	else
		copy_len = size - 1;
	memcpy(dst, src, copy_len);
	dst[copy_len] = '\0';
	return (src_len);
}
