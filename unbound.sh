#!/bin/sh
apt-get -y install unbound
cd /etc/unbound
wget ftp://ftp.internic.net/domain/named.cache
unbound-control-setup
groupadd unbound
useradd -d /var/unbound -m -g unbound -s /bin/false unbound
chown unbound:root unbound_*
chmod 440 unbound_*
/etc/init.d/unbound restart











