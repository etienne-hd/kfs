/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   memchr.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: nda-cunh <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/08/24 22:32:50 by nda-cunh          #+#    #+#             */
/*   Updated: 2024/09/25 00:48:28 by nda-cunh         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libft.h"

inline static size_t	make_size_t(unsigned char byte)
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

static inline void	*ft_memchr_one(unsigned char *p, int byte, size_t n)
{
	while (n > 0)
	{
		if (*p == (unsigned char)byte)
			return (p);
		++p;
		--n;
	}
	return (NULL);
}

void	*ft_memchr(const void *mem, int byte, size_t n)
{
	const size_t	test = make_size_t(byte);
	unsigned char	*p;
	size_t			word;

	p = (unsigned char *)mem;
	while (n > 0 && ((uintptr_t)p & (sizeof(size_t) - 1)))
	{
		if (*p == (unsigned char)byte)
			return (p);
		++p;
		--n;
	}
	while (n >= sizeof(size_t))
	{
		word = *(size_t *)p;
		word = word ^ test;
		if ((word - low()) & ~word & high())
			break ;
		p += sizeof(size_t);
		n -= sizeof(size_t);
	}
	return (ft_memchr_one(p, byte, n));
}
