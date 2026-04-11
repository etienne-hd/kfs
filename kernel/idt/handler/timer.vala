// IDT #32
namespace Idt {

	namespace Handler {

		[CCode (cname = "timer_handler")]
		public void timer () {
			Timer.tick++;
			Cpu.outb(0x20, 0x20);
		}
	}
}