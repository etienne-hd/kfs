public void keyboard_handler () {
	uint8 scancode = Cpu.inb(0x60);
	Keyboard.key_state[scancode & 0x7F] = scancode < 0x80;
	Keyboard.queue.push(scancode);
	Cpu.outb(0x20, 0x20); // EOI
}