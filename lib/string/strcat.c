#include "libft.h"

char	*strcat(char *dest, const char *src)
{
	const size_t	len = strlen(dest);

	strcpy(dest + len, src);
	return (dest);
}
