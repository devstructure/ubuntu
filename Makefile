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
	chmod -R +w $@

devstructure-%.iso: %
	cp isolinux.cfg $</isolinux/
	m4 -D__KERNEL__=linux-$(if $(findstring i386,$@),generic-pae,server) \
		devstructure.seed.m4 >$</preseed/devstructure.seed
	cp devstructure.sh $</
	mkisofs -r -V "Ubuntu $(VERSION) for DevStructure" \
		-cache-inodes -J -l -no-emul-boot \
		-b isolinux/isolinux.bin \
		-c isolinux/boot.cat \
		-boot-load-size 4 -boot-info-table \
		-o $@ $<

clean:
	rm -f devstructure-ubuntu-$(VERSION)-$(DISTRO)-*.iso

.PHONY: all clean
