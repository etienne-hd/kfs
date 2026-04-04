/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   strrchr.c                                          :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: nda-cunh <marvin@d42.fr>                   +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2026/01/31 10:51:00 by nda-cunh          #+#    #+#             */
/*   Updated: 2026/01/31 10:51:00 by nda-cunh         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libft.h"

inline static size_t	mask(t_uchar byte)
{
	return (byte * ((size_t)-1 / 0xFF));
}

inline static size_t	low(void)
{
	return ((size_t)-1 / 255);
}

inline static size_t	high(void)
{
	return ((size_t)-1 / 255 << 7);
}

inline static char	*strrchr_generic(const char *s, int c, size_t n)
{
	const t_uchar	ch = (t_uchar)c;

	while (n > 0)
	{
		if (s[n - 1] == ch)
			return ((char *)(s + n - 1));
		n--;
	}
	return (NULL);
}

char	*strrchr(const char *s, int c)
{
	const size_t	c_mask = mask((t_uchar)c);
	size_t			n;
	size_t			xor_word;

	n = strlen(s);
	if ((t_uchar)c == '\0')
		return ((char *)(s + n));
	s += n;
	while (n > 0 && ((uintptr_t)s & 7))
	{
		if (*--s == (t_uchar)c)
			return ((char *)s);
		--n;
	}
	while (n >= 8)
	{
		xor_word = (*(size_t *)(s - 8)) ^ c_mask;
		if ((xor_word - low()) & ~xor_word & high())
			break ;
		s -= 8;
		n -= 8;
	}
	return (strrchr_generic(s - n, c, n));
}
