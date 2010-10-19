VERSION=10.10
DISTRO=server
RELEASE=latest
ARCH=i386 amd64

all: $(ARCH:%=devstructure-ubuntu-$(VERSION)-$(DISTRO)-%.iso)

ubuntu-%.iso:
	curl -L -o $@ \
		-d distro=$(DISTRO) \
		-d release=$(RELEASE) \
		-d bits=$(if $(findstring i386,$@),32,64) \
		http://www.ubuntu.com/start-download

ubuntu-%: ubuntu-%.iso
	hdiutil attach -mountpoint mount $@.iso
	rsync -a mount/ $@
	hdiutil detach mount

devstructure-%.iso: %
	@echo DEBUG '@:' $@
	@echo DEBUG '<:' $<
	# TODO
	hdiutil makehybrid -o $@ -iso -joliet $<

clean:
	rm devstructure-ubuntu-$(VERSION)-$(DISTRO)-*.iso

.PHONY: all clean
