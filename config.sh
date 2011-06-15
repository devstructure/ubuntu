#

# Build platform details, for portability
case $(uname) in
    'Linux')
        PLATFORM='linux' ;;
    'Darwin')
        PLATFORM='osx' ;;
    *)
        echo "Unsupported platform: $(uname)"
        exit 1 ;;
esac

# The nickname of this ISO, VirtualBox image, and Vagrant box.
: ${NICKNAME:="vagrant"}

# Arguments given to the download router.
: ${VERSION:="10.10"}
: ${DISTRO:="server"}
: ${RELEASE:="latest"}

# Architecture being built.
: ${ARCH:="i386"}

# Hardcoded host information.
: ${HOST:="vagrant"}
: ${DOMAIN:="vagrantup.com"}
: ${ROOT_PASSWORD:="vagrant"}
: ${USERNAME:="vagrant"}
: ${PASSWORD:="vagrant"}

# SSH key to be authorized in virtual machines.
: ${PRIVATE_KEY:="vagrant"}
: ${PUBLIC_KEY:="vagrant.pub"}

# SSH command that will connect to the virtual machine.  Add commands
# onto the end to do other tricks.
: ${SSH_PORT:="22222"}
: ${SSH:="ssh \
	-o UserKnownHostsFile=/dev/null \
	-o StrictHostKeyChecking=no \
	-l \"$USERNAME\" -i \"$PRIVATE_KEY\" -p \"$SSH_PORT\" localhost \
"}

# OpenSSH on Linux will refuse to use a world-readable private key.
case "$PLATFORM" in
    'linux')
        chmod 600 "$PRIVATE_KEY" ;;
esac

# Fully-qualified pathname of VBoxGuestAdditions.iso.
: ${VBOX_GUEST_ADDITIONS:="/Applications/VirtualBox.app/Contents/MacOS/VBoxGuestAdditions.iso"}
