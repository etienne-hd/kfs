[CCode (cprefix = "", lower_case_cprefix = "")]
namespace Cpu {
    [CCode (cname = "outb")]
    public static void outb (uint16 port, uint8 data);

    [CCode (cname = "inb")]
    public static uint8 inb (uint16 port);

    [CCode (cname = "cli")]
    public static void cli ();

    [CCode (cname = "sti")]
    public static void sti ();

    [CCode (cname = "hlt")]
    public static void hlt ();
}
