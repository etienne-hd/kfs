/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   strlen.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: nda-cunh <marvin@d42.fr>                   +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2026/01/30 14:56:28 by nda-cunh          #+#    #+#             */
/*   Updated: 2026/01/30 14:56:28 by nda-cunh         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libft.h"

inline static size_t	get_mask(void)
{
	return ((size_t)-1 / 255);
}

inline static size_t	get_high(void)
{
	return ((size_t)-1 / 255 << 7);
}

size_t	ft_strlen(const char *s)
{
	const char	*p = s;
	size_t		w;

	while ((uintptr_t)p & (sizeof(size_t) - 1))
	{
		if (!*p)
			return (p - s);
		++p;
	}
	while (1)
	{
		w = *(const size_t *)p;
		if ((w - get_mask()) & ~w & get_high())
			break ;
		p += sizeof(size_t);
	}
	while (*p)
		++p;
	return (p - s);
}
