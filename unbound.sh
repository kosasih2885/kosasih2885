#!/bin/sh
apt-get -y install unbound
cd /etc/unbound
wget https://kosasih2885.googlecode.com/svn/unbound -O /etc/init.d/unbound
sed -i 's/\r//' /etc/init.d/unbound
unbound-control-setup
groupadd unbound
useradd -d /var/unbound -m -g unbound -s /bin/false unbound
chown unbound:root unbound_*
chmod 440 unbound_*
wget https://kosasih2885.googlecode.com/svn/unbound -O /etc/init.d/unbound
sed -i 's/\r//' /etc/init.d/unbound
wget https://kosasih2885.googlecode.com/svn/unbound.conf -O /etc/unbound/unbound.conf
sed -i 's/\r//' /etc/unbound/unbound.conf
/etc/init.d/unbound restart











