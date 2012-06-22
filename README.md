Ubuntu for Vagrant
==================

Build a custom Ubuntu base box for Vagrant by downloading, extracting,
tweaking, and packaging the stock Ubuntu ISO.

Build dependencies
------------------

* `curl`(1).
* `m4`(1).
* `mkisofs`(1) from the `cdrtools` package available from MacPorts or
  Homebrew.

Runtime dependencies
--------------------

The results are bootable ISO images and so should run on any `i386` or
`amd64` hardware.  They are only tested in VirtualBox.

Features in the ISO
-------------------

* Network access is configured using sane default settings.  WiFi is
  not supported.
* The hostname is `vagrant`; the domain is `vagrantup.com`.  These
  are configurable.
* The system clock is set to UTC.
* The entire disk is partitioned `ext4` without LVM.
* The default kernel for the architecture is used.  `linux-server` for
  `amd64` and `linux-generic-pae` for `i386`.
* The `root` and `vagrant` users exist; both their password are `vagrant`.
  Vagrant's standard insecure SSH key is authorized for `vagrant`.  These
  are all configurable.
* OpenSSH server is installed.
* VirtualBox Guest Additions are installed.
* Chef is installed.

Building
--------

Edit configuration in

	config.sh

Building ISO images:

	./build-iso

Building virtual machines through VirtualBox:

	./build-vbox

Building Vagrant boxes:

	./build-vagrant

There are matching `clean-{iso,vbox,vagrant}` scripts that remove the
products of their build counterparts.

The `Makefile` contains targets for common build tasks. For Ubuntu 12.04
(Precise Pangolin) 32-bit use

	make precise32

For Ubuntu 12.04 (Precise Pangolin) 64-bit use

	make precise64
