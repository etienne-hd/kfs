public struct Queue {
	uint8 buffer[256];
	uint8 head;
	uint8 tail;

	public uint8 pop() {
		if (this.tail != this.head) {
			this.tail++;
			return this.buffer[this.tail - 1];
		}
		return 0;
	}

	public void push(uint8 value) {
		buffer[head] = value;
		head++;
		if (this.head == this.tail)
			kernel_panic("Queue loop detected");
	}

	public void reset() {
		this.head = this.tail;
	}
}