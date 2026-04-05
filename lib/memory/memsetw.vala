public void *memsetw(void *s, uint16 c, size_t count) {
    uint32 pattern = ((uint32)c << 16) | c;
    uint32 *ptr32 = (uint32*)s;

    while (count >= 8) {
        ptr32[0] = pattern;
        ptr32[1] = pattern;
        ptr32[2] = pattern;
        ptr32[3] = pattern;
        ptr32 += 4;
        count -= 8;
    }

    uint16 *ptr16 = (uint16*)ptr32;
    while (count > 0) {
        *ptr16++ = c;
        count--;
    }

    return s;
}
