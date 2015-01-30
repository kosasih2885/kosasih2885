#!/bin/sh
killall unbound
apt-get install unbound -y
cd /etc/unbound
/etc/init.d/unbound stop
wget https://kosasih2885.googlecode.com/svn/named.cache -O /etc/unbound/named.cache
wget https://kosasih2885.googlecode.com/svn/unbound.conf -O /etc/unbound/unbound.conf
killall unbound
unbound-control-setup 
groupadd unbound 
useradd -d /var/unbound -m -g unbound -s /bin/false unbound
cd /etc/unbound
chown unbound:root unbound_* && chmod 440 unbound_*
/etc/init.d/unbound restart
nslookup www.youtube.com
dig www.youtube.com
dig www.youtube.com






