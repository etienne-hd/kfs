/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   strstr.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: nda-cunh <marvin@d42.fr>                   +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2026/01/31 09:48:48 by nda-cunh          #+#    #+#             */
/*   Updated: 2026/01/31 09:53:45 by nda-cunh         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libft.h"

char	*ft_strstr(const char *haystack, const char *needle)
{
	char	*unowned;
	size_t	len_needle;

	if (!*needle)
		return ((char *)haystack);
	len_needle = ft_strlen(needle);
	unowned = (char *)haystack;
	while (1)
	{
		unowned = ft_strchr(unowned, *needle);
		if (!unowned)
			return (NULL);
		if (ft_strncmp(unowned, needle, len_needle) == 0)
			return (unowned);
		unowned++;
	}
}
