namespace Mouse {
	public Queue queue;
	public Event previous_event;
	private Event _current_event;

	public struct Event {
		int8 x;
		int8 y;
		bool left_click;
		bool right_click;
		bool middle_click;

		bool initialized;
	}

	public Event get_event () {
		Event event = {0};

		if (queue.length() % 3 != 0 || queue.length () == 0) {
			if (queue.length () != 0)
				queue.reset();
			return event;
		}

		event.initialized = true;

		uint8 byte_flag = queue.pop();
		uint8 byte_x = queue.pop();
		uint8 byte_y = queue.pop();

		event.left_click = (byte_flag & (1 << 0)) > 0; // 0000_0001
		event.right_click = (byte_flag & (1 << 1)) > 0; // 0000_0010
		event.middle_click = (byte_flag & (1 << 2)) > 0; // 0000_0100

		event.x = (int8)byte_x;
		event.y = (int8)byte_y;

		previous_event = _current_event;
		_current_event = event;
		return event;
	}
}