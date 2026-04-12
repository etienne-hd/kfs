// IDT #44
namespace Idt {

	namespace Handler {
		[CCode (cname = "mouse_handler")]
		public void mouse () {
			uint8 byte = Cpu.inb(0x60);
			
			if (!(byte == 0xFA || byte == 0xAA)) {
				// the bit 0000 1000 is always 1 on first bytes
				if (Mouse.queue.length() % 3 == 0 && (byte & (1 << 3)) == 0) {
					Mouse.queue.reset (); // Resync
				}
				else {
					Mouse.queue.push (byte);
					if (Mouse.queue.length () >= 3)
						Mouse.new_event = true;
					else
						Mouse.new_event = false;
				}
			}

			Cpu.outb(0xA0, 0x20); // EOI slave
			Cpu.outb(0x20, 0x20); // EOI master
		}
	}
}