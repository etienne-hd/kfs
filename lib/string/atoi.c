/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   atoi.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: nda-cunh <marvin@d42.fr>                   +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2026/01/31 09:19:17 by nda-cunh          #+#    #+#             */
/*   Updated: 2026/01/31 09:19:17 by nda-cunh         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libft.h"

int	ft_atoi(const char *str)
{
	int	sign;
	int	result;

	result = 0;
	while ((unsigned char)(*str - 9) <= 4 || *str == ' ')
		++str;
	sign = 1 - ((*str == '-') << 1);
	if (*str == '-' || *str == '+')
		++str;
	while ((unsigned char)(*str - '0') <= 9)
	{
		result = (result << 3) + (result << 1) + (*str - '0');
		++str;
	}
	return ((int)(result * sign));
}
