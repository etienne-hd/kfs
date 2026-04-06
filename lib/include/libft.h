#ifndef SLIBC_H
# define SLIBC_H

# include <stddef.h>
# include <stdint.h>

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

int atoi(const char *str);
void free(void* ptr) ;
int isalnum(int c);
int isalpha(int c);
int isascii(int c);
int isdigit(int c);
int isprint(int c);
int isspace(char c);
void* malloc(size_t nmemb) ;
char *strcat(char *dest, const char *src);
char *strchr(const char *s, int c);
int strcmp(const char *s1, const char *s2);
char *strcpy(char *dest, const char *src);
size_t strlen(const char *s);
int strncmp(const char *s1, const char *s2, size_t n);
char *strnstr(const char *haystack, const char *needle, size_t len);
char *strrchr(const char *s, int c);
char *strstr(const char *haystack, const char *needle);
int tolower(int c);
int toupper(int c);

#endif
