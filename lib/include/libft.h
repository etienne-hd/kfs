#ifndef LIBFT_H
# define LIBFT_H

// # include <ctype.h>
# include <stddef.h>
# include <stdint.h>
// # include <unistd.h>

typedef unsigned char	t_uchar;
typedef unsigned int	t_uint;
typedef int8_t			t_int8;
typedef int16_t			t_int16;
typedef int32_t			t_int32;
typedef int64_t			t_int64;
typedef uint8_t			t_uint8;
typedef uint16_t		t_uint16;
typedef uint32_t		t_uint32;
typedef uint64_t		t_uint64;

inline static size_t	repeat_byte(t_uchar byte)
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

// memory/*.c
void					*memmove(void *dest, const void *src, size_t n);
int						memcmp(const void *s1, const void *s2, size_t n);
void					*memchr(const void *mem, int byte, size_t n);
void					*memset(void *s, int c, size_t n);
void					bzero(void *s, size_t n);
void					*memcpy(void *dest, const void *src, size_t n);

// string/*.c
int						strncmp(const char *s1, const char *s2, size_t n);
char					*strchr(const char *s, int c);
int						strcmp(const char *s1, const char *s2);
int						atoi(const char *str);
char					*strcat(char *dest, const char *src);
size_t					strlen(const char *s);
char					*strcpy(char *dest, const char *src);

// alloc/*.c
// char					*strdup(const char *s1);
// void					*calloc(size_t count, size_t size);

int isalnum(int c);
int isalpha(int c);
int isascii(int c);
int isdigit(int c);
int isprint(int c);
int isspace(char c);
int tolower(int c);
int toupper(int c);
#endif
