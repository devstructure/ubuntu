all:

lynx32:
	NICKNAME=lynx VERSION=10.04 ARCH=i386 ./build-iso
	NICKNAME=lynx VERSION=10.04 ARCH=i386 ./build-vbox
	NICKNAME=lynx VERSION=10.04 ARCH=i386 ./build-vagrant

lynx64:
	NICKNAME=lynx VERSION=10.04 ARCH=amd64 ./build-iso
	NICKNAME=lynx VERSION=10.04 ARCH=amd64 ./build-vbox
	NICKNAME=lynx VERSION=10.04 ARCH=amd64 ./build-vagrant

meerkat32:
	NICKNAME=meerkat VERSION=10.10 ARCH=i386 ./build-iso
	NICKNAME=meerkat VERSION=10.10 ARCH=i386 ./build-vbox
	NICKNAME=meerkat VERSION=10.10 ARCH=i386 ./build-vagrant

meerkat64:
	NICKNAME=meerkat VERSION=10.10 ARCH=amd64 ./build-iso
	NICKNAME=meerkat VERSION=10.10 ARCH=amd64 ./build-vbox
	NICKNAME=meerkat VERSION=10.10 ARCH=amd64 ./build-vagrant

.PHONY: all lynx32 lynx64 meerkat32 meerkat64
