private inline char* strrchr_generic (char* s, int c, size_t n) {
    uint8 ch = (uint8)c;

    while (n > 0) {
        if (s[n - 1] == ch) {
            return (char*)(s + n - 1);
        }
        n--;
    }
    return null;
}

public char* strrchr (char* s, int c) {
    size_t c_mask = repeat_byte((uint8)c);
    size_t n;
    size_t xor_word;

    n = strlen(s);
    if ((uint8)c == '\0') {
        return (char*)(s + n);
    }

    char* p = s + n;

    while (n > 0 && ((size_t)p & 7) != 0) {
        p--; 
        if (*p == (uint8)c) {
            return (char*)p;
        }
        n--;
    }

    while (n >= 8) {
        xor_word = (*((size_t*)(p - 8))) ^ c_mask;
        
        if (((xor_word - low_mask()) & ~xor_word & high_mask()) != 0) {
            break;
        }
        p -= 8;
        n -= 8;
    }

    return strrchr_generic(p - n, c, n);
}
