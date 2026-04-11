public int atoi (string str) {
	int	sign;
	int	result;
	char *_str = (char *)str;

	result = 0;
	while ((uchar)(*_str - 9) <= 4 || *_str == ' ')
		_str += 1;
	sign = 1 - ((int)(*_str == '-') << 1);
	if (*_str == '-' || *_str == '+')
		_str += 1;
	while ((uchar)(*_str - '0') <= 9)
	{
		result = (result << 3) + (result << 1) + (*_str - '0');
		_str += 1;
	}
	return ((int)(result * sign));
}
