set -e

mkdir /target/home/__USERNAME__/.ssh
cat /cdrom/__PUBLIC_KEY__ >/target/home/__USERNAME__/.ssh/authorized_keys
chmod 700 /target/home/__USERNAME__/.ssh
chown 1000:1000 \
	/target/home/__USERNAME__/.ssh \
	/target/home/__USERNAME__/.ssh/authorized_keys
