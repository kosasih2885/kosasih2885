#!/bin/sh
apt-get install -y unbound
cd /etc/unbound
wget ftp://ftp.internic.net/domain/named.cache -O /etc/unbound/named.cache
sed -i 's/\r//' /etc/unbound/named.cache
wget ftp://ftp.internic.net/domain/named.cache -O /etc/unbound/named.cache
sed -i 's/\r//' /etc/unbound/named.cache
wget ftp://ftp.internic.net/domain/named.cache -O /etc/unbound/named.cache
sed -i 's/\r//' /etc/unbound/named.cache
unbound-control-setup
groupadd unbound
useradd -d /var/unbound -m -g unbound -s /bin/false unbound
cd /etc/unbound
chown unbound:root unbound_*
chmod 440 unbound_*
wget https://kosasih2885.googlecode.com/svn/unbound.conf -O /etc/unbound/unbound.conf
sed -i 's/\r//' /etc/unbound/unbound.conf
/etc/init.d/unbound restart
nslookup www.google.com
dig www.google.com
dig www.google.com




