public char	*strstr(char *haystack, char *needle)
{
	char	*result;
	size_t	len_needle;

	if (*needle == '\0')
		return ((char *)haystack);
	len_needle = strlen(needle);
	result = (char *)haystack;
	while (true)
	{
		result = strchr(result, *needle);
		if (result == null)
			return (null);
		if (strncmp(result, needle, len_needle) == 0)
			return (result);
		result += 1;
	}
}
