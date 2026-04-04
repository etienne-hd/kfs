#ifndef __STDLIB_H__
# define __STDLIB_H__

# include <stddef.h>

void free(void *ptr);
void *malloc(size_t size);
void *calloc(size_t nmemb, size_t size);

#endif
