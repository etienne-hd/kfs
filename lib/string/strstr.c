#include "libft.h"

char	*strstr(const char *haystack, const char *needle)
{
	char	*unowned;
	size_t	len_needle;

	if (!*needle)
		return ((char *)haystack);
	len_needle = strlen(needle);
	unowned = (char *)haystack;
	while (1)
	{
		unowned = strchr(unowned, *needle);
		if (!unowned)
			return (NULL);
		if (strncmp(unowned, needle, len_needle) == 0)
			return (unowned);
		unowned++;
	}
}
