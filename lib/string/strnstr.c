#include "libft.h"

char	*strnstr(const char *haystack, const char *needle, size_t len)
{
	char	*unowned;
	size_t	len_needle;

	if (!*needle)
		return ((char *)haystack);
	if (len == 0)
		return (NULL);
	len_needle = strlen(needle);
	unowned = (char *)haystack;
	while (1)
	{
		unowned = strchr(unowned, needle[0]);
		if (!unowned || (size_t)(unowned - haystack) + len_needle > len)
			return (NULL);
		if (strncmp(unowned, needle, len_needle) == 0)
			return (unowned);
		++unowned;
	}
}
