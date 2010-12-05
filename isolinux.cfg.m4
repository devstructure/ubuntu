default __LABEL__
timeout 1
label __LABEL__
  menu label ^Install Ubuntu Server for __LABEL__
  kernel /install/vmlinuz
  append  file=/cdrom/preseed/__LABEL__.seed debian-installer/locale=en_US console-setup/layoutcode=us localechooser/translation/warn-light=true localechooser/translation/warn-severe=true initrd=/install/initrd.gz quiet --
