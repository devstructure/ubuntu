default __LABEL__
timeout 1
label __LABEL__
  menu label ^Install Ubuntu Server for __LABEL__
  kernel ubuntu-installer/__ARCH__/linux
  append auto=true priority=critical url=__PRESEED_URI__ hostname=__HOST__  initrd=ubuntu-installer/__ARCH__/initrd.gz quiet --
