/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   strnstr.c                                          :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: nda-cunh <marvin@d42.fr>                   +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2026/01/31 09:48:24 by nda-cunh          #+#    #+#             */
/*   Updated: 2026/01/31 09:53:44 by nda-cunh         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libft.h"

char	*ft_strnstr(const char *haystack, const char *needle, size_t len)
{
	char	*unowned;
	size_t	len_needle;

	if (!*needle)
		return ((char *)haystack);
	if (len == 0)
		return (NULL);
	len_needle = ft_strlen(needle);
	unowned = (char *)haystack;
	while (1)
	{
		unowned = ft_strchr(unowned, needle[0]);
		if (!unowned || (size_t)(unowned - haystack) + len_needle > len)
			return (NULL);
		if (ft_strncmp(unowned, needle, len_needle) == 0)
			return (unowned);
		++unowned;
	}
}
