namespace Cpu {
    [CCode (cname = "outb")]
    public void outb (uint16 port, uint8 data);

    [CCode (cname = "inb")]
    public uint8 inb (uint16 port);

    [CCode (cname = "asm")]
    public void cli (string code = "cli");

    [CCode (cname = "asm")]
    public void sti (string code = "sti");

    [CCode (cname = "asm")]
    public void hlt (string code = "hlt");
}
