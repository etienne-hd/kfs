// IDT #0
namespace Idt {

	namespace Handler {

		[CCode (cname = "divide_handler")]
		public void divide() {
			kernel_panic("division by 0");
		}
	}
}