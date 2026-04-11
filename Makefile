BINARY=build/kfs.bin

all: ${BINARY}

${BINARY}: build
	ninja -C build

re:
	rm -rf build
	$(MAKE) all

build:
	meson build --cross-file=i386-elf-cross.txt --buildtype=release --prefix=${PWD}/here

kfs.iso: all
	mkdir -p isodir/boot/grub
	cp ${BINARY} isodir/boot/kfs.bin
	cp grub.cfg isodir/boot/grub/grub.cfg
	grub-mkrescue -o kfs.iso isodir --compress=gz

run: ${BINARY} 
	qemu-system-i386 -serial stdio --kernel ${BINARY}
