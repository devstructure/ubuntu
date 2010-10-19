Ubuntu for DevStructure
=======================

Build a custom Ubuntu ISO for DevStructure by downloading, extracting,
tweaking, and packaging the stock Ubuntu ISO.

Build Dependencies
------------------

* `hdiutil`(1), and therefore Mac OS X.  It may be possible to relax
  this dependency but it has not been investigated.
* `curl`(1).
* `mkisofs`(1) from the `cdrtools` package available from MacPorts or
  Homebrew.

Runtime Dependencies
--------------------

The results are bootable ISO images and so should run on any i386 or
amd64 hardware.  They are only tested in VirtualBox.

Customizations
--------------

* Network access is configured using default settings.  WiFi is not
  supported.
* The system clock is set to UTC.
* The entire disk is partitioned `ext4` without LVM.
* The default kernel for the architecture is used.
* A user named `devstructure` is created with no password.  Authorized
  SSH keys are required to login.
* DevStructure's Debian archive is added to the source list.
* OpenSSH server is installed.

Further Customization
---------------------

TODO
