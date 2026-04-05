#include "libft.h"

char	*strcpy(char *dest, const char *src)
{
	const int	src_len = strlen(src);

	memcpy(dest, src, src_len + 1);
	return (dest);
}
