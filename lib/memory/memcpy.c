/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   memcpy.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: nda-cunh <marvin@d42.fr>                   +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2026/01/30 14:24:22 by nda-cunh          #+#    #+#             */
/*   Updated: 2026/01/30 14:24:22 by nda-cunh         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libft.h"

inline static void	copy_blocks(size_t **d, size_t **s, size_t *n)
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

void	*ft_memcpy(void *dest, const void *src, size_t n)
{
	t_uchar	*d;
	t_uchar	*s;

	d = (t_uchar *)dest;
	s = (t_uchar *)src;
	if (!dest && !src)
		return (NULL);
	while (n > 0 && ((uintptr_t)d & (sizeof(size_t) - 1)))
	{
		*d++ = *s++;
		--n;
	}
	copy_blocks((size_t **)&d, (size_t **)&s, &n);
	while (n--)
		*d++ = *s++;
	return (dest);
}
