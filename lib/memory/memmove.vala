public void	*memmove(void *dest, void *src, size_t n)
{
	uchar	*s = (uchar *)src;
	uchar			*d;

	if (n == 0 || dest == src)
		return (dest);
	d = (uchar *)dest;
	if (dest < src)
		return (memcpy(dest, src, n));
	d += n - 1;
	s += n - 1;
	while (n > 0) {
		*d-- = *s--;
		--n;
	}
	return (dest);
}
