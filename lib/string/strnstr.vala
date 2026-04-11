public char	*strnstr(char *haystack, char *needle, size_t len)
{
	char	*result;
	size_t	len_needle;

	if (*needle == '\0')
		return ((char *)haystack);
	if (len == 0)
		return (null);
	len_needle = strlen(needle);
	result = (char *)haystack;
	while (true)
	{
		result = strchr(result, needle[0]);
		if (result == null || (size_t)(result - haystack) + len_needle > len)
			return (null);
		if (strncmp(result, needle, len_needle) == 0)
			return (result);
		result += 1;
	}
}
