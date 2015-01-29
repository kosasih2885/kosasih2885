#!/bin/sh
wget ftp://ftp.internic.net/domain/named.cache -O /etc/unbound/named.cache
sed -i 's/\r//' /etc/init.d/unbound
unbound-control-setup
groupadd unbound
useradd -d /var/unbound -m -g unbound -s /bin/false unbound
/etc/unbound
chown unbound:root unbound_*
chmod 440 unbound_*
wget https://kosasih2885.googlecode.com/svn/unbound -O /etc/init.d/unbound
sed -i 's/\r//' /etc/init.d/unbound
wget https://kosasih2885.googlecode.com/svn/unbound.conf -O /etc/unbound/unbound.conf
sed -i 's/\r//' /etc/unbound/unbound.conf
service unbound stop
cd /tmp
wget http://kosasih2885.googlecode.com/svn/dnscrypt-autoinstall.sh
chmod +x dnscrypt-autoinstall.sh
./dnscrypt-autoinstall.sh





