set -e

mkdir /target/home/__USERNAME__/.ssh
cat /cdrom/__PUBLIC_KEY__ >/target/home/__USERNAME__/.ssh/authorized_keys
chmod 700 /target/home/__USERNAME__/.ssh
chown 1000:1000 \
	/target/home/__USERNAME__/.ssh \
	/target/home/__USERNAME__/.ssh/authorized_keys

# cp /cdrom/setup.sh /target/etc/profile.d/
# chmod 644 /target/etc/profile.d/setup.sh
# chown 0:0 /target/etc/profile.d/setup.sh

cp /cdrom/sudoers /target/etc/
chmod 440 /target/etc/sudoers
chown 0:0 /target/etc/sudoers

chroot /target sh -c '
	set -e
	unset DEBCONF_REDIR DEBCONF_FRONTEND DEBIAN_HAS_FRONTEND DEBIAN_FRONTEND
	apt-get update
  # apt-get -y install sandbox blueprint
'
