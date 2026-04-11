#pragma once

static int	isalpha(int c)
{
	return (('a' <= c && 'z' >= c) || ('A' <= c && 'Z' >= c));
}

static int	isascii(int c)
{
	return (c >= 0 && c <= 127);
}

static int	isdigit(int c)
{
	return ('0' <= c && '9' >= c);

}
static int	isprint(int c)
{
	return (c >= ' ' && c <= '~');
}

static int	isspace(char c)
{
	return ((c >= 9 && c <= 13) || c == ' ');
}

static int	tolower(int c)
{
	if (c >= 'A' && c <= 'Z')
		return (c + 32);
	return ((c));
}

static int	toupper(int c)
{
	if (c >= 'a' && c <= 'z')

		return (c - 32);
	return (c);
}

static int	isalnum(int c)
{
	return (isalpha(c) || isdigit(c));
}

