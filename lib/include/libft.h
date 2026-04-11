#pragma once

# include <stddef.h>
# include <stdint.h>

inline static size_t	repeat_byte(unsigned char byte)
{
	return (byte * ((size_t)-1 / 0xFF));
}

inline static size_t	low_mask(void)
{
	return ((size_t)-1 / 255);
}

inline static size_t	high_mask(void)
{
	return ((size_t)-1 / 255 << 7);
}
