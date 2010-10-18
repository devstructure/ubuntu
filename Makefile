VERSION=10.10

ISO=\
	ubuntu-$(VERSION)-server-i386.iso \
	ubuntu-$(VERSION)-server-amd64.iso \

all: $(ISO)

$(ISO):
	curl -L -o $@ \
		-d distro=server \
		-d release=latest \
		-d bits=$(if $(findstring i386,$@),32,64) \
		http://www.ubuntu.com/start-download

.PHONY: all download
