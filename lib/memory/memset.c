/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   memset.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: nda-cunh <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2022/03/28 15:46:08 by nda-cunh          #+#    #+#             */
/*   Updated: 2024/09/25 00:49:40 by nda-cunh         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libft.h"

inline static size_t	make_size_t(t_uchar byte)
{
	return (byte * ((size_t)-1 / 0xFF));
}

inline static size_t	*fill_blocks(size_t *ptr, size_t byte, size_t *n)
{
	while (*n >= (sizeof(size_t) * 4))
	{
		ptr[0] = byte;
		ptr[1] = byte;
		ptr[2] = byte;
		ptr[3] = byte;
		ptr += 4;
		*n -= (sizeof(size_t) * 4);
	}
	while (*n >= sizeof(size_t))
	{
		*ptr++ = byte;
		*n -= sizeof(size_t);
	}
	return (ptr);
}

void	*memset(void *s, int c, size_t n)
{
	const size_t	byte = make_size_t((t_uchar)c);
	t_uchar			*ptr_c;
	size_t			*ptr;

	ptr_c = (t_uchar *)s;
	while (n > 0 && ((uintptr_t)ptr_c & (sizeof(size_t) - 1)))
	{
		*ptr_c++ = (t_uchar)c;
		--n;
	}
	ptr = fill_blocks((size_t *)ptr_c, byte, &n);
	ptr_c = (t_uchar *)ptr;
	while (n--)
		*ptr_c++ = (t_uchar)c;
	return (s);
}
