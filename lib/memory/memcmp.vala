public int	memcmp(void* s1, void *s2, size_t n)
{
	size_t	*ptr_s1;
	size_t	*ptr_s2;
	uchar	*ptr_s1_c;
	uchar	*ptr_s2_c;

	if (n == 0)
		return (0);
	ptr_s1 = (size_t *)s1;
	ptr_s2 = (size_t *)s2;
	while (n >= sizeof(size_t) && *ptr_s1 == *ptr_s2)
	{
		ptr_s1 += 1;
		ptr_s2 += 1;
		n -= sizeof(size_t);
	}
	ptr_s1_c = (uchar *)ptr_s1;
	ptr_s2_c = (uchar *)ptr_s2;
	while (*ptr_s1_c == *ptr_s2_c && n > 1)
	{
		ptr_s1_c += 1;
		ptr_s2_c += 1;
		--n;
	}
	return ((uchar) * ptr_s1_c - (uchar) * ptr_s2_c);
}
