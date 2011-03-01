set -e

mkdir -p /opt/__LABEL__-setup/
cd  /opt/__LABEL__-setup/
curl -L --noproxy * -o "/opt/__LABEL__-setup/setup.tgz" "__PRESEED_HOST__/setup.tgz"
tar xzvf  /opt/__LABEL__-setup/setup.tgz

mkdir /home/__USER_NAME__/.ssh
cat /opt/__LABEL__-setup/__PUBLIC_KEY__ >/home/__USER_NAME__/.ssh/authorized_keys
chmod 700 /home/__USER_NAME__/.ssh
chown 1000:1000 \
	/home/__USER_NAME__/.ssh \
	/home/__USER_NAME__/.ssh/authorized_keys

# cp /cdrom/setup.sh /etc/profile.d/
# chmod 644 /etc/profile.d/setup.sh
# chown 0:0 /etc/profile.d/setup.sh

cp /opt/__LABEL__-setup/sudoers /etc/
chmod 440 /etc/sudoers
chown 0:0 /etc/sudoers

unset DEBCONF_REDIR DEBCONF_FRONTEND DEBIAN_HAS_FRONTEND DEBIAN_FRONTEND
apt-get update

rm -rf /opt/__LABEL__-setup/
