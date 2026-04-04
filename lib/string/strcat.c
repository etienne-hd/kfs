/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   strcat.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: nda-cunh <marvin@d42.fr>                   +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2026/01/31 09:32:15 by nda-cunh          #+#    #+#             */
/*   Updated: 2026/01/31 09:32:15 by nda-cunh         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libft.h"

char	*strcat(char *dest, const char *src)
{
	const size_t	len = ft_strlen(dest);

	ft_strcpy(dest + len, src);
	return (dest);
}
