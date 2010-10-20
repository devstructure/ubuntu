#

# Arguments given to the download router.
: ${VERSION:="10.10"}
: ${DISTRO:="server"}
: ${RELEASE:="latest"}

# Architectures being built.
: ${ARCHS:="i386 amd64"}

# Hardcoded host information.
: ${HOST:="devstructure"}
: ${DOMAIN:="vagrantup.com"}
: ${ROOT_PASSWORD:="vagrant"}
: ${USERNAME:="vagrant"}
: ${PASSWORD:="vagrant"}

# SSH key to be authorized in virtual machines.
: ${PRIVATE_KEY:="vagrant"}
: ${PUBLIC_KEY:="vagrant.pub"}

# Fully-qualified pathname of VBoxGuestAdditions.iso.
: ${VBOX_GUEST_ADDITIONS:="/Applications/VirtualBox.app/Contents/MacOS/VBoxGuestAdditions.iso"}
