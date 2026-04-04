/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   memmove.c                                          :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: nda-cunh <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/08/29 02:47:40 by nda-cunh          #+#    #+#             */
/*   Updated: 2024/08/29 02:48:01 by nda-cunh         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libft.h"

void	*memmove(void *dest, const void *src, size_t n)
{
	const t_uchar	*s = (const t_uchar *)src;
	t_uchar			*d;

	if (n == 0 || dest == src)
		return (dest);
	d = (t_uchar *)dest;
	if (dest < src)
		return (memcpy(dest, src, n));
	d += n - 1;
	s += n - 1;
	while (n--)
		*d-- = *s--;
	return (dest);
}
