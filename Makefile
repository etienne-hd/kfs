BINARY=build/myos.bin

all: ${BINARY}

${BINARY}: build
	ninja -C build

re:
	rm -rf build
	$(MAKE) all

build:
	meson build --cross-file=i386-elf-cross.txt --prefix=${PWD}/here

run: ${BINARY} 
	qemu-system-i386 -serial stdio --kernel ${BINARY}
