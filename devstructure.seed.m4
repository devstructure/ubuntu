# Preseed Ubuntu for DevStructure.

# Network.
d-i netcfg/get_hostname string devbox
d-i netcfg/get_domain string devbox
d-i netcfg/wireless_wep string

# Clock.
d-i clock-setup/utc boolean true
d-i time/zone string UTC

# Partitions.
d-i partman-auto/disk string /dev/sda
d-i partman-auto/method string regular
d-i partman-lvm/device_remove_lvm boolean true
d-i partman-md/device_remove_md boolean true
d-i partman-auto/choose_recipe select atomic
d-i partman/default_filesystem string ext4
d-i partman/confirm_write_new_label boolean true
d-i partman/choose_partition select finish
d-i partman/confirm boolean true
d-i partman/confirm_nooverwrite boolean true

# Kernel.
d-i base-installer/kernel/override-image string __KERNEL__

# Users.
d-i passwd/user-fullname string DevStructure
d-i passwd/username string devstructure
d-i passwd/user-password-crypted password !
d-i user-setup/encrypt-home boolean false

# Packages and repositories.
d-i mirror/http/proxy string
d-i apt-setup/local0/repository string http://packages.devstructure.com maverick main
d-i apt-setup/local0/source boolean false
d-i apt-setup/local0/key string http://packages.devstructure.com/keyring.gpg
tasksel tasksel/first multiselect
d-i pkgsel/include string openssh-server
#d-i pkgsel/include string sandbox blueprint
d-i pkgsel/update-policy select none
d-i pkgsel/install-language-support boolean false

# Grub and reboot.
d-i grub-installer/only_debian boolean true
d-i finish-install/reboot_in_progress note
d-i cdrom-detect/eject boolean true
d-i debian-installer/splash boolean false

# Everything else.
d-i preseed/late_command string sh /cdrom/devstructure.sh
