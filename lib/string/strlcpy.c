/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   strlcpy.c                                          :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: nda-cunh <marvin@d42.fr>                   +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2026/01/31 10:38:07 by nda-cunh          #+#    #+#             */
/*   Updated: 2026/01/31 10:38:07 by nda-cunh         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libft.h"

size_t	ft_strlcpy(char *dst, const char *src, size_t size)
{
	const size_t	src_len = ft_strlen(src);
	size_t			copy_len;

	if (size == 0)
		return (src_len);
	if (src_len < size)
		copy_len = src_len;
	else
		copy_len = size - 1;
	ft_memcpy(dst, src, copy_len);
	dst[copy_len] = '\0';
	return (src_len);
}
