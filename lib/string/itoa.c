/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   itoa.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: nda-cunh <marvin@d42.fr>                   +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2026/01/31 13:44:20 by nda-cunh          #+#    #+#             */
/*   Updated: 2026/01/31 13:44:20 by nda-cunh         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libft.h"

char	*ft_itoa(int n)
{
	const char		*zero = "0";
	char			buf[12];
	char			*ptr;
	unsigned int	nbr;
	unsigned int	q;

	ptr = buf + 11;
	*ptr = '\0';
	if (n == 0)
		return (ft_strdup(zero));
	if (n < 0)
		nbr = (unsigned int)-n;
	else
		nbr = (unsigned int)n;
	while (nbr > 0)
	{
		q = (nbr / 10);
		*--ptr = (nbr - (q * 10)) + '0';
		nbr = q;
	}
	if (n < 0)
		*--ptr = '-';
	return (ft_strdup(ptr));
}
