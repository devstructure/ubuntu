VERSION=10.10
DISTRO=server
RELEASE=latest

ARCH=i386 amd64

all: vbox

iso: $(ARCH:%=devstructure-ubuntu-$(VERSION)-$(DISTRO)-%.iso)

vbox: $(ARCH:%=devstructure-ubuntu-$(VERSION)-$(DISTRO)-%)

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

devstructure-%: devstructure-%.iso
	VBoxManage createvm \
		--name $@ \
		--basefolder $(PWD) \
		--register \
		|| true
	VBoxManage modifyvm $@ \
		--ostype $(if $(findstring i386,$@),Ubuntu,Ubuntu_64) \
		--memory 360 \
		--vram 1 \
		--acpi on --ioapic on \
		--cpus 1 \
		--pae $(if $(findstring i386,$@),on,off) \
		--hwvirtex on \
		--hwvirtexexcl off \
		--nestedpaging on \
		--accelerate3d off \
		--nic1 nat \
		--natpf1 guestssh,tcp,,2222,,22 \
		--audio none \
		--clipboard disabled \
		--usb off --usbehci off \
		--vrdp off \
		--teleporter off
	VBoxManage storagectl $@ \
		--name IDE \
		--add ide
	VBoxManage storagectl $@ \
		--name SATA \
		--add sata
	VBoxManage storageattach $@ \
		--storagectl IDE \
		--port 1 --device 0 \
		--type dvddrive --medium $(PWD)/$<
	VBoxManage createhd \
		--filename $@/$@.vmdk \
		--size 40000 \
		--format VMDK \
		|| true
	VBoxManage storageattach $@ \
		--storagectl IDE \
		--port 0 --device 0 \
		--type hdd --medium $@/$@.vmdk
	VBoxManage startvm $@ \
		--type gui

clean: clean-iso clean-vbox

clean-download:
	for ARCH in $(ARCH); \
	do \
		rm -f ubuntu-$(VERSION)-$(DISTRO)-$$ARCH.iso; \
	done

clean-orig:
	for ARCH in $(ARCH); \
	do \
		rm -rf ubuntu-$(VERSION)-$(DISTRO)-$$ARCH; \
	done

clean-iso:
	for ARCH in $(ARCH); \
	do \
		rm -f devstructure-ubuntu-$(VERSION)-$(DISTRO)-$$ARCH.iso; \
	done

clean-vbox:
	for ARCH in $(ARCH); \
	do \
		VBoxManage unregistervm \
			devstructure-ubuntu-$(VERSION)-$(DISTRO)-$$ARCH \
			|| true; \
		rm -rf devstructure-ubuntu-$(VERSION)-$(DISTRO)-$$ARCH; \
	done

.PHONY: all iso vbox clean clean-download clean-orig clean-iso clean-vbox
