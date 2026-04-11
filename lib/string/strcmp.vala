private inline int strcmp_generic (uint8* s1, uint8* s2) {
    while (*s1 != 0 && (*s1 == *s2))
    {
        s1++;
        s2++;
    }
    return (int)(*s1 - *s2);
}

public int strcmp (string s1, string s2) {
    size_t* w1;
    size_t* w2;
    uint8* c1;
    uint8* c2;

    c1 = (uint8*)s1;
    c2 = (uint8*)s2;

    while (((size_t)c1 & 7) != 0)
    {
        if (*c1 != *c2 || *c1 == 0)
            return (int)(*c1 - *c2);
        c1++;
        c2++;
    }

    if (((size_t)c2 & 7) != 0)
        return strcmp_generic(c1, c2);

    w1 = (size_t*)c1;
    w2 = (size_t*)c2;

    while (*w1 == *w2 && ((*w1 - low_mask()) & ~*w1 & high_mask()) == 0)
    {
        w1++;
        w2++;
    }
    return strcmp_generic((uint8*)w1, (uint8*)w2);
}
