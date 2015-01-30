#!/bin/sh
apt-get install unbound -y
cd /etc/unbound
wget ftp://ftp.internic.net/domain/named.cache -O /etc/unbound/named.cache
unbound-control-setup 
groupadd unbound 
useradd -d /var/unbound -m -g unbound -s /bin/false unbound
cd /etc/unbound
chown unbound:root unbound_* && chmod 440 unbound_*
wget https://kosasih2885.googlecode.com/svn/unbound.conf -O /etc/unbound/unbound.conf
/etc/init.d/unbound restart
nslookup www.youtube.com
dig www.youtube.com
dig www.youtube.com
echo -e "Instalasi Unbound telah selesai. Lihat baris query time nya antara 1 dan 2 kalo yg ke 2 lebih kecil berarti sukses"





