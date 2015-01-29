#!/bin/sh
apt-get install -y libldns-dev libexpat1-dev libssl-dev
cd /tmp
wget https://kosasih2885.googlecode.com/svn/ldns-1.6.16.tar.gz
wget https://kosasih2885.googlecode.com/svn/libevent-2.0.21-stable.tar.gz
wget https://kosasih2885.googlecode.com/svn/unbound-latest.tar.gz
tar -xzf ldns-1.6.16.tar.gz
tar -xzf libevent-2.0.21-stable.tar.gz
tar -xzf unbound-latest.tar.gz
cd ldns-1.6.16
./configure --disable-gost
make && make install
cd /tmp/libevent-2.0.21-stable
./configure
make
cd /tmp/unbound-latest
cd cd /tmp/libevent-2.0.21-stable
./configure \
--with-ldns=/usr/local \
--with-libevent=/root/libevent-2.0.21-stable \
--with-conf-file=/etc/unbound/unbound.conf \
--with-pidfile=/etc/unbound/unbound.pid \
--with-run-dir=/etc/unbound \
--with-rootkey-file=/etc/unbound/root.key \
--with-rootcert-file=/etc/unbound/icannbundle.pem \
--disable-gost
make && make install
cd /etc/unbound
wget ftp://FTP.INTERNIC.NET/domain/named.cache
wget https://kosasih2885.googlecode.com/svn/unbound.conf
wget https://kosasih2885.googlecode.com/svn/unbound.pid

unbound-control-setup
groupadd unbound
useradd -g unbound unbound
chown unbound:unbound unbound_*
chmod 777 unbound_*
cd /etc/init.d
wget https://kosasih2885.googlecode.com/svn/unbound
chmod +x /etc/init.d/unbound
update-rc.d unbound defaults














