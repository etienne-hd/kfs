/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   strcmp.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: nda-cunh <marvin@d42.fr>                   +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2026/01/30 16:21:12 by nda-cunh          #+#    #+#             */
/*   Updated: 2026/01/30 16:21:12 by nda-cunh         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libft.h"

static inline size_t	low(void)
{
	return ((size_t)-1 / 255);
}

static inline size_t	high(void)
{
	return (((size_t)-1 / 255) << 7);
}

static inline int	strcmp_generic(const t_uchar *s1, const t_uchar *s2)
{
	while (*s1 && (*s1 == *s2))
	{
		s1++;
		s2++;
	}
	return (*(unsigned char *)s1 - *(unsigned char *)s2);
}

int	ft_strcmp(const char *s1, const char *s2)
{
	size_t	*w1;
	size_t	*w2;
	t_uchar	*c1;
	t_uchar	*c2;

	c1 = (t_uchar *)s1;
	c2 = (t_uchar *)s2;
	while (((uintptr_t)c1 & 7) != 0)
	{
		if (*c1 != *c2 || !*c1)
			return (*c1 - *c2);
		c1++;
		c2++;
	}
	if (((uintptr_t)c2 & 7) != 0)
		return (strcmp_generic(c1, c2));
	w1 = (size_t *)c1;
	w2 = (size_t *)c2;
	while (*w1 == *w2 && !((*w1 - low()) & ~*w1 & high()))
	{
		w1++;
		w2++;
	}
	return (strcmp_generic((t_uchar *)w1, (t_uchar *)w2));
}
