namespace Timer {
	public uint32 tick = 0;

	public uint32 get_seconds() {
		return (uint32)(tick / 18.206512834);
	}

	public uint32 get_milliseconds() {
		return (uint32)(tick * 54.9254);
	}
}