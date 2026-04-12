all: install

compile: build
	ninja -C build

re:
	rm -rf build
	$(MAKE) all

build:
	meson build --cross-file=i386-elf-cross.txt --buildtype=release --prefix=${PWD}/release

install: compile 
	meson install -C build
	
run: install
	qemu-system-i386 -serial stdio --kernel release/kfs.bin
