all:

clean: clean-lynx32 clean-lynx64 clean-meerkat32 clean-meerkat64

lynx32:
	NICKNAME=lynx VERSION=10.04 ARCH=i386 ./build-iso
	NICKNAME=lynx VERSION=10.04 ARCH=i386 ./build-vbox
	NICKNAME=lynx VERSION=10.04 ARCH=i386 ./build-vagrant

clean-lynx32:
	NICKNAME=lynx VERSION=10.04 ARCH=i386 ./clean-iso
	NICKNAME=lynx VERSION=10.04 ARCH=i386 ./clean-vbox || true
	NICKNAME=lynx VERSION=10.04 ARCH=i386 ./clean-vagrant

lynx64:
	NICKNAME=lynx VERSION=10.04 ARCH=amd64 ./build-iso
	NICKNAME=lynx VERSION=10.04 ARCH=amd64 ./build-vbox
	NICKNAME=lynx VERSION=10.04 ARCH=amd64 ./build-vagrant

clean-lynx64:
	NICKNAME=lynx VERSION=10.04 ARCH=amd64 ./clean-iso
	NICKNAME=lynx VERSION=10.04 ARCH=amd64 ./clean-vbox || true
	NICKNAME=lynx VERSION=10.04 ARCH=amd64 ./clean-vagrant

meerkat32:
	NICKNAME=meerkat VERSION=10.10 ARCH=i386 ./build-iso
	NICKNAME=meerkat VERSION=10.10 ARCH=i386 ./build-vbox
	NICKNAME=meerkat VERSION=10.10 ARCH=i386 ./build-vagrant

clean-meerkat32:
	NICKNAME=meerkat VERSION=10.10 ARCH=i386 ./clean-iso
	NICKNAME=meerkat VERSION=10.10 ARCH=i386 ./clean-vbox || true
	NICKNAME=meerkat VERSION=10.10 ARCH=i386 ./clean-vagrant

meerkat64:
	NICKNAME=meerkat VERSION=10.10 ARCH=amd64 ./build-iso
	NICKNAME=meerkat VERSION=10.10 ARCH=amd64 ./build-vbox
	NICKNAME=meerkat VERSION=10.10 ARCH=amd64 ./build-vagrant

clean-meerkat64:
	NICKNAME=meerkat VERSION=10.10 ARCH=amd64 ./clean-iso
	NICKNAME=meerkat VERSION=10.10 ARCH=amd64 ./clean-vbox || true
	NICKNAME=meerkat VERSION=10.10 ARCH=amd64 ./clean-vagrant

.PHONY: all lynx32 clean-lynx32 lynx64 clean-lynx64 meerkat32 clean-meerkat32 meerkat64 clean-meerkat64
