all:

clean: clean-precise32 clean-precise64

precise32:
	NICKNAME=precise VERSION=12.04 ARCH=i386 ./build-iso
	NICKNAME=precise VERSION=12.04 ARCH=i386 ./build-vbox
	NICKNAME=precise VERSION=12.04 ARCH=i386 ./build-vagrant

clean-precise32:
	NICKNAME=precise VERSION=12.04 ARCH=i386 ./clean-iso
	NICKNAME=precise VERSION=12.04 ARCH=i386 ./clean-vbox || true
	NICKNAME=precise VERSION=12.04 ARCH=i386 ./clean-vagrant

precise64:
	NICKNAME=precise VERSION=12.04 ARCH=amd64 ./build-iso
	NICKNAME=precise VERSION=12.04 ARCH=amd64 ./build-vbox
	NICKNAME=precise VERSION=12.04 ARCH=amd64 ./build-vagrant

clean-precise64:
	NICKNAME=precise VERSION=12.04 ARCH=amd64 ./clean-iso
	NICKNAME=precise VERSION=12.04 ARCH=amd64 ./clean-vbox || true
	NICKNAME=precise VERSION=12.04 ARCH=amd64 ./clean-vagrant

.PHONY: all clean-precise32 clean-precise64
