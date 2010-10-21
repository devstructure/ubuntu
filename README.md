Ubuntu for DevStructure
=======================

Build a custom Ubuntu ISO for DevStructure by downloading, extracting,
tweaking, and packaging the stock Ubuntu ISO.

Build dependencies
------------------

* `curl`(1).
* `hdiutil`(1), and therefore Mac OS X.  It may be possible to relax
  this dependency but it has not been investigated.
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
* The hostname is `devstructure`; the domain is `vagrantup.com`.  These
  are configurable.
* The system clock is set to UTC.
* The entire disk is partitioned `ext4` without LVM.
* The default kernel for the architecture is used.  `linux-server` for
  `amd64` and `linux-generic-pae` for `i386`.
* The `root` and `vagrant` users exist; both their password are `vagrant`.
  Vagrant's standard insecure SSH key is authorized for `vagrant`.  These
  are all configurable.
* DevStructure's Debian archive is added to the source list.
* OpenSSH server is installed.
* VirtualBox Guest Additions are installed.

Features in the Vagrant boxes
-----------------------------

* Ruby 1.8.7
* RubyGems 1.3.7
* Chef 0.9.10

Building
--------

Building ISO images:

	./build-iso

Building virtual machines through VirtualBox:

	./build-vbox

Building Vagrant boxes:

	./build-vagrant

There are matching `clean-{iso,vbox,vagrant}` programs that remove the
products of their build counterparts.
