// IDT #44
namespace Idt {

	namespace Handler {


		[CCode (cname = "mouse_handler")]
		public void mouse () {
			uint8 packet = Cpu.inb(0x60);
			
			if (!(packet == 0xFA || packet == 0xAA)) {
				Serial.print ("mouse packet %d\n", packet);
			}

			Cpu.outb(0xA0, 0x20); // EOI slave
			Cpu.outb(0x20, 0x20); // EOI master
		}
	}
}