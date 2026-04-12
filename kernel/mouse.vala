namespace Mouse {
	public Queue queue;
	public Event last_event;

	public struct Event {
		int8 x;
		int8 y;
		bool left_click;
		bool right_click;
		bool middle_click;
	}
	
	public bool new_event () {
		if (queue.length() % 3 == 0)
			return queue.length() > 0;
		else {
			queue.reset(); // Resync
			return false;
		}
	}

	public Event get_event () {
		uint8 byte_flag = queue.pop();
		uint8 byte_x = queue.pop();
		uint8 byte_y = queue.pop();

		Event event = {0};

		event.left_click = (byte_flag & (1 << 0)) > 0; // 0000_0001
		event.right_click = (byte_flag & (1 << 1)) > 0; // 0000_0010
		event.middle_click = (byte_flag & (1 << 2)) > 0; // 0000_0100

		event.x = (int8)byte_x;
		event.y = (int8)byte_y;

		last_event = event;
		return event;
	}
}