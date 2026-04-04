/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   memcmp.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: nda-cunh <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/08/24 23:06:02 by nda-cunh          #+#    #+#             */
/*   Updated: 2024/10/21 01:22:10 by nda-cunh         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libft.h"
#include <unistd.h>

int	ft_memcmp(const void *s1, const void *s2, size_t n)
{
	size_t	*ptr_s1;
	size_t	*ptr_s2;
	t_uchar	*ptr_s1_c;
	t_uchar	*ptr_s2_c;

	if (n == 0)
		return (0);
	ptr_s1 = (size_t *)s1;
	ptr_s2 = (size_t *)s2;
	while (n >= sizeof(size_t) && *ptr_s1 == *ptr_s2)
	{
		++ptr_s1;
		++ptr_s2;
		n -= sizeof(size_t);
	}
	ptr_s1_c = (t_uchar *)ptr_s1;
	ptr_s2_c = (t_uchar *)ptr_s2;
	while (*ptr_s1_c == *ptr_s2_c && n > 1)
	{
		++ptr_s1_c;
		++ptr_s2_c;
		--n;
	}
	return ((t_uchar) * ptr_s1_c - (t_uchar) * ptr_s2_c);
}
