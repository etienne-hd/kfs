[CCode (cprefix = "", lower_case_cprefix = "")]
namespace Cpu {
    [CCode (cname = "outb")]
    public void outb (uint16 port, uint8 data);

    [CCode (cname = "inb")]
    public uint8 inb (uint16 port);

    [CCode (cname = "cli")]
    public void cli ();

    [CCode (cname = "sti")]
    public void sti ();

    [CCode (cname = "hlt")]
    public void hlt ();
}
