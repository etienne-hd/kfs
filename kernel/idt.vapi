[CCode (cheader_filename = "idt.h")]
namespace Idt {

	[CCode (cname = "idt_entry")]
	struct Entry
	{
		uint16 offset_lowerbits;
		uint16 selector;
		uchar zero;
		uchar flags;
		uint16 offset_higherbits;
	}

	[CCode (cname = "idt_pointer")]
	struct Pointer
	{
		uint16 limit;
		uint32 base;
	}
	
	[CCode (cname = "load_idt")]
	public void load(uint32 ptr);
}
