#

# Arguments given to the download router.
: ${VERSION:="10.10"}
: ${DISTRO:="server"}
: ${RELEASE:="latest"}

# Generated ISO Prefix
: ${ISOPREFIX:="vagrant"}
: ${LABEL:="vagrant"}


# Architectures being built.
: ${ARCHS:="i386 amd64"}

# Hardcoded host information.
# : ${HOST:="devstructure"}
: ${HOST:="maverick"}
: ${DOMAIN:="vagrantup.com"}
: ${ROOT_PASSWORD:="vagrant"}
: ${USER_NAME:="vagrant"}
: ${PASSWORD:="vagrant"}

# SSH key to be authorized in virtual machines.
: ${PRIVATE_KEY:="vagrant"}
: ${PUBLIC_KEY:="vagrant.pub"}

# SSH command that will connect to the virtual machine.  Add commands
# onto the end to do other tricks.
: ${SSH:="ssh \
	-o UserKnownHostsFile=/dev/null \
	-o StrictHostKeyChecking=no \
	-l \"$USER_NAME\" -i \"$PRIVATE_KEY\" -p 2222 localhost \
"}

# Fully-qualified pathname of VBoxGuestAdditions.iso.
#: ${VBOX_GUEST_ADDITIONS:="/Applications/VirtualBox.app/Contents/MacOS/VBoxGuestAdditions.iso"}
: ${VBOX_GUEST_ADDITIONS:="/usr/share/virtualbox/VBoxGuestAdditions.iso"}

# apt-cacher-ng support. If you have a proxy running locally set the ip address here for apt to proxy requests. (10.0.2.2 is the default gateway ip which should be your host)
#: ${PROXY_URL:="http://10.0.2.2:3142"}
# Add nfs_common packages to vbox for nfs compat with vagrant. Empty string to remove nfs compat. This should make the base image (a bit) smaller, if you don't need nfs support
: ${NFS_COMPAT:="nfs-common"}

# Enable Host IO cache on ext4 filesystems. Unless explicitly specified here, build-vbox will check both current build dir and home dir (home of vagrant box cache) to see if they are ext4 filesystems
# Enable hostiocache var
#: ${HOSTIOCACHE:=" --hostiocache on"}
# Disable hostiocache var
#: ${HOSTIOCACHE:=""}