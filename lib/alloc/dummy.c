#include "stdlib.h"

extern void kernel_panic(char *message);

void* malloc(size_t nmemb) {
    (void)nmemb;
	kernel_panic("malloc() is not implemented in this environment");
	// for(;;)
		// ; 
    return NULL; 
}

void* calloc(size_t nmemb, size_t size) {
    (void)nmemb;
	(void)size;
	kernel_panic("calloc() is not implemented in this environment");
    return NULL; 
}

void free(void* ptr) {
	(void)ptr;
	kernel_panic("free() is not implemented in this environment");
}
