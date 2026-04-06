private inline void	copy_blocks(size_t **d, size_t **s, size_t *n)
{
	size_t	*ptr_d;
	size_t	*ptr_s;
	size_t	remain;

	remain = *n;
	ptr_d = *d;
	ptr_s = *s;
	while (remain >= (sizeof(size_t) * 4))
	{
		ptr_d[0] = ptr_s[0];
		ptr_d[1] = ptr_s[1];
		ptr_d[2] = ptr_s[2];
		ptr_d[3] = ptr_s[3];
		ptr_d += 4;
		ptr_s += 4;
		remain -= (sizeof(size_t) * 4);
	}
	while (remain >= sizeof(size_t))
	{
		*ptr_d++ = *ptr_s++;
		remain -= sizeof(size_t);
	}
	*d = ptr_d;
	*s = ptr_s;
	*n = remain;
}

public void	*memcpy(void *dest, void *src, size_t n)
{
	uchar	*d;
	uchar	*s;

	d = (uchar *)dest;
	s = (uchar *)src;
	if (dest == null && src == null)
		return (null);
	while (n > 0 && ((uintptr)d & (sizeof(size_t) - 1)) != 0)
	{
		*d++ = *s++;
		--n;
	}
	copy_blocks((size_t **)&d, (size_t **)&s, &n);
	while (n > 0) {
		*d++ = *s++;
		--n;
	}
	return (dest);
}
