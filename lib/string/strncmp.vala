private inline int strncmp_generic (uint8* s1, uint8* s2, size_t n) {
    while (n > 0) {
        if (*s1 != *s2 || *s1 == 0) {
            return (int)(*s1 - *s2);
        }
        s1++;
        s2++;
        n--;
    }
    return 0;
}

public int strncmp (char* s1, char* s2, size_t n) {
    uint8* c1 = (uint8*)s1;
    uint8* c2 = (uint8*)s2;

    while (n > 0 && ((size_t)c1 & (sizeof(size_t) - 1)) != 0) {
        if (*c1 != *c2 || *c1 == 0) {
            return (int)(*c1 - *c2);
        }
        c1++;
        c2++;
        n--;
    }

    if (n >= sizeof(size_t) && ((size_t)c2 & (sizeof(size_t) - 1)) == 0) {
        size_t* w1 = (size_t*)c1;
        size_t* w2 = (size_t*)c2;

        while (n >= sizeof(size_t)) {
            if (*w1 != *w2 || ((*w1 - low_mask()) & ~*w1 & high_mask()) != 0) {
                break;
            }
            w1++;
            w2++;
            n -= sizeof(size_t);
        }
        c1 = (uint8*)w1;
        c2 = (uint8*)w2;
    }

    return strncmp_generic(c1, c2, n);
}

