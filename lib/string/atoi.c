#include "libft.h"

int	atoi(const char *str)
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
