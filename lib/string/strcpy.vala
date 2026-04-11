public char	*strcpy (char *dest, char *src) {
	size_t src_len = strlen(src);

	memcpy(dest, src, src_len + 1);
	return (dest);
}
