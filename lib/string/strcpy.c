/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   strcpy.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: nda-cunh <marvin@d42.fr>                   +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2026/01/31 06:38:01 by nda-cunh          #+#    #+#             */
/*   Updated: 2026/01/31 06:38:01 by nda-cunh         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libft.h"

char	*strcpy(char *dest, const char *src)
{
	const int	src_len = strlen(src);

	memcpy(dest, src, src_len + 1);
	return (dest);
}
