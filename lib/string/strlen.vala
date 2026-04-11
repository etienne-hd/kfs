public size_t strlen (char* s) {
    char* p = s;
    size_t w;

    while (((size_t)p & (sizeof(size_t) - 1)) != 0)
    {
        if (*p == 0)
            return (size_t)(p - s);
        p += 1;
    }

    while (true)
    {
        w = *(size_t*)p;
        if (((w - low_mask()) & ~w & high_mask()) != 0)
            break;
        p += sizeof(size_t);
    }

    while (*p != 0)
        p += 1;

    return (size_t)(p - s);
}
