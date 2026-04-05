#include "stdlib.h"

void* malloc(size_t nmemb) {
    (void)nmemb;
	for(;;)
		; 
    return NULL; 
}

void* calloc(size_t nmemb, size_t size) {
    (void)nmemb;
	(void)size;
    for(;;)
		; 
    return NULL; 
}

void free(void* ptr) {
	(void)ptr;
}
