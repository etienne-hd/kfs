#include "libft.h"

size_t	strlcat(char *dst, const char *src, size_t size)
{
	size_t	dst_len;
	size_t	src_len;

	if (!dst && size == 0)
		return (strlen(src));
	dst_len = strlen(dst);
	src_len = strlen(src);
	if (size <= dst_len)
		return (size + src_len);
	if (size == 0)
		return (src_len);
	memcpy(dst + dst_len, src, size - dst_len - 1);
	dst[size - 1] = '\0';
	return (dst_len + src_len);
}
