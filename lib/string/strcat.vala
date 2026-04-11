public char	*strcat (char *dest, char *src) {
	size_t	len = strlen(dest);

	strcpy(dest + len, src);
	return (dest);
}
