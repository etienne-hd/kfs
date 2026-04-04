/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   libft.h                                            :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: nda-cunh <marvin@d42.fr>                   +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2026/01/30 10:29:20 by nda-cunh          #+#    #+#             */
/*   Updated: 2026/01/30 10:29:20 by nda-cunh         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

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

// memory/*.c
void					*ft_memmove(void *dest, const void *src, size_t n);
int						ft_memcmp(const void *s1, const void *s2, size_t n);
void					*ft_memchr(const void *mem, int byte, size_t n);
void					*ft_memset(void *s, int c, size_t n);
void					ft_bzero(void *s, size_t n);
void					*ft_memcpy(void *dest, const void *src, size_t n);

// string/*.c
int						ft_strncmp(const char *s1, const char *s2, size_t n);
char					*ft_strchr(const char *s, int c);
int						ft_strcmp(const char *s1, const char *s2);
int						ft_atoi(const char *str);
char					*ft_strcat(char *dest, const char *src);
size_t					ft_strlen(const char *s);
char					*ft_strcpy(char *dest, const char *src);

// alloc/*.c
// char					*ft_strdup(const char *s1);
// void					*ft_calloc(size_t count, size_t size);

int ft_isalnum(int c);
int ft_isalpha(int c);
int ft_isascii(int c);
int ft_isdigit(int c);
int ft_isprint(int c);
int ft_isspace(char c);
int ft_tolower(int c);
int ft_toupper(int c);
#endif
